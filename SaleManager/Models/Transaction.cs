using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SaleManager.Models
{
    [Table("Transaction")]
    public class Transaction : ModelBase
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        //1: nhập hàng, 2: bán hàng
        public int Type { set; get; }
        public int CustomerId { set; get; }
        public int SupplierId { set; get; }

        //1: da thanh toan, 2:chua thanh toan, 3:thanh toan 1 phan
        public int Status { set; get; }

        [Display(Name = "Tổng thanh toán")]
        public int Ammount { set; get; }
        [Display(Name = "Khách đưa")]
        public int Payment { set; get; }
        [Display(Name = "Tiền thối")]
        public int PayBack { set; get; }
        [Display(Name = "Số hóa đơn")]
        public string BillNumber { set; get; }

        [Display(Name = "Ghi chú")]
        [DataType(DataType.Text)]
        public string Note { set; get; }
    }
}
