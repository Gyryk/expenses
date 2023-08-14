import 'package:expenses/component/year.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../component/mnth.dart';
import '../data/data.dart';
import 'ctgr.dart';
import 'home.dart';

class YearPage extends StatefulWidget {
  const YearPage({super.key});

  @override
  State<YearPage> createState() => _YearState();
}

class _YearState extends State<YearPage> {
  int selectedIndex = 2;
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
              selectedIndex: selectedIndex,
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
                  textColor: Colors.white,
                  iconColor: Colors.grey[400],
                  iconActiveColor: Colors.white,
                ),
                GButton(
                  icon: Icons.calendar_month_rounded,
                  text: 'Year Review',
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w200, color: Colors.white),
                  iconColor: Colors.grey[400],
                  iconActiveColor: Colors.white,
                ),
              ]),
        ),
        backgroundColor: Colors.grey[900],
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          child: ListView(children: [
            YearSummary(yearStart: value.findFirst()),
            const SizedBox(height: 20),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 12,
                itemBuilder: (context, index) => Month(
                      month: value.getMonths()[index].month,
                      amount: value.getMonths()[index].amount,
                      category: value.getMonths()[index].category,
                    ))
          ]),
        ),
      ),
    );
  }
}
