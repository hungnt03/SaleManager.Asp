using System.ComponentModel.DataAnnotations;

namespace SaleManager.Models.Products
{
    public class ImportProduct
    {
        [Display(Name = "Mã vạch")]
        [Required(ErrorMessage = "Mã vạch không đựơc để trống")]
        [StringLength(16)]
        public string Barcode { set; get; }

        [Display(Name = "Tên hàng hoá")]
        [Required(ErrorMessage = "Tên hàng hoá không đựơc để trống")]
        public string Name { set; get; }

        [Display(Name = "Số lượng")]
        [Range(0, 100000)]
        public int Quantity { set; get; }

        [Display(Name = "Giá bán")]
        [Required(ErrorMessage = "Giá bán không đựơc để trống")]
        public int PriceBuy { set; get; }

        [Display(Name = "Giá nhập")]
        [Required(ErrorMessage = "Giá nhập không đựơc để trống")]
        public int Price { set; get; }
    }
}
