using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using Xamarin.Forms;
using SQLitePCL;

namespace MyHomeExpense
{

    public partial class MainPage : ContentPage
    {
        static DatabaseExpense database;
        public MainPage()
        {
            InitializeComponent();
        }

        public static DatabaseExpense Database
        {
            get
            {
                if (database == null)
                {
                    database = new DatabaseExpense(Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData), "myhomeexpense.db3"));
                }

                return database;
            }
        }

        public class DatabaseExpense
        {
            public DatabaseExpense(string dbPath)
            {
                database = new SQLite.SQLiteAsyncConnection(dbPath);
                database.CreateTableAsync<MonthExpense>().Wait();
                database.CreateTableAsync<MonthExpense.Expense>().Wait();
            }
        }
    }



    public class MonthExpense
    {
        public enum CategoryExpense : int { Unknown = 0, HouseHold = 1, OnlineShop = 2, Kids = 3, Education = 4, OutSchool = 5, Special = 6, Others = 7 };
        public enum TypeExpense : int { Unknown = 0, HouseHold = 1, OnlineShop = 2, Kids = 3, Education = 4, OutSchool = 5 };

        public int ID { get; set; }
        public DateTime Month { get; set; }
        public double TotalAmount { get; set; }
        public double HouseHold { get; set; }
        public double OnlineShop { get; set; }
        public double Kids { get; set; }
        public double Education { get; set; }
        public double OutSchool { get; set; }
        public double Special { get; set; }
        public double Others { get; set; }

        public class Expense
        {
            public int ID { get; set; }
            public DateTime InputTime { get; set; }
            public CategoryExpense Category { get; set; }
            public TypeExpense Type { get; set; }
            public double Amount { get; set; }
        }
    }
}