import 'dart:async';
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

//enum CategoryExpense {Unknown, HouseHold, OnlineShop, Kids, Education, OutSchool, Special, Others}
//enum TypeExpense {Unknown, HouseHold, OnlineShop, Kids, Education, OutSchool }  
class Expense{
  Expense(this.id, this.month, this.categoryID, this.typeID, this.amount, this.inputTime);
  int id;
  int month;
  int categoryID;
  int typeID;
  double amount;
  DateTime inputTime;

  Map toMap(){
    return {COL_MONTH : month
          , COL_CATEGORY: categoryID
          , COL_TYPE: typeID
          , COL_AMOUNT: amount
          , COL_INPUT_TIME: inputTime.toIso8601String() };
  }

  Expense.fromMap(Map map)
  {
    id = map[COL_ID];
    month = map[COL_MONTH];
    categoryID = map[COL_CATEGORY];
    typeID = map[COL_TYPE];
    amount = map[COL_AMOUNT];
    inputTime = DateTime.parse(map[COL_INPUT_TIME]);
  }
}

class MonthExpense{
  MonthExpense(this.month, this.totalAmount, this.household, this.wife, this.kids, this.others);
  int month;
  double totalAmount;
  double household;
  double wife;
  double kids;
  double others;
  
  List<Expense> listExpenses = new List();
}

final String TABLE_NAME = "expense";
final String COL_ID = "id";
final String COL_MONTH = "month";
final String COL_CATEGORY = "category";
final String COL_TYPE = "type";
final String COL_AMOUNT = "amount";
final String COL_INPUT_TIME = "inputtime";

class DBManager{
  Database database;
  Map<int, MonthExpense> months;
  Future openDB() async{
    if (database == null) {
      Directory directory = await getApplicationDocumentsDirectory();
      database = await openDatabase(
          join(directory.path, "notes.db"),
          version: 1,
          onCreate: (Database db, int version) async {
            await db.execute('''create table $TABLE_NAME (
            $COL_ID integer primary key autoincrement,
            $COL_MONTH integer not null,
            $COL_CATEGORY integer not null,
            $COL_TYPE integer not null,         
            $COL_AMOUNT real not null,
            $COL_INPUT_TIME text not null)''');
          }
      );
      List<Expense> listExpenses = await getExpenses();
      int month =0;
      for(int i = 0; i < 120; i++)
      {
        month = 100 * DateTime.now().year + DateTime.now().month - i;
        months.addAll({month : new MonthExpense(month, 0 , 0, 0,  0, 0)});
      }
      listExpenses.forEach((expense){
          if(!months.containsKey(expense.month)) 
          months.addAll({expense.month : new MonthExpense(expense.month, 0 , 0, 0,  0, 0)});
          
          switch (expense.categoryID) {
            case 1: // 家居開支
              months[expense.month].household += expense.amount;
              break;
            case 2: // 老婆開支
              months[expense.month].wife += expense.amount;
              break;
            case 3: // 囝囡開支
              months[expense.month].kids += expense.amount;     
              break;
            default:// 其他開出
              months[expense.month].others += expense.amount;                       
              break;
          } 
          months[expense.month].totalAmount += expense.amount;
          months[expense.month].listExpenses.add(expense);
      });
       
    }
  }

  Future<int> insert(Expense expense) async {
    return await database.insert(TABLE_NAME, expense.toMap());
  }

  Future<List<Expense>> getExpenses() async {
    await openDB();
    List<Map> entities = await database.rawQuery("select * from $TABLE_NAME");
    return entities
        .map((map) => new Expense.fromMap(map))
        .toList();
  }

  Future delete(int id) async {
    await openDB();
    await database.delete(TABLE_NAME, where: "$COL_ID = ?", whereArgs: [id]);
  }

  Future update(Expense expense) async {
    await openDB();
    await database.update(TABLE_NAME, expense.toMap(), where: "$COL_ID = ?", whereArgs: [expense.id]);
  }

  closeDb() {
    database.close();
  }
}
