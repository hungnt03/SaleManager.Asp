using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SaleManager.Models
{
    [Table("Unit")]
    public class Unit : ModelBase
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        [Required(ErrorMessage = "Tên đơn vị không đựơc để trống")]
        [Display(Name = "Tên đơn vị")]
        [StringLength(200)]
        public string Name { get; set; }
    }
}
