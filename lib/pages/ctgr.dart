import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../component/bkdn.dart';
import '../component/catg.dart';
import '../data/data.dart';
import 'home.dart';
import 'mnth.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryState();
}

class _CategoryState extends State<CategoryPage> {
  int selectedIndex = 1;
  List<Widget> pages = [CategoryPage(), HomePage(), YearPage()];

  void navBar(int index) {
    setState(() => selectedIndex = index);
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => pages[selectedIndex]));
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
              padding: EdgeInsets.all(10),
              onTabChange: (index) {
                navBar(index);
              },
              selectedIndex: 0,
              tabs: [
                GButton(
                  icon: Icons.category_rounded,
                  text: 'Categories',
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w200, color: Colors.white),
                  iconColor: Colors.grey[400],
                  iconActiveColor: Colors.white,
                ),
                GButton(
                  icon: Icons.wallet_rounded,
                  text: 'Manage Expenses',
                  textColor: Colors.white,
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
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          child: ListView(children: [
            Breakdown(),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 8,
              itemBuilder: (context, index) => Category(
                  category: value.getCat(index),
                  amount: value.getCatAmnt(
                      index)), //TODO: Can make clickable to see expenseList for category
            )
          ]),
        ),
      ),
    );
  }
}
