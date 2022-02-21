using System;
using System.ComponentModel.DataAnnotations;

namespace SaleManager.Models.Repayment
{
    public class TransactionSupplier
    {
        public int SupplierId { set; get; }
        [Display(Name = "Tên nhà cung cấp")]
        public String SupplierName { set; get; }
        [Display(Name = "Tên nhân viên")]
        public String EmployeeName { set; get; }
        [Display(Name = "Số điện thoại")]
        public string Telephone { set; get; }
        [Display(Name = "Tổng nợ")]
        public int Total { set; get; }
    }
}
