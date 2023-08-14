import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'bars.dart';

class Graph extends StatelessWidget {
  final double? maxY;
  final double groY;
  final double dinY;
  final double houY;
  final double cloY;
  final double traY;
  final double shoY;
  final double entY;
  final double misY;
  const Graph(
      {super.key,
      required this.maxY,
      required this.groY,
      required this.dinY,
      required this.houY,
      required this.cloY,
      required this.traY,
      required this.shoY,
      required this.entY,
      required this.misY});

  @override
  Widget build(BuildContext context) {
    BarData dat = BarData(
        groY: groY,
        dinY: dinY,
        houY: houY,
        cloY: cloY,
        traY: traY,
        shoY: shoY,
        entY: entY,
        misY: misY);

    dat.initData();

    return BarChart(BarChartData(
      minY: 0,
      maxY: maxY,
      gridData: FlGridData(
        show: true,
        getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.redAccent[100], dashArray: [6], strokeWidth: 1),
        getDrawingVerticalLine: (value) => FlLine(
            color: Colors.redAccent[100], dashArray: [6], strokeWidth: 1),
      ),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
              sideTitles:
                  SideTitles(showTitles: true, getTitlesWidget: getLegend))),
      barGroups: dat.data
          .map((d) => BarChartGroupData(x: d.x, barRods: [
                BarChartRodData(
                    toY: d.y,
                    color: Colors.redAccent,
                    width: 32,
                    borderRadius: BorderRadius.circular(4),
                    backDrawRodData: BackgroundBarChartRodData(
                        show: false, toY: maxY, color: Colors.red[200]))
              ]))
          .toList(),
    ));
  }
}

Widget getLegend(double value, TitleMeta title) {
  const style = TextStyle(
      color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 14);

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('G', style: style);
      break;
    case 1:
      text = const Text('D', style: style);
      break;
    case 2:
      text = const Text('H', style: style);
      break;
    case 3:
      text = const Text('C', style: style);
      break;
    case 4:
      text = const Text('T', style: style);
      break;
    case 5:
      text = const Text('S', style: style);
      break;
    case 6:
      text = const Text('E', style: style);
      break;
    case 7:
      text = const Text('M', style: style);
      break;
    default:
      text = const Text(' ', style: style);
      break;
  }

  return SideTitleWidget(child: text, axisSide: title.axisSide);
}
