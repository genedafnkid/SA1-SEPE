using ItemDataLibrary.Models;

namespace ItemDataLibrary.Data
{
    public interface ISqlData
    {
        void AddItem(string Name, string Code, string Brand, decimal UnitPrice);
        void DeleteItem(int id);
        List<ListItem> ListItems();
    }
}