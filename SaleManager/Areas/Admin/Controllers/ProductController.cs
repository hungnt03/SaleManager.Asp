using CsvHelper;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using SaleManager.Data;
using SaleManager.Models;
using SaleManager.Models.Products;
using SaleManager.Utils;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;

namespace SaleManager.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class ProductController : Controller
    {
        private readonly AppDbContext _context;
        private readonly IWebHostEnvironment _hostingEnvironment;

        public ProductController(AppDbContext context, IWebHostEnvironment hostingEnvironment)
        {
            _context = context;
            _hostingEnvironment = hostingEnvironment;
        }

        public const int ITEMS_PER_PAGE = 2;

        // GET: Admin/Product
        public async Task<IActionResult> Index([Bind(Prefix = "page")] int pageNumber = 0, string searchString = "", int categoryId = -1, int supplierId = -1)
        {
            //if (pageNumber == 0) pageNumber = 1;

            //var products = _context.Products
            //    .Include(p => p.Unit).Include(p => p.category).Include(p => p.supplier)
            //    .Where(x => !x.Disable && (string.IsNullOrEmpty(searchString) || x.Name.Contains(searchString)) &&
            //              (categoryId == -1 || x.category.Id == categoryId) && (supplierId == -1 || x.supplier.Id == supplierId))
            //    .OrderByDescending(p => p.Name);


            //// Lấy tổng số dòng dữ liệu
            //var totalItems = products.Count();
            //// Tính số trang hiện thị (mỗi trang hiện thị ITEMS_PER_PAGE mục)
            //int totalPages = (int)Math.Ceiling((double)totalItems / ITEMS_PER_PAGE);

            //if (pageNumber > totalPages)
            //    return RedirectToAction(nameof(ProductController.Index), new { page = totalPages });

            //var results = await products
            //    .Skip(ITEMS_PER_PAGE * (pageNumber - 1))
            //    .Take(ITEMS_PER_PAGE)
            //    .ToListAsync();

            //// return View (await products.ToListAsync());
            //ViewData["pageNumber"] = pageNumber;
            //ViewData["totalPages"] = totalPages;

            var categories = await _context.Categories.Select(x => new { Id = x.Id, Name = x.CategoryName }).ToListAsync();
            var suppliers = await _context.Supplier.Select(x => new { Id = x.Id, Name = x.Name + " - " + x.EmployeeName }).ToListAsync();
            ViewData["categories"] = new SelectList(categories, "Id", "Name");
            ViewData["suppliers"] = new SelectList(suppliers, "Id", "Name");

            //return View(results.AsEnumerable());

            return View();
        }

        //
        [HttpPost]
        public async Task<IActionResult> ListData()
        {
            var products = await _context.Products.Include(x => x.Unit).Select(x => new
            {
                Id = x.Id,
                Name = x.Name,
                Price = x.Price,
                Quantity = x.Quantity,
                Unit = x.Unit.Name,
                expirationDate = x.ExpirationDate,
                disable = x.Disable
            }).ToListAsync();

            return Json(new { data = products });
        }

        [HttpGet]
        public async Task<IActionResult> ExportTemplateAsync()
        {
            var stream = new MemoryStream();
            var streamWriter = new StreamWriter(stream, Encoding.UTF8, 1024, true);
            var csv = new CsvWriter(streamWriter, CultureInfo.InvariantCulture);
            var datas = new List<ImportProduct>();
            datas.Add(new ImportProduct()
            {
                Barcode = "8004800008152",
                Name = "Bánh Sampa Balocco Savoiardi 200g",
                Quantity = 80,
                Price = 59000,
                PriceBuy = 55000
            });
            await csv.WriteRecordsAsync(datas);
            await streamWriter.FlushAsync();
            return File(stream.ToArray(), "text/csv", "import.csv");
        }

        [HttpPost]
        public async Task<IActionResult> ImportAsync(IFormFile csv)
        {
            //read
            if (csv == null) return NoContent();
            string path = Path.Combine(_hostingEnvironment.WebRootPath, "template");
            string fileName = Path.GetFileName(csv.FileName);
            string filePath = Path.Combine(path, fileName);
            using (FileStream stream = new FileStream(filePath, FileMode.Create))
            {
                csv.CopyTo(stream);
            }
            var sreamreader = new StreamReader(filePath);
            var reader = new CsvReader(sreamreader, CultureInfo.InvariantCulture);
            var datas = reader.GetRecords<ImportProduct>().ToList();
            reader.Dispose();
            System.IO.File.Delete(filePath);
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


            //refactor data
            var barcodes = datas.Select(x => x.Barcode).ToList();
            var exitsDatas = _context.Products.Where(x => barcodes.Contains(x.Barcode)).ToList();
            if (exitsDatas.Count > 0) return Conflict(exitsDatas.ToArray());
            var products = new List<Product>();
            var amount = 0;            
            foreach (var import in datas)
            {
                products.Add(new Product(import));
                amount += import.Price.Value * import.Quantity;
            }

            using var tran = _context.Database.BeginTransaction();
            try
            {
                _context.Products.AddRange(products);
                var transaction = new Transaction()
                {
                    Ammount = amount,
                    BillNumber = _context.Transactions.Max(x => x.Id).ToString("000000000"),
                    CreatedAt = System.DateTime.Now,
                    CreatedBy = "Administrator",
                    Note = String.Empty,
                    PayBack = 0 - amount,
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
            catch (Exception ex)
            {
                tran.Rollback();
                return BadRequest(ex.Message);
            }
            

            return Ok();
        }

        [HttpPost]
        public async Task<IActionResult> Uploader(IFormFile image, string secret)
        {
            string filename = ContentDispositionHeaderValue.Parse(image.ContentDisposition).FileName.Trim('"');

            filename = this.EnsureCorrectFilename(filename);
            if (!string.IsNullOrEmpty(secret))
            {
                var fileNames = filename.Split('.');
                filename = secret + "." + fileNames[fileNames.Length - 1];
            }

            if ((System.IO.File.Exists(filename))) System.IO.File.Delete(filename);

            using (FileStream output = System.IO.File.Create(this.GetPathAndFilename(filename)))
                await image.CopyToAsync(output);

            return Json(new { data = "image/product/" + filename });
        }

        // GET: Admin/Product/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var product = await _context.Products
                .Include(p => p.Unit)
                .Include(p => p.category)
                .Include(p => p.supplier)
                .FirstOrDefaultAsync(m => m.Id == id);
            if (product == null)
            {
                return NotFound();
            }

            return View(product);
        }

        // GET: Admin/Product/Create
        public IActionResult Create()
        {
            ViewData["UnitId"] = new SelectList(_context.Set<Unit>(), "Id", "Name");
            ViewData["CategoryId"] = new SelectList(_context.Categories, "Id", "CategoryName");
            ViewData["SupplierId"] = new SelectList(_context.Supplier, "Id", "Id");
            return View();
        }

        // POST: Admin/Product/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,Barcode,CategoryId,SupplierId,Name,Quantity,Price,PriceBuy,ExpRange,ExpirationDate,UnitId,ImageUrl,Pin,Disable,CreatedBy,UpdatedBy,CreatedAt,UpdatedAt")] Product product)
        {
            if (ModelState.IsValid)
            {
                _context.Add(product);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["UnitId"] = new SelectList(_context.Set<Unit>(), "Id", "Name", product.UnitId);
            ViewData["CategoryId"] = new SelectList(_context.Categories, "Id", "CategoryName", product.CategoryId);
            ViewData["SupplierId"] = new SelectList(_context.Supplier, "Id", "Id", product.SupplierId);
            return View(product);
        }

        // GET: Admin/Product/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var product = await _context.Products.FindAsync(id);
            if (product == null)
            {
                return NotFound();
            }
            ViewData["UnitId"] = new SelectList(_context.Set<Unit>(), "Id", "Name");
            ViewData["CategoryId"] = new SelectList(_context.Categories, "Id", "CategoryName");
            ViewData["SupplierId"] = new SelectList(_context.Supplier, "Id", "EmployeeName");
            return View(product);
        }

        // POST: Admin/Product/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Id,Barcode,CategoryId,SupplierId,Name,Quantity,Price,PriceBuy,ExpRange,ExpirationDate,UnitId,ImageUrl,Pin,Disable,CreatedBy,UpdatedBy,CreatedAt,UpdatedAt")] Product product)
        {
            if (id != product.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(product);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ProductExists(product.Id))
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
            ViewData["UnitId"] = new SelectList(_context.Set<Unit>(), "Id", "Name", product.UnitId);
            ViewData["CategoryId"] = new SelectList(_context.Categories, "Id", "CategoryName", product.CategoryId);
            ViewData["SupplierId"] = new SelectList(_context.Supplier, "Id", "Id", product.SupplierId);
            return View(product);
        }

        // GET: Admin/Product/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var product = await _context.Products
                .Include(p => p.Unit)
                .Include(p => p.category)
                .Include(p => p.supplier)
                .FirstOrDefaultAsync(m => m.Id == id);
            if (product == null)
            {
                return NotFound();
            }

            return View(product);
        }

        // POST: Admin/Product/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var product = await _context.Products.FindAsync(id);
            _context.Products.Remove(product);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }



        #region 'xx'
        private bool ProductExists(int id)
        {
            return _context.Products.Any(e => e.Id == id);
        }
        private string GetPathAndFilename(string filename)
        {
            return this._hostingEnvironment.WebRootPath + "\\image\\product\\" + filename;
        }

        private string EnsureCorrectFilename(string filename)
        {
            if (filename.Contains("\\"))
                filename = filename.Substring(filename.LastIndexOf("\\") + 1);

            return filename;
        }
        #endregion
    }
}
