namespace SaleManager.Models
{
    public class KeyValue
    {
        public string Key { get; set; }
        public string SubKey { get; set; }
        public string Value { get; set; }
        public KeyValue(string key, string value, string subkey = "")
        {
            Key = key;
            Value = value;
            SubKey = subkey;
        }
    }
}
