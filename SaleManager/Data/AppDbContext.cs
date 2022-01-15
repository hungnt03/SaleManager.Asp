using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using SaleManager.Models;
using System;

namespace SaleManager.Data
{
    public class AppDbContext : IdentityDbContext<AppUser>
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

        protected override void OnModelCreating(ModelBuilder builder)
        {

            base.OnModelCreating(builder);
            // Bỏ tiền tố AspNet của các bảng: mặc định
            foreach (var entityType in builder.Model.GetEntityTypes())
            {
                var tableName = entityType.GetTableName();
                if (tableName.StartsWith("AspNet"))
                {
                    entityType.SetTableName(tableName.Substring(6));
                }
            }

            builder.Entity<TransactionDetail>().HasKey(p => new { p.TransactionId, p.ProductId });

            InitData(builder);
        }

        /// <summary>
        /// SeedData - chèn ngay bốn sản phẩm khi bảng Product được tạo
        /// </summary>
        /// <param name="builder"></param>
        private void InitData(ModelBuilder builder)
        {
            builder.Entity<Category>().HasData(
                new Category()
                {
                    CategoryName = "Thực phẩm",
                    CreatedAt = DateTime.Now,
                    CreatedBy = "Administrator",
                    Id = 1
                },
                new Category()
                {
                    CategoryName = "Mỹ phẩm",
                    CreatedAt = DateTime.Now,
                    CreatedBy = "Administrator",
                    Id = 2
                },
                new Category()
                {
                    CategoryName = "Bánh kẹo",
                    CreatedAt = DateTime.Now,
                    CreatedBy = "Administrator",
                    Id = 3
                },
                new Category()
                {
                    CategoryName = "Rượu bia",
                    CreatedAt = DateTime.Now,
                    CreatedBy = "Administrator",
                    Id = 4
                }, new Category()
                {
                    CategoryName = "Khác",
                    CreatedAt = DateTime.Now,
                    CreatedBy = "Administrator",
                    Id = 5
                });

            builder.Entity<Supplier>().HasData(
                new Supplier()
                {
                    Id = 1,
                    Name = "Bibica",
                    Address = "183 Hoàng Hoa Thám, Ngọc Hồ, Ba Đình, Hà Nội",
                    EmployeeName = "Nguyễn Thị Thuỷ",
                    Telephone = "02437281476",
                    CreatedAt = DateTime.Now,
                    CreatedBy = "Administrator"
                });

            builder.Entity<Unit>().HasData(
                new Unit()
                {
                    Id = 1,
                    Name = "Chai",
                });

            builder.Entity<Product>().HasData(
                new Product()
                {
                    Id = 1,
                    Barcode = "8004800008152",
                    CategoryId = 1,
                    CreatedAt = DateTime.Now,
                    CreatedBy = "Administrator",
                    Disable = false,
                    ExpirationDate = new DateTime(2030, 01, 01),
                    Name = "Bánh Sampa Balocco Savoiardi 200g",
                    Pin = true,
                    Price = 59000,
                    PriceBuy = 55000,
                    Quantity = 80,
                    SupplierId = 1,
                    UnitId = 1,
                },
                new Product()
                {
                    Id = 2,
                    Barcode = "8934637514871",
                    CategoryId = 1,
                    CreatedAt = DateTime.Now,
                    CreatedBy = "Administrator",
                    Disable = false,
                    ExpirationDate = new DateTime(2030, 01, 01),
                    Name = "Sốt ướp thịt nướng",
                    Pin = true,
                    Price = 10,
                    PriceBuy = 9,
                    Quantity = 1,
                    SupplierId = 1,
                    UnitId = 1,
                },
                new Product()
                {
                    Id = 3,
                    Barcode = "8934752060109",
                    CategoryId = 1,
                    CreatedAt = DateTime.Now,
                    CreatedBy = "Administrator",
                    Disable = false,
                    ExpirationDate = new DateTime(2030, 01, 01),
                    Name = "Dấm trung thành 500ml",
                    Pin = true,
                    Price = 10,
                    PriceBuy = 9,
                    Quantity = 1,
                    SupplierId = 1,
                    UnitId = 1,
                },
                new Product()
                {
                    Id = 4,
                    Barcode = "8934804004044",
                    CategoryId = 1,
                    CreatedAt = DateTime.Now,
                    CreatedBy = "Administrator",
                    Disable = false,
                    ExpirationDate = new DateTime(2030, 01, 01),
                    Name = "Dầu hào 350g",
                    Pin = true,
                    Price = 10,
                    PriceBuy = 9,
                    Quantity = 1,
                    SupplierId = 1,
                    UnitId = 1,
                }

            );
        }
        public DbSet<Category> Categories { set; get; }

        public DbSet<Product> Products { set; get; }
        public DbSet<Transaction> Transactions { set; get; }
        public DbSet<TransactionDetail> transactionDetails { set; get; }
        /// <summary>
        /// SeedData - chèn ngay bốn sản phẩm khi bảng Product được tạo
        /// </summary>
        /// <param name="builder"></param>
        public DbSet<SaleManager.Models.Customer> Customer { get; set; }

        /// <summary>
        /// SeedData - chèn ngay bốn sản phẩm khi bảng Product được tạo
        /// </summary>
        /// <param name="builder"></param>
        public DbSet<SaleManager.Models.Supplier> Supplier { get; set; }

        /// <summary>
        /// SeedData - chèn ngay bốn sản phẩm khi bảng Product được tạo
        /// </summary>
        /// <param name="builder"></param>
        public DbSet<SaleManager.Models.Unit> Unit { get; set; }
    }

}