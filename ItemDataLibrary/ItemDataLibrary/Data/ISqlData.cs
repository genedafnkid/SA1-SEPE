using ItemDataLibrary.Models;

namespace ItemDataLibrary.Data
{
    public interface ISqlData
    {
        void AddItem(string Name, string Code, string Brand, decimal UnitPrice);
        List<ListItem> ListItems();
    }
}