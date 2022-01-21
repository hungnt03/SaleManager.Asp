using System;
using System.ComponentModel.DataAnnotations;

namespace SaleManager.Models.Repayment
{
    public class TransactionCustomer
    {
        public int CustomerId { set; get; }
        [Display(Name = "Tên khách hàng")]
        public String CustomerName { set; get; }
        [Display(Name = "Số điện thoại")]
        public string Telephone { set; get; }
        [Display(Name = "Tổng nợ")]
        public int Total { set; get; }
    }
}
