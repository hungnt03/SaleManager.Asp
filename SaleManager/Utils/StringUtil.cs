using Microsoft.AspNetCore.Mvc.ModelBinding;
using Newtonsoft.Json;
using System.Collections.Generic;

namespace SaleManager.Utils
{
    public static class StringUtil
    {
        public static string ParseError(ModelStateDictionary modelState)
        {
            var errors = new List<string>();

            foreach (var state in modelState)
            {
                foreach (var error in state.Value.Errors)
                {
                    errors.Add(error.ErrorMessage);
                }
            }

            return JsonConvert.SerializeObject(errors);
        }
    }
}
