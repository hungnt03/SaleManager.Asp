using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SaleManager.Models
{
    [Table("Customer")]
    public class Customer : ModelBase
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        [Display(Name = "Tên khách hàng")]
        [MaxLength(100, ErrorMessage = "{0} không được vượt quá {1} ký tự.")]
        public string Name { get; set; }

        [Display(Name = "Địa chỉ")]
        public string Address { set; get; }

        [Display(Name = "Số di động")]
        [RegularExpression(@"^(0|\+84)(\s|\.)?((3[2-9])|(5[689])|(7[06-9])|(8[1-689])|(9[0-46-9]))(\d)(\s|\.)?(\d{3})(\s|\.)?(\d{3})$", ErrorMessage = "{0} sai định dạng.")]
        [DataType(DataType.PhoneNumber)]
        public string Telephone { set; get; }

        [Display(Name = "Số máy bàn")]
        [RegularExpression(@"^(0|\+84)(\s|\.)?((3[2-9])|(5[689])|(7[06-9])|(8[1-689])|(9[0-46-9]))(\d)(\s|\.)?(\d{3})(\s|\.)?(\d{3})$", ErrorMessage = "{0} sai định dạng.")]
        [DataType(DataType.PhoneNumber)]
        public string HomePhone { set; get; }
    }
}
