using System.Collections.Generic;

namespace SaleManager.Models.Products
{
    public class PayRequest
    {
        public List<Order> Orders { set; get; }
        public int Payment { set; get; }
        public string Note { set; get; }
    }
}
