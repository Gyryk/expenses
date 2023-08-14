import 'package:expenses/charts/chrt.dart';
import 'package:expenses/data/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/date.dart';

class Summary extends StatelessWidget {
  final DateTime weekStart;
  const Summary({super.key, required this.weekStart});

  double getMax(Data val, String monday, String tuesday, String wednesday,
      String thursday, String friday, String saturday, String sunday) {
    double? max = 100;
    List<double> values = [
      val.getDailySummary()[monday] ?? 0,
      val.getDailySummary()[tuesday] ?? 0,
      val.getDailySummary()[wednesday] ?? 0,
      val.getDailySummary()[thursday] ?? 0,
      val.getDailySummary()[friday] ?? 0,
      val.getDailySummary()[saturday] ?? 0,
      val.getDailySummary()[sunday] ?? 0,
    ];
    values.sort();
    if (values.last > 50) {
      max = values.last * 1.2;
    }
    return max;
  }

  String getWeekTotal(Data val, String monday, String tuesday, String wednesday,
      String thursday, String friday, String saturday, String sunday) {
    double result = 0.00;
    List<double> values = [
      val.getDailySummary()[monday] ?? 0,
      val.getDailySummary()[tuesday] ?? 0,
      val.getDailySummary()[wednesday] ?? 0,
      val.getDailySummary()[thursday] ?? 0,
      val.getDailySummary()[friday] ?? 0,
      val.getDailySummary()[saturday] ?? 0,
      val.getDailySummary()[sunday] ?? 0,
    ];

    for (int i = 0; i < values.length; i++) {
      result += values[i];
    }
    return result.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    String mon = dateToString(weekStart);
    String tue = dateToString(weekStart.add(const Duration(days: 1)));
    String wed = dateToString(weekStart.add(const Duration(days: 2)));
    String thu = dateToString(weekStart.add(const Duration(days: 3)));
    String fri = dateToString(weekStart.add(const Duration(days: 4)));
    String sat = dateToString(weekStart.add(const Duration(days: 5)));
    String sun = dateToString(weekStart.add(const Duration(days: 6)));

    return Consumer<Data>(
      builder: (context, value, child) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(children: [
              //TODO: Could add charts for past weeks, buttons to navigate
              Center(
                child: Text(
                    'This Week: £${getWeekTotal(value, mon, tue, wed, thu, fri, sat, sun)}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 15)),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              height: 200,
              child: Chart(
                  maxY: getMax(value, mon, tue, wed, thu, fri, sat, sun),
                  monY: value.getDailySummary()[mon] ?? 0,
                  tueY: value.getDailySummary()[tue] ?? 0,
                  wedY: value.getDailySummary()[wed] ?? 0,
                  thuY: value.getDailySummary()[thu] ?? 0,
                  friY: value.getDailySummary()[fri] ?? 0,
                  satY: value.getDailySummary()[sat] ?? 0,
                  sunY: value.getDailySummary()[sun] ?? 0),
            ),
          ),
        ],
      ),
    );
  }
}
