import 'package:flutter/material.dart';

import '../model/item.dart';
import '../helper/date.dart';
import '../model/mitm.dart';
import 'base.dart';

class Data extends ChangeNotifier {
  List<Item> expenseList = [];

  List<Item> getExpenses() {
    return expenseList;
  }

  List<MonthItem> getMonths() {
    List<MonthItem> monthsList = [];
    Map<String, double> monthly = getMonthlySummary();
    double sum = 0;
    double mean = 0;
    String category = "Average Spend";
    for (var i = 1; i <= 12; i++) {
      double amount = 0.0;
      if (i < 10) {
        var j = DateTime.now().year.toString() + "0" + i.toString();
        if (monthly.containsKey(j)) {
          amount = monthly[j]!;
        }
      } else {
        var j = DateTime.now().year.toString() + i.toString();
        if (monthly.containsKey(j)) {
          amount = monthly[j]!;
        }
      }
      sum += amount;
    }
    mean = sum / 12;

    for (var i = 1; i <= 12; i++) {
      String amount = "0.00";
      if (i < 10) {
        var j = DateTime.now().year.toString() + "0" + i.toString();
        if (monthly.containsKey(j)) {
          amount = monthly[j].toString();
        }
      } else {
        var j = DateTime.now().year.toString() + i.toString();
        if (monthly.containsKey(j)) {
          amount = monthly[j].toString();
        }
      }
      if (double.parse(amount) <= (0.75 * mean)) {
        category = "Low Spend";
      } else if (double.parse(amount) >= (1.25 * mean)) {
        category = "High Spend";
      } else {
        category = "Average Spend";
      }
      monthsList.add(
          MonthItem(month: getMonth(i), amount: amount, category: category));
    }
    return monthsList;
  }

  final db = Database();
  void prepData() {
    if (db.loadData().isNotEmpty) {
      expenseList = db.loadData();
    }
  }

  void addExpense(Item expense) {
    expenseList.add(expense);
    notifyListeners();
    db.saveData(expenseList);
  }

  void deleteExpense(Item expense) {
    expenseList.remove(expense);
    notifyListeners();
    db.saveData(expenseList);
  }

  double roundNum(double number) {
    String numbersAfterDecimal = number.toString().split('.')[1];
    String numbersBefore = number.toString().split('.')[0];
    String result = '';
    if (numbersAfterDecimal.length > 2) {
      result = '$numbersBefore.${numbersAfterDecimal.substring(0, 2)}';
      return double.parse(result);
    } else {
      return number;
    }
  }

  String getDay(DateTime day) {
    switch (day.weekday) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        return "";
    }
  }

  String getMonth(int inx) {
    switch (inx) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "";
    }
  }

  String getCat(int inx) {
    switch (inx) {
      case 0:
        return "Groceries";
      case 1:
        return "Dining";
      case 2:
        return "Housing";
      case 3:
        return "Clothes";
      case 4:
        return "Travel";
      case 5:
        return "Shopping";
      case 6:
        return "Entertainment";
      case 7:
        return "Miscellaneous";
      default:
        return "Miscellaneous";
    }
  }

  String getCatAmnt(int inx) {
    String result = "0.00";
    String category = getCat(inx);
    Map<String, double> catBrkdn = getCategories();

    if (catBrkdn.containsKey(category)) {
      result = catBrkdn[category].toString();
    }
    return result;
  }

  DateTime findStart() {
    DateTime? weekStart;
    DateTime today = DateTime.now();

    for (int i = 0; i < 7; i++) {
      DateTime day = today.subtract(Duration(days: i));
      if (getDay(day) == "Monday") {
        weekStart = day;
      }
    }
    return weekStart!;
  }

  DateTime findFirst() {
    DateTime yearStart;
    DateTime today = DateTime.now();

    yearStart = DateTime(today.year, 1, 1);
    return yearStart;
  }

  Map<String, double> getDailySummary() {
    Map<String, double> dailyExpenses = {
      // YYYYMMDD: $X
    };

    for (var expense in expenseList) {
      String dateTime = dateToString(expense.date);
      double money = double.parse(expense.amount);

      if (dailyExpenses.containsKey(dateTime)) {
        double curr = dailyExpenses[dateTime]!;
        curr += money;
        dailyExpenses[dateTime] = roundNum(curr);
      } else {
        dailyExpenses.addAll({dateTime: roundNum(money)});
      }
    }
    return dailyExpenses;
  }

  Map<String, double> getMonthlySummary() {
    Map<String, double> monthlyExpenses = {
      // YYYYMM: $X
    };

    for (var expense in expenseList) {
      String month = dateToMonth(expense.date);
      double money = double.parse(expense.amount);

      if (monthlyExpenses.containsKey(month)) {
        double curr = monthlyExpenses[month]!;
        curr += money;
        monthlyExpenses[month] = roundNum(curr);
      } else {
        monthlyExpenses.addAll({month: roundNum(money)});
      }
    }
    return monthlyExpenses;
  }

  Map<String, double> getCategories() {
    Map<String, double> categoryBreakdown = {
      // Y: $X
    };

    for (var expense in expenseList) {
      String category = expense.category;
      double money = double.parse(expense.amount);

      if (categoryBreakdown.containsKey(category)) {
        double curr = categoryBreakdown[category]!;
        curr += money;
        categoryBreakdown[category] = roundNum(curr);
      } else {
        categoryBreakdown.addAll({category: roundNum(money)});
      }
    }
    return categoryBreakdown;
  }
}
