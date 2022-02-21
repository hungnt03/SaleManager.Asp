using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using CsvHelper;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SaleManager.Data;
using SaleManager.Models;
using SaleManager.Models.Products;
using SaleManager.Utils;

namespace SaleManager.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class TransactionController : Controller
    {
        private readonly AppDbContext _context;
        private readonly IWebHostEnvironment _hostingEnvironment;

        public TransactionController(AppDbContext context, IWebHostEnvironment hostingEnvironment)
        {
            _context = context;
            _hostingEnvironment = hostingEnvironment;
        }

        // GET: Admin/Transaction
        public async Task<IActionResult> Index()
        {
            return View(await _context.Transactions.ToListAsync());
        }

        [HttpGet]
        public IActionResult Import()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> ApiImportConfirm(IFormFile csv, IFormFile img)
        {
            if (csv == null || img == null) return NoContent();
            string path = Path.Combine(_hostingEnvironment.WebRootPath, "image\\transaction\\temp");
            System.IO.DirectoryInfo di = new DirectoryInfo(path);
            foreach (FileInfo file in di.GetFiles())
            {
                file.Delete();
            }

            string fileCsvName = Path.GetFileName(csv.FileName);
            string fileCsvPath = Path.Combine(path, fileCsvName);
            using (FileStream stream = new FileStream(fileCsvPath, FileMode.Create))
            {
                await csv.CopyToAsync(stream);
            }
            string fileImgName = Path.GetFileName(img.FileName);
            string fileImgPath = Path.Combine(path, fileImgName);
            using (FileStream stream = new FileStream(fileImgPath, FileMode.Create))
            {
                await img.CopyToAsync(stream);
            }

            var sreamreader = new StreamReader(fileCsvPath);
            var reader = new CsvReader(sreamreader, CultureInfo.InvariantCulture);
            var datas = reader.GetRecords<ImportProduct>().ToList();
            reader.Dispose();
            var errors = new List<KeyValue>();
            var validationResults = new List<ValidationResult>();
            foreach (var data in datas)
            {
                var context = new ValidationContext(data, serviceProvider: null, items: null);
                bool isValid = Validator.TryValidateObject(data, context, validationResults, true);
                if (!isValid)
                {
                    foreach (var err in validationResults)
                    {
                        errors.Add(new KeyValue(data.Barcode, err.ErrorMessage, data.Name));
                    }
                }
            }
            if (errors.Count > 0) return BadRequest(errors);

            return Json(new { data = datas, imgPath = fileImgPath.Replace(_hostingEnvironment.WebRootPath, "") });
        }

        [HttpPost]
        public async Task<IActionResult> ApiImport(IFormFile csv, IFormFile img)
        {
            string path = Path.Combine(_hostingEnvironment.WebRootPath, "image\\transaction\\" + DateTime.Now.ToString("yyyy-MM-dd"));
            bool exists = System.IO.Directory.Exists(path);
            if (!exists) System.IO.Directory.CreateDirectory(path);

            //Upload
            string fileCsvName = Path.GetFileName(csv.FileName);
            string fileCsvPath = Path.Combine(path, fileCsvName);
            using (FileStream stream = new FileStream(fileCsvPath, FileMode.Create))
            {
                await csv.CopyToAsync(stream);
            }
            string fileImgName = Path.GetFileName(img.FileName);
            string fileImgPath = Path.Combine(path, fileImgName);
            using (FileStream stream = new FileStream(fileImgPath, FileMode.Create))
            {
                await img.CopyToAsync(stream);
            }

            //Read
            var sreamreader = new StreamReader(fileCsvPath);
            var reader = new CsvReader(sreamreader, CultureInfo.InvariantCulture);
            var importDatas = reader.GetRecords<ImportProduct>().ToList();
            reader.Dispose();

            //Refactor and save data
            var barcodes = importDatas.Select(x => x.Barcode).ToList();
            var products = await _context.Products.Where(x => barcodes.Contains(x.Barcode)).ToListAsync();

            var total = 0;
            foreach (var product in products)
            {
                var import = importDatas.Where(x=>x.Barcode.Equals(product.Barcode)).FirstOrDefault();
                product.Quantity += import.Quantity;
                product.PriceBuy = import.PriceBuy;
                product.Price = (import.Price>0 && import.Price != product.Price) ? import.Price : product.Price;
                total += import.Quantity * import.PriceBuy;
            }

            //Save
            using var tran = _context.Database.BeginTransaction();
            try
            {
                _context.Products.UpdateRange(products);
                var transaction = new Transaction()
                {
                    Ammount = total,
                    BillNumber = _context.Transactions.Max(x => x.Id).ToString("000000000"),
                    CreatedAt = System.DateTime.Now,
                    CreatedBy = "Administrator",
                    Note = String.Empty,
                    PayBack = 0 - total,
                    Payment = 0,
                    //1: da thanh toan, 2:chua thanh toan, 3:thanh toan 1 phan
                    Status = TransStatus.UNPAID,
                    //1: nhập hàng, 2: bán hàng
                    Type = TransType.IMPORT,
                };
                _context.Transactions.Add(transaction);
                _context.SaveChanges();

                var transactionDetails = new List<TransactionDetail>();
                products.ForEach(x =>
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

                await _context.SaveChangesAsync();
                tran.Commit();
            }
            catch (Exception)
            {
                tran.Rollback();
                return BadRequest();
                throw;
            }

            return Ok();
        }

        // GET: Admin/Transaction/Details/5
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

        // GET: Admin/Transaction/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Admin/Transaction/Create
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

        // GET: Admin/Transaction/Edit/5
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

        // POST: Admin/Transaction/Edit/5
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

        // GET: Admin/Transaction/Delete/5
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

        // POST: Admin/Transaction/Delete/5
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
