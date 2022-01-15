using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SaleManager.Models
{
    [Table("TransactionDetail")]
    public class TransactionDetail : ModelBase
    {
        public int TransactionId { get; set; }
        [ForeignKey("TransactionId")]
        public Transaction Transaction { get; set; }

        public int ProductId { set; get; }
        [ForeignKey("ProductId")]
        public Product Product { set; get; }

        [Display(Name = "Số lượng")]
        public int Quantity { set; get; }
    }
}
