using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using SaleManager.Data;
using SaleManager.Models;
using SaleManager.Models.Products;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SaleManager.Controllers
{
    public class SaleController : Controller
    {
        private readonly AppDbContext _context;
        public SaleController(AppDbContext context)
        {
            _context = context;
        }
        public async Task<IActionResult> IndexAsync()
        {
            ViewData["Customers"] = new SelectList(await _context.Customer.OrderBy(x => x.Name).ToListAsync(), "Id", "Name");
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Search(string condition)
        {
            var products = await _context.Products.Include(x => x.Unit)
                .Where(x => !x.Disable && (x.Barcode.Equals(condition) || x.Name.Contains(condition)))
                .Select(x => new
                {
                    Name = x.Name,
                    Price = x.Price,
                    Quantity = 1,
                    Unit = x.Unit.Name,
                    Id = x.Id,
                    Image = x.ImageUrl
                }).ToListAsync();

            return Json(new { data = products });
        }

        [HttpPost]
        public async Task<IActionResult> GetPinProduct()
        {
            var products = await _context.Products.Include(x => x.Unit)
                .Where(x => !x.Disable && x.Pin)
                .Select(x => new
                {
                    Name = x.Name,
                    Price = x.Price,
                    Unit = x.Unit.Name,
                    Id = x.Id,
                    Image = x.ImageUrl
                }).ToListAsync();

            return Json(new { data = products });
        }

        [HttpPost]
        public async Task<IActionResult> Pay(List<Order> orders, int payment, string note)
        {
            using var tran = _context.Database.BeginTransaction();
            try
            {
                var ids = orders.Select(x => x.Id).ToList();
                var products = await _context.Products.Where(x => ids.Contains(x.Id)).ToListAsync();
                var amount = 0;
                var transactionDetails = new List<TransactionDetail>();
                orders.ForEach(x =>
                {
                    var product = products.Find(p => p.Id == x.Id);
                    amount += (product.Price * x.Quantity);
                    products.Find(p => p.Id == x.Id).Quantity -= x.Quantity;
                });

                _context.Products.UpdateRange(products);

                var transaction = new Transaction()
                {
                    Ammount = amount,
                    BillNumber = _context.Transactions.Max(x => x.Id).ToString("000000000"),
                    CreatedAt = System.DateTime.Now,
                    CreatedBy = "Administrator",
                    Note = note,
                    PayBack = payment - amount,
                    Payment = payment,
                    //1: da thanh toan, 2:chua thanh toan, 3:thanh toan 1 phan
                    Status = (payment >= amount) ? 1 : (payment != 0) ? 3 : 2,
                    //1: nhập hàng, 2: bán hàng
                    Type = 2,
                };
                _context.Transactions.Add(transaction);
                _context.SaveChanges();

                orders.ForEach(x =>
                {
                    transactionDetails.Add(new TransactionDetail()
                    {
                        CreatedAt = System.DateTime.Now,
                        CreatedBy = "Administrator",
                        ProductId = x.Id,
                        Quantity = x.Quantity,
                        TransactionId = transaction.Id,
                    });
                });
                await _context.transactionDetails.AddRangeAsync(transactionDetails);
                _context.SaveChanges();
                tran.Commit();
            }
            catch (System.Exception ex)
            {
                tran.Rollback();
                return BadRequest(ex.Message);
            }

            return Ok();
        }
    }
}
