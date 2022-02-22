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

    public static class ErrMess
    {
        public static string Required = "{0} không được để trống.";
        public static string NotExits = "Không tìm thấy dữ liệu phù hợp.";
        public static string Annonymus = "Có lỗi xảy ra, vui lòng thử lại !.";
    }
}
