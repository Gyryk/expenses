import 'package:hive_flutter/hive_flutter.dart';

import '../model/item.dart';

class Database {
  final box = Hive.box("expenseDB");

  void saveData(List<Item> expenses) {
    List<List<dynamic>> formattedExpenses = [];

    for (var expense in expenses) {
      List<dynamic> format = [
        expense.name,
        expense.amount,
        expense.category,
        expense.date
      ];
      formattedExpenses.add(format);
    }
    box.put("EXPENSES", formattedExpenses);
  }

  List<Item> loadData() {
    List savedExpenses = box.get("EXPENSES") ?? [];
    List<Item> expenses = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      String category = savedExpenses[i][2];
      DateTime date = savedExpenses[i][3];

      Item expense =
          Item(name: name, amount: amount, category: category, date: date);
      expenses.add(expense);
    }
    return expenses;
  }
}
