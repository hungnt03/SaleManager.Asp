using System;
using System.ComponentModel.DataAnnotations;

namespace SaleManager.Models.Repayment
{
    public class TransactionCustomerDetail
    {
        [Display(Name = "Ngày mua hàng")]
        public String CreatedAt { set; get; }
        [Display(Name = "Tên sản phẩm")]
        public String ProductName { set; get; }
        [Display(Name = "Giá")]
        public int Price { set; get; }
        [Display(Name = "Số lượng")]
        public int Quantity { set; get; }
        [Display(Name = "Thành tiền")]
        public int Total { set; get; }

        [Display(Name = "Tổng")]
        public int Ammount { set; get; }
        [Display(Name = "Khách đưa")]
        public int Payment { set; get; }
        [Display(Name = "Tiền thối")]
        public int PayBack { set; get; }
    }
}
