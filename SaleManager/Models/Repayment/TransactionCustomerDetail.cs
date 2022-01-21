using System;
using System.ComponentModel.DataAnnotations;

namespace SaleManager.Models.Repayment
{
    public class TransactionCustomerDetail
    {
        [Display(Name = "Ngày mua hàng")]
        public DateTime CreatedAt { set; get; }
        [Display(Name = "Tên sản phẩm")]
        public String ProductName { set; get; }
        [Display(Name = "Số lượng")]
        public int Quantity { set; get; }
        [Display(Name = "Thành tiền")]
        public Decimal Total { set; get; }
    }
}
