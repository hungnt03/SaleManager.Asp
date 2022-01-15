using SaleManager.Models.Products;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SaleManager.Models
{
    [Table("Product")]
    public class Product : ModelBase
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        [Display(Name = "Mã vạch")]
        [Required(ErrorMessage = "Mã vạch không đựơc để trống")]
        [StringLength(16)]
        public string Barcode { set; get; }

        [Display(Name = "Danh mục")]
        public int? CategoryId { set; get; }
        [ForeignKey("CategoryId")]
        public Category category { set; get; }

        [Display(Name = "Nhà cung cấp")]
        public int? SupplierId { set; get; }
        [ForeignKey("SupplierId")]
        public Supplier supplier { set; get; }

        [Display(Name = "Tên hàng hoá")]
        [Required(ErrorMessage = "Tên hàng hoá không đựơc để trống")]
        public string Name { set; get; }

        [Display(Name = "Số lượng")]
        [Range(0, 100000)]
        public int Quantity { set; get; }

        [Display(Name = "Giá bán")]
        [Column(TypeName = "Money")]
        [Required(ErrorMessage = "Giá bán không đựơc để trống")]
        public int Price { set; get; }

        [Display(Name = "Giá nhập")]
        [Column(TypeName = "Money")]
        [Required(ErrorMessage = "Giá nhập không đựơc để trống")]
        public int PriceBuy { set; get; }

        public int? ExpRange { set; get; }

        [Display(Name = "Hạn sử dụng")]
        public DateTime? ExpirationDate { set; get; }

        [Display(Name = "Đơn vị")]
        public int UnitId { set; get; }
        [Display(Name = "Đơn vị")]
        [ForeignKey("UnitId")]
        public Unit Unit { get; set; }

        [Display(Name = "Ảnh minh hoạ")]
        public string ImageUrl { set; get; }

        [Display(Name = "Ghim lên trang chủ")]
        public bool Pin { set; get; }

        // true: dung ban, false: dang ban
        [Display(Name = "Dừng bán")]
        public bool Disable { set; get; }

        public ICollection<ProductHistory> histories { set; get; }

        public Product() { }
        public Product(ImportProduct import)
        {
            Barcode = import.Barcode;
            Quantity = import.Quantity;
            Price = import.Price;
            PriceBuy = import.PriceBuy;
            Name = import.Name;
            CategoryId = 1;
            SupplierId = 1;
            UnitId = 1;
            CreatedBy = "Administrator";
            CreatedAt = DateTime.Now;
            ImageUrl = "image/no-image-icon.png";
        }
    }
}
