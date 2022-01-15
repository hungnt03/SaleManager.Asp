using System;
using System.ComponentModel.DataAnnotations;

namespace SaleManager.Models
{
    public class ModelBase
    {
        [Display(Name = "Người tạo")]
        public string CreatedBy { set; get; }
        [Display(Name = "Người sửa")]
        public string UpdatedBy { set; get; }

        [Display(Name = "Ngày tạo")]
        public DateTime? CreatedAt { set; get; }

        [Display(Name = "Ngày cập nhật")]
        public DateTime? UpdatedAt { set; get; }
    }
}
