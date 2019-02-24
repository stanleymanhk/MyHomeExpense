import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yshomeexpense/expense.dart';

class DBHelper{
  Database database;
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
       
    }
  }

  Future<int> insert(Expense expense) async {
    await database.insert(TABLE_NAME, expense.toMap());
    List<Map>  entity = await database.rawQuery("select $COL_ID from $TABLE_NAME where $COL_INPUT_TIME ='"+ expense.inputTime.toIso8601String() +"' limit 1");
    if( entity.length == 0) return 0;
    return entity[0]["$COL_ID"];
  }

  Future update(Expense expense) async {
    await openDB();
    await database.update(TABLE_NAME, expense.toMap(), where: "$COL_ID = ?", whereArgs: [expense.id]);
  }

  Future delete(int id) async {
    await openDB();
    await database.delete(TABLE_NAME, where: "$COL_ID = ?", whereArgs: [id]);
  }

  Future<List<Expense>> getExpenses() async {
    await openDB();
    List<Map> entities = await database.rawQuery("select * from $TABLE_NAME");
    return entities
        .map((map) => new Expense.fromMap(map))
        .toList();
  }

  closeDb() {
    database.close();
  }
}

class DBManager{
  DBHelper helper;
  Map<int, MonthExpense> months;
  
  Future<bool> updateExpense(int index, Expense expense) async {
    if(!months.containsKey(expense.month)) 
        months.addAll({expense.month : new MonthExpense(expense.month, 0 , 0, 0,  0, 0)});

    MonthExpense month = months[expense.month].clone();
    // if update current expense, deduct the amount of month    
    if (expense.id > 0 && index > -1) 
          if(index < month.listExpenses.length)
          {
            switch (month.listExpenses[index].categoryID) {
              case 1: // 家居開支        
                      month.household -= month.listExpenses[index].amount;
                      break;
              case 2: // 老婆開支  
                      month.wife -= month.listExpenses[index].amount;
                      break;
              case 3: // 囝囡開支
                      month.kids -= month.listExpenses[index].amount; 
                      break;
              default:// 其他開出                      
                      month.others -= month.listExpenses[index].amount; 
                      break;
            }
            month.totalAmount -= month.listExpenses[index].amount;
          }
    
    switch (expense.categoryID) {
      case 1: // 家居開支              
        month.household += expense.amount;
        break;
      case 2: // 老婆開支
        month.wife += expense.amount;
        break;
      case 3: // 囝囡開支
        month.kids += expense.amount;     
        break;
      default:// 其他開出
        month.others += expense.amount;                       
        break;
    }
    month.totalAmount += expense.amount;
    if (expense.id  > 0)
    {
        if(index < 0) return false;
        if(!(index < month.listExpenses.length)) return false;
        await helper.update(expense);
        month.listExpenses[index] = expense;
    }
    else{
        expense.id = await helper.insert(expense);
        if (expense.id == 0) return false;
        month.listExpenses.insert(0, expense);
    }        
    months[expense.month] = month;
    return true;
  }

  Future<bool> removeExpense(int index, Expense expense) async {
    if(!months.containsKey(expense.month)) return false;
    if(!(expense.id > 0)) return false;

    MonthExpense month = months[expense.month].clone();
    
    if(!(index < 0 || index > month.listExpenses.length - 1)) 
        month.listExpenses.removeAt(index);
    switch (expense.categoryID) {
      case 1: // 家居開支        
              month.household -= expense.amount;
              break;
      case 2: // 老婆開支  
              month.wife -= expense.amount;
              break;
      case 3: // 囝囡開支
              month.kids -= expense.amount; 
              break;
      default:// 其他開出                      
              month.others -= expense.amount; 
              break;
    }
    month.totalAmount -= expense.amount;
    helper.delete(expense.id);
    months[expense.month] = month;
    return true;
  }
}
