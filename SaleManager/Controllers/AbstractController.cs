using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using SaleManager.Data;
using SaleManager.Utils;

namespace SaleManager.Controllers
{
    public class AbstractController : Controller
    {
        public AbstractController()
        {
            
        }

        protected IActionResult Bad(ModelStateDictionary modelState)
        {
            return BadRequest(StringUtil.ParseError(modelState));
        }
    }
}
