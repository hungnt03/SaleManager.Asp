using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SaleManager.Controllers;
using SaleManager.Data;
using SaleManager.Models.Repayment;
using SaleManager.Utils;

namespace SaleManager.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class RepaymentController : AbstractController
    {
        private readonly AppDbContext _context;

        public RepaymentController(AppDbContext context)
        {
            _context = context;
        }

        // GET: Admin/Repayment
        public IActionResult Index()
        {
            return Redirect("~/admin/repayment/customer");
        }

        // Get: Admin/Repayment/customer
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

        // Get: Admin/Repayment/customerDetail
        public async Task<IActionResult> CustomerDetail(string date, int customer)
        {
            var buyedDate = Convert.ToDateTime(date);
            var dbFunc = Microsoft.EntityFrameworkCore.EF.Functions;
            var transactions = await _context.Transactions
                .Where(x => x.CustomerId == customer && buyedDate.Date.Equals(x.CreatedAt.Value.Date))
                .Select(x => x.Id).ToListAsync();
            var details = await _context.transactionDetails
                .Include(x => x.Product)
                .Where(x => transactions.Contains(x.TransactionId))
                .Select(x=> new TransactionCustomerDetail()
                {
                    CreatedAt = x.CreatedAt.Value.ToShortDateString(),
                    ProductName = x.Product.Name,
                    Price = x.Product.Price,
                    Quantity = x.Quantity,
                    Total = x.Product.Price * x.Quantity
                })
                .ToListAsync();

            return View(details);
        }

        // Post:Api: 
        [HttpPost]
        public async Task<IActionResult> ApiCustomerDetails(int? id)
        {
            if (id == null) {
                ModelState.AddModelError("", String.Format(ErrMess.Required, "Mã khách hàng"));
                return Bad(ModelState);
            }

            var sql = await _context.Transactions.Where(x => x.Type == TransType.SELL && x.Status != TransStatus.PAID && x.CustomerId == id)
                //.GroupBy(x => x.CreatedAt.Value.ToShortDateString())
                .Select(x => new TransactionCustomerDetail
                {
                    CreatedAt = x.CreatedAt.Value.ToShortDateString(),
                    Ammount = x.Ammount,
                    Payment = x.Payment,
                    PayBack = x.PayBack
                })
                .ToListAsync();
            var transactions = sql.GroupBy(x => x.CreatedAt).Select(x => new TransactionCustomerDetail()
            {
                CreatedAt = x.Key,
                Ammount = x.Sum(s => s.Ammount),
                Payment = x.Sum(s => s.Payment),
                PayBack = x.Sum(s => s.PayBack)
            }).ToArray();
            return Json(new { data = transactions });
        }

        // Get: Admin/Repayment/customer
        [HttpPost]
        public async Task<IActionResult> ApiCustomerPay(int id, List<string> dates)
        {
            var dateRanges = new List<DateTime>();
            foreach(var elm in dates)
            {
                dateRanges.Add(Convert.ToDateTime(elm).Date);
            }
            var trans = await _context.Transactions
                .Where(x => x.CustomerId == id && dateRanges.Contains(x.CreatedAt.Value.Date)).ToListAsync();
            if(trans == null || trans.Count == 0)
            {
                ModelState.AddModelError("", ErrMess.NotExits);
                return Bad(ModelState);
            }
            foreach(var elm in trans)
            {
                elm.Status = TransStatus.PAID;
                elm.UpdatedAt = DateTime.Now;
                elm.UpdatedBy = "Administrator";
            }
            await _context.SaveChangesAsync();
            return Json(new {  });
        }

        public IActionResult Supplier()
        {
            var tranSupplier = _context.Transactions
                .Where(x => x.Type == TransType.IMPORT && x.Status != TransStatus.PAID)
                .GroupBy(x => x.SupplierId)
                .Select(x => new
                {
                    SupplierId = x.Key,
                    Total = x.Sum(s => s.PayBack)
                }).AsEnumerable();
            var suppiers = tranSupplier
                .Join(_context.Supplier, t => t.SupplierId, c => c.Id, (trans, supplier) => new TransactionSupplier
                {
                    SupplierId = supplier.Id,
                    SupplierName = supplier.Name,
                    EmployeeName = supplier.EmployeeName,
                    Telephone = supplier.Telephone,
                    Total = trans.Total * (-1),
                }).OrderBy(x => x.EmployeeName).ToList();
            return View(suppiers);
        }

        public async Task<IActionResult> ApiSupplierDetail(int? id)
        {
            if (id == null)
            {
                ModelState.AddModelError("", String.Format(ErrMess.Required, "Mã nhà cung cấp"));
                return Bad(ModelState);
            }

            var sql = await _context.Transactions.Where(x => x.Type == TransType.IMPORT && x.Status != TransStatus.PAID && x.SupplierId == id)
                .Select(x => new TransactionCustomerDetail
                {
                    CreatedAt = x.CreatedAt.Value.ToShortDateString(),
                    Ammount = x.Ammount,
                    Payment = x.Payment,
                    PayBack = x.PayBack
                })
                .ToListAsync();
            var transactions = sql.GroupBy(x => x.CreatedAt).Select(x => new TransactionCustomerDetail()
            {
                CreatedAt = x.Key,
                Ammount = x.Sum(s => s.Ammount),
                Payment = x.Sum(s => s.Payment),
                PayBack = x.Sum(s => s.PayBack)
            }).ToArray();
            return Json(new { data = transactions });
        }

        // Get: Admin/Repayment/supplierDetail
        public async Task<IActionResult> SupplierDetail(string date, int supplierId)
        {
            var buyedDate = Convert.ToDateTime(date);
            var dbFunc = Microsoft.EntityFrameworkCore.EF.Functions;
            var transactions = await _context.Transactions
                .Where(x => x.SupplierId == supplierId && buyedDate.Date.Equals(x.CreatedAt.Value.Date))
                .Select(x => x.Id).ToListAsync();
            var details = await _context.transactionDetails
                .Include(x => x.Product)
                .Where(x => transactions.Contains(x.TransactionId))
                .Select(x => new TransactionCustomerDetail()
                {
                    CreatedAt = x.CreatedAt.Value.ToShortDateString(),
                    ProductName = x.Product.Name,
                    Price = x.Product.PriceBuy,
                    Quantity = x.Quantity,
                    Total = x.Product.Price * x.Quantity
                })
                .ToListAsync();

            return View(details);
        }

        // Post: Admin/Repayment/supplier
        [HttpPost]
        public async Task<IActionResult> ApiSupplierPay(int id, List<string> dates)
        {
            var dateRanges = new List<DateTime>();
            foreach (var elm in dates)
            {
                dateRanges.Add(Convert.ToDateTime(elm).Date);
            }
            var trans = await _context.Transactions
                .Where(x => x.SupplierId == id && dateRanges.Contains(x.CreatedAt.Value.Date)).ToListAsync();
            if (trans == null || trans.Count == 0)
            {
                ModelState.AddModelError("", ErrMess.NotExits);
                return Bad(ModelState);
            }
            foreach (var elm in trans)
            {
                elm.Status = TransStatus.PAID;
                elm.UpdatedAt = DateTime.Now;
                elm.UpdatedBy = "Administrator";
            }
            await _context.SaveChangesAsync();
            return Json(new { });
        }
    }
}
