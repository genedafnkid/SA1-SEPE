using ItemDataLibrary.Database;
using ItemDataLibrary.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ItemDataLibrary.Data
{
    public class SqlData : ISqlData
    {
        private ISqlDataAccess _db;
        private const string connectionStringName = "SqlDb";

        public SqlData(ISqlDataAccess db)
        {
            _db = db;
        }

        public void AddItem(string Name, string Code, string Brand, decimal UnitPrice)
        {
            _db.SaveData<dynamic>(
                "dbo.Item_Add",
                new { Name, Code, Brand, UnitPrice },
                connectionStringName,
                true);
        }

        public List<ListItem> ListItems()
        {
            return _db.LoadData<ListItem, dynamic>("dbo.Item_List", new { }, connectionStringName, true).ToList();
        }
    }
}
