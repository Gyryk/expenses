import 'package:expenses/charts/line.dart';
import 'package:expenses/data/data.dart';
import 'package:expenses/helper/date.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YearSummary extends StatelessWidget {
  final DateTime yearStart;
  const YearSummary({super.key, required this.yearStart});

  double getMax(
      Data val,
      String january,
      String february,
      String march,
      String april,
      String may,
      String june,
      String july,
      String august,
      String september,
      String october,
      String november,
      String december) {
    double? max = 1000;
    List<double> values = [
      val.getMonthlySummary()[january] ?? 0,
      val.getMonthlySummary()[february] ?? 0,
      val.getMonthlySummary()[march] ?? 0,
      val.getMonthlySummary()[april] ?? 0,
      val.getMonthlySummary()[may] ?? 0,
      val.getMonthlySummary()[june] ?? 0,
      val.getMonthlySummary()[july] ?? 0,
      val.getMonthlySummary()[august] ?? 0,
      val.getMonthlySummary()[september] ?? 0,
      val.getMonthlySummary()[october] ?? 0,
      val.getMonthlySummary()[november] ?? 0,
      val.getMonthlySummary()[december] ?? 0,
    ];
    values.sort();
    if (values.last > 600) {
      max = values.last * 1.1;
    }
    return max;
  }

  String getYearTotal(
      Data val,
      String january,
      String february,
      String march,
      String april,
      String may,
      String june,
      String july,
      String august,
      String september,
      String october,
      String november,
      String december) {
    double result = 0.00;
    List<double> values = [
      val.getMonthlySummary()[january] ?? 0,
      val.getMonthlySummary()[february] ?? 0,
      val.getMonthlySummary()[march] ?? 0,
      val.getMonthlySummary()[april] ?? 0,
      val.getMonthlySummary()[may] ?? 0,
      val.getMonthlySummary()[june] ?? 0,
      val.getMonthlySummary()[july] ?? 0,
      val.getMonthlySummary()[august] ?? 0,
      val.getMonthlySummary()[september] ?? 0,
      val.getMonthlySummary()[october] ?? 0,
      val.getMonthlySummary()[november] ?? 0,
      val.getMonthlySummary()[december] ?? 0,
    ];

    for (int i = 0; i < values.length; i++) {
      result += values[i];
    }
    return result.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    String jan = dateToMonth(yearStart);
    String feb = dateToMonth(yearStart.add(const Duration(days: 32)));
    String mar = dateToMonth(yearStart.add(const Duration(days: 62)));
    String apr = dateToMonth(yearStart.add(const Duration(days: 94)));
    String may = dateToMonth(yearStart.add(const Duration(days: 125)));
    String jun = dateToMonth(yearStart.add(const Duration(days: 156)));
    String jul = dateToMonth(yearStart.add(const Duration(days: 187)));
    String aug = dateToMonth(yearStart.add(const Duration(days: 218)));
    String sep = dateToMonth(yearStart.add(const Duration(days: 249)));
    String oct = dateToMonth(yearStart.add(const Duration(days: 280)));
    String nov = dateToMonth(yearStart.add(const Duration(days: 310)));
    String dec = dateToMonth(yearStart.add(const Duration(days: 340)));

    return Consumer<Data>(
      builder: (context, value, child) => Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(children: [
            Center(
              child: Text(
                  'This Year: £${getYearTotal(value, jan, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec)}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 15)),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SizedBox(
            height: 250,
            child: Line(
                maxY: getMax(value, jan, feb, mar, apr, may, jun, jul, aug, sep,
                    oct, nov, dec),
                janY: value.getMonthlySummary()[jan] ?? 0,
                febY: value.getMonthlySummary()[feb] ?? 0,
                marY: value.getMonthlySummary()[mar] ?? 0,
                aprY: value.getMonthlySummary()[apr] ?? 0,
                mayY: value.getMonthlySummary()[may] ?? 0,
                junY: value.getMonthlySummary()[jun] ?? 0,
                julY: value.getMonthlySummary()[jul] ?? 0,
                augY: value.getMonthlySummary()[aug] ?? 0,
                sepY: value.getMonthlySummary()[sep] ?? 0,
                octY: value.getMonthlySummary()[oct] ?? 0,
                novY: value.getMonthlySummary()[nov] ?? 0,
                decY: value.getMonthlySummary()[dec] ?? 0),
          ),
        )
      ]),
    );
  }
}
