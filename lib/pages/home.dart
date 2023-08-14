import 'package:expenses/component/week.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../component/tile.dart';
import '../data/data.dart';
import '../model/item.dart';
import 'ctgr.dart';
import 'mnth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final expenseNameCont = TextEditingController();
  final expensePoundCont = TextEditingController();
  final expensePennyCont = TextEditingController();

  String? selectedCat = 'Groceries';
  List<String> categories = [
    'Groceries',
    'Dining',
    'Housing',
    'Clothes',
    'Travel',
    'Shopping',
    'Entertainment',
    'Miscellaneous'
  ];

  int selectedIndex = 1;
  List<Widget> pages = [CategoryPage(), HomePage(), YearPage()];

  late DateTime newDate;

  @override
  void initState() {
    super.initState();
    Provider.of<Data>(context, listen: false).prepData();

    newDate = DateTime.now();
  }

  void navBar(int index) {
    setState(() => selectedIndex = index);
    if (selectedIndex != 1) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => pages[selectedIndex]));
    }
  }

  void addExpense() {
    newDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text('New Expense',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w100)),
          backgroundColor: Colors.grey[900],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                  controller: expenseNameCont,
                  cursorColor: Colors.redAccent,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent)),
                      hintText: "Expense Name",
                      hintStyle: TextStyle(color: Colors.white60))),
              Row(children: [
                Expanded(
                    child: TextField(
                        controller: expensePoundCont,
                        cursorColor: Colors.redAccent,
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.redAccent)),
                            hintText: "Pounds",
                            hintStyle: TextStyle(color: Colors.white60)))),
                Expanded(
                    child: TextField(
                        controller: expensePennyCont,
                        cursorColor: Colors.redAccent,
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.redAccent)),
                            hintText: "Pennies",
                            hintStyle: TextStyle(color: Colors.white60))))
              ]),
              Row(children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedCat,
                    items: categories
                        .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(item,
                                style: const TextStyle(color: Colors.white))))
                        .toList(),
                    onChanged: (item) => setState(() => selectedCat = item),
                    dropdownColor: Colors.grey.shade800,
                    decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent))),
                  ),
                ),
                SizedBox(
                  height: 47,
                  width: 103,
                  child: ElevatedButton(
                    onPressed: () async {
                      DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: newDate,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100));

                      if (date == null) return;
                      setState(() => newDate = date);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent),
                    child: Text(
                        '${newDate.year}/${newDate.month}/${newDate.day}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w300)),
                  ),
                ),
              ])
            ],
          ),
          actions: [
            MaterialButton(
                onPressed: clear,
                child: const Text("Cancel",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500))),
            MaterialButton(
                onPressed: () => save(newDate),
                child: const Text("Save",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500))),
          ]),
    );
  }

  void editExpense(Item expense) {
    expenseNameCont.text = expense.name;
    expensePoundCont.text = expense.amount.split('.')[0];
    expensePennyCont.text = expense.amount.split('.')[1];
    newDate = expense.date;
    selectedCat = expense.category;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text('Edit Expense',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w100)),
          backgroundColor: Colors.grey[900],
          content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: expenseNameCont,
                  cursorColor: Colors.redAccent,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent)),
                  ),
                ),
                Row(children: [
                  Expanded(
                    child: TextField(
                      controller: expensePoundCont,
                      cursorColor: Colors.redAccent,
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: expensePennyCont,
                      cursorColor: Colors.redAccent,
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent)),
                      ),
                    ),
                  )
                ]),
                Row(children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedCat,
                      items: categories
                          .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item,
                                  style: const TextStyle(color: Colors.white))))
                          .toList(),
                      onChanged: (item) => setState(() => selectedCat = item),
                      dropdownColor: Colors.grey.shade800,
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.redAccent))),
                    ),
                  ),
                  SizedBox(
                      width: 103,
                      height: 47,
                      child: ElevatedButton(
                        onPressed: () async {
                          DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: newDate,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2100));
                          setState(() {
                            newDate = date!;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent),
                        child: Text(
                            '${newDate.year}/${newDate.month}/${newDate.day}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w300)),
                      )),
                ])
              ]),
          actions: [
            MaterialButton(
              onPressed: clear,
              child: const Text(
                "Cancel",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
            MaterialButton(
              onPressed: () => update(expense, newDate),
              child: const Text(
                "Update",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ]),
    );
  }

  void update(Item expense, DateTime date) {
    String pennies = '';
    String pounds = '';

    if (expensePennyCont.text.isEmpty) {
      pennies = '00';
    } else if (expensePennyCont.text.length < 2) {
      pennies = '0${expensePennyCont.text}';
    } else {
      pennies = expensePennyCont.text.substring(0, 2);
    }

    if (expensePoundCont.text.isEmpty) {
      pounds = '0';
    } else {
      pounds = expensePoundCont.text;
    }

    if ((expensePoundCont.text.isNotEmpty ||
            expensePennyCont.text.isNotEmpty) &&
        expenseNameCont.text.isNotEmpty) {
      String money = '$pounds.$pennies';

      Item newExpense = Item(
          name: expenseNameCont.text,
          amount: money,
          category: selectedCat!,
          date: date);
      Provider.of<Data>(context, listen: false).addExpense(newExpense);
      delete(expense);
    }

    clear();
  }

  void delete(Item expense) {
    Provider.of<Data>(context, listen: false).deleteExpense(expense);
  }

  void save(DateTime date) {
    String pennies = '';
    String pounds = '';

    if (expensePennyCont.text.isEmpty) {
      pennies = '00';
    } else if (expensePennyCont.text.length < 2) {
      pennies = '0${expensePennyCont.text}';
    } else {
      pennies = expensePennyCont.text.substring(0, 2);
    }

    if (expensePoundCont.text.isEmpty) {
      pounds = '0';
    } else {
      pounds = expensePoundCont.text;
    }

    if ((expensePoundCont.text.isNotEmpty ||
            expensePennyCont.text.isNotEmpty) &&
        expenseNameCont.text.isNotEmpty) {
      String money = '$pounds.$pennies';

      Item newExpense = Item(
          name: expenseNameCont.text,
          amount: money,
          category: selectedCat!,
          date: date);
      Provider.of<Data>(context, listen: false).addExpense(newExpense);
    }

    clear();
  }

  void clear() {
    Navigator.pop(context);

    expenseNameCont.clear();
    expensePoundCont.clear();
    expensePennyCont.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(
      builder: (context, value, child) => Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: GNav(
              gap: 6,
              tabBackgroundColor: Colors.redAccent,
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.all(10),
              onTabChange: (index) {
                navBar(index);
              },
              selectedIndex: 1,
              tabs: [
                GButton(
                  icon: Icons.category_rounded,
                  text: 'Categories',
                  textColor: Colors.white,
                  iconColor: Colors.grey[400],
                  iconActiveColor: Colors.white,
                ),
                GButton(
                  icon: Icons.wallet_rounded,
                  text: 'Manage Expenses',
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w200, color: Colors.white),
                  iconColor: Colors.grey[400],
                  iconActiveColor: Colors.white,
                ),
                GButton(
                  icon: Icons.calendar_month_rounded,
                  text: 'Year Review',
                  textColor: Colors.white,
                  iconColor: Colors.grey[400],
                  iconActiveColor: Colors.white,
                ),
              ]),
        ),
        backgroundColor: Colors.grey[900],
        floatingActionButton: FloatingActionButton(
          onPressed: addExpense,
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          child: ListView(children: [
            Summary(weekStart: value.findStart()),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getExpenses().length,
              itemBuilder: (context, index) => Tile(
                  name: value.getExpenses()[index].name,
                  amount: value.getExpenses()[index].amount,
                  category: value.getExpenses()[index].category,
                  date: value.getExpenses()[index].date,
                  deletePress: (p0) => delete(value.getExpenses()[index]),
                  editPress: (p1) => editExpense(value.getExpenses()[index])),
            ),
          ]),
        ),
      ),
    );
  }
}
