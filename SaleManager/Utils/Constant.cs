namespace SaleManager.Utils
{
    public static class TransStatus
    {
        //1: da thanh toan, 2:chua thanh toan, 3:thanh toan 1 phan
        public static int PAID = 1;
        public static int UNPAID = 2;
        public static int PARTIAL_PAYMENT = 3;
    }

    public static class TransType
    {
        //1: nhập hàng, 2: bán hàng
        public const int IMPORT = 1;
        public const int SELL = 2;
    }
}
