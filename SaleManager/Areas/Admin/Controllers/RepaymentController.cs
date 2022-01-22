using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using SaleManager.Data;
using SaleManager.Models;
using SaleManager.Models.Repayment;
using SaleManager.Utils;

namespace SaleManager.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class RepaymentController : Controller
    {
        private readonly AppDbContext _context;

        public RepaymentController(AppDbContext context)
        {
            _context = context;
        }

        // GET: Admin/Repayment
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Customer()
        {
            var tranCustomer = _context.Transactions
                .Where(x => x.Type == TransType.SELL && x.Status != TransStatus.PAID)
                .GroupBy(x => x.CustomerId)
                .Select(x => new
                {
                    CustomerId = x.Key,
                    Total = x.Sum(s => s.PayBack)
                }).AsEnumerable();
            var customers = tranCustomer
                .Join(_context.Customer, t => t.CustomerId, c => c.Id, (trans, cus) => new TransactionCustomer
            {
                CustomerId = cus.Id,
                CustomerName = cus.Name,
                Telephone = cus.Telephone,
                Total = trans.Total * (-1),
            }).OrderBy(x => x.CustomerName).ToList();
            return View(customers);
        }

        [HttpPost]
        public async Task<IActionResult> ApiCustomerDetails(int? id)
        {
            if (id == null) return NotFound();

            var transactions = await _context.Transactions.Where(x => x.Type == TransType.SELL && x.Status != TransStatus.PAID && x.CustomerId == id)
                .GroupBy(x => x.CreatedAt.Value.ToShortDateString())
                .Select(x => new TransactionCustomerDetail
                {
                    CreatedAt = x.Key,
                    Ammount = x.Sum(s=>s.Ammount),
                    Payment = x.Sum(s=>s.Payment),
                    PayBack = x.Sum(s => s.PayBack)
                }).ToArrayAsync();
            return Json(new {data = transactions });
        }

        [HttpPost]
        public IActionResult ListData()
        {
            var tranSupplier = _context.Transactions.Where(x => x.Type == TransType.IMPORT && x.Status != TransStatus.PAID)
                .GroupBy(x => x.SupplierId)
                .Select(x => new
                {
                    SupplierId = x.Key,
                    Total = x.Sum(s => s.PayBack)
                }).AsEnumerable();
            var suppliers = tranSupplier
                .Join(_context.Supplier, t => t.SupplierId, s => s.Id, (trans, supp) => new
                {
                    SupplierId = supp.Id,
                    SupplierName = supp.Name,
                    EmployeeName = supp.EmployeeName,
                    Telephone = supp.Telephone,
                    Total = trans.Total*(-1),
                }).ToList();


            var tranCustomer = _context.Transactions.Where(x => x.Type == TransType.SELL && x.Status != TransStatus.PAID)
                .GroupBy(x => x.CustomerId)
                .Select(x => new
                {
                    CustomerId = x.Key,
                    Total = x.Sum(s => s.PayBack)
                }).AsEnumerable();
            var customers = tranCustomer.Join(_context.Customer, t => t.CustomerId, c => c.Id, (trans, cus) => new
            {
                CustomerId = cus.Id,
                CustomerName = cus.Name,
                Telephone = cus.Telephone,
                Total = trans.Total*(-1),
            }).ToList();
            return Json(new { suppliers = suppliers, customers = customers });
        }

        // GET: Admin/Repayment/Details/5
        public async Task<IActionResult> CustomerDetails(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var transactions = await _context.Transactions
                .Where(x => x.CustomerId == id && x.Type == TransType.SELL && x.Status != TransStatus.PAID)
                .GroupJoin(_context.transactionDetails.Include(x => x.Product), t => t.Id, d => d.TransactionId, (t, d) => new { t, d })
                .SelectMany(x => x.d.DefaultIfEmpty(), (x, d) => new TransactionCustomerDetail
                {
                    CreatedAt = x.t.CreatedAt.Value,
                    ProductName = d.Product.Name,
                    Quantity = d.Quantity,
                    Total = d.Quantity * d.Product.Price
                })
                .ToListAsync();
            if (transactions == null)
            {
                return NotFound();
            }

            return View(transactions);
        }

        // GET: Admin/Repayment/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var transaction = await _context.Transactions
                .FirstOrDefaultAsync(m => m.Id == id);
            if (transaction == null)
            {
                return NotFound();
            }

            return View(transaction);
        }

        // GET: Admin/Repayment/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Admin/Repayment/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,Type,CustomerId,SupplierId,Status,Ammount,Payment,PayBack,BillNumber,Note,CreatedBy,UpdatedBy,CreatedAt,UpdatedAt")] Transaction transaction)
        {
            if (ModelState.IsValid)
            {
                _context.Add(transaction);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(transaction);
        }

        // GET: Admin/Repayment/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var transaction = await _context.Transactions.FindAsync(id);
            if (transaction == null)
            {
                return NotFound();
            }
            return View(transaction);
        }

        // POST: Admin/Repayment/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Id,Type,CustomerId,SupplierId,Status,Ammount,Payment,PayBack,BillNumber,Note,CreatedBy,UpdatedBy,CreatedAt,UpdatedAt")] Transaction transaction)
        {
            if (id != transaction.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(transaction);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!TransactionExists(transaction.Id))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            return View(transaction);
        }

        // GET: Admin/Repayment/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var transaction = await _context.Transactions
                .FirstOrDefaultAsync(m => m.Id == id);
            if (transaction == null)
            {
                return NotFound();
            }

            return View(transaction);
        }

        // POST: Admin/Repayment/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var transaction = await _context.Transactions.FindAsync(id);
            _context.Transactions.Remove(transaction);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool TransactionExists(int id)
        {
            return _context.Transactions.Any(e => e.Id == id);
        }
    }
}
