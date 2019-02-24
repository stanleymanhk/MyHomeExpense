final String TABLE_NAME = "expense";
final String COL_ID = "id";
final String COL_MONTH = "month";
final String COL_CATEGORY = "category";
final String COL_TYPE = "type";
final String COL_AMOUNT = "amount";
final String COL_INPUT_TIME = "inputtime";

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
  Expense clone()
  {
    return new Expense(this.id, this.month, this.categoryID, this.typeID, this.amount, this.inputTime);
  }
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

  MonthExpense clone(){
    MonthExpense month = new MonthExpense(this.month, totalAmount, household, wife, kids, others);
    this.listExpenses.forEach((expense){
          month.listExpenses.add(expense);          
      });
    return month;
  }
}

