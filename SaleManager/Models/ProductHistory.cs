using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SaleManager.Models
{
    [Table("ProductHistory")]
    public class ProductHistory
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        [Required]
        public int ProductId { get; set; }
        [ForeignKey("ProductId")]
        public Product Product { set; get; }
        public string AttributeName { set; get; }
        public string FromValue { set; get; }
        public string ToValue { set; get; }
        public string CreateBy { set; get; }
        public DateTime CreateAt { set; get; }

        public ProductHistory(int productId, string attributeName, string fromValue, string toValue, DateTime createAt, string createBy)
        {
            this.ProductId = ProductId;
            this.AttributeName = attributeName;
            this.FromValue = fromValue;
            this.ToValue = toValue;
            this.CreateAt = createAt;
            this.CreateBy = createBy;
        }
    }
}
