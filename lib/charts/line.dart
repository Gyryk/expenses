import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'ldat.dart';

class Line extends StatelessWidget {
  final double? maxY;
  final double janY;
  final double febY;
  final double marY;
  final double aprY;
  final double mayY;
  final double junY;
  final double julY;
  final double augY;
  final double sepY;
  final double octY;
  final double novY;
  final double decY;

  Line(
      {super.key,
      required this.maxY,
      required this.janY,
      required this.febY,
      required this.marY,
      required this.aprY,
      required this.mayY,
      required this.junY,
      required this.julY,
      required this.augY,
      required this.sepY,
      required this.octY,
      required this.novY,
      required this.decY});

  @override
  Widget build(BuildContext context) {
    LineData ld = LineData(
        janY: janY,
        febY: febY,
        marY: marY,
        aprY: aprY,
        mayY: mayY,
        junY: junY,
        julY: julY,
        augY: augY,
        sepY: sepY,
        octY: octY,
        novY: novY,
        decY: decY);

    ld.initData();

    return LineChart(
      LineChartData(
          minX: 0,
          maxX: 11,
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
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: true, getTitlesWidget: getLegend))),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, janY),
                FlSpot(1, febY),
                FlSpot(2, marY),
                FlSpot(3, aprY),
                FlSpot(4, mayY),
                FlSpot(5, junY),
                FlSpot(6, julY),
                FlSpot(7, augY),
                FlSpot(8, sepY),
                FlSpot(9, octY),
                FlSpot(10, novY),
                FlSpot(11, decY),
              ],
              isCurved: true,
              gradient: LinearGradient(colors: [
                Colors.redAccent,
                const Color.fromARGB(155, 255, 82, 82),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              barWidth: 4,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(colors: [
                  Colors.redAccent,
                  const Color.fromARGB(165, 255, 82, 82),
                  const Color.fromARGB(75, 255, 82, 82),
                  const Color.fromARGB(0, 255, 82, 82)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
            )
          ]),
    );
  }
}

Widget getLegend(double value, TitleMeta title) {
  const style = TextStyle(
      color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 14);

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('J', style: style);
      break;
    case 1:
      text = const Text('F', style: style);
      break;
    case 2:
      text = const Text('M', style: style);
      break;
    case 3:
      text = const Text('A', style: style);
      break;
    case 4:
      text = const Text('M', style: style);
      break;
    case 5:
      text = const Text('J', style: style);
      break;
    case 6:
      text = const Text('J', style: style);
      break;
    case 7:
      text = const Text('A', style: style);
      break;
    case 8:
      text = const Text('S', style: style);
      break;
    case 9:
      text = const Text('O', style: style);
      break;
    case 10:
      text = const Text('N', style: style);
      break;
    case 11:
      text = const Text('D', style: style);
      break;
    default:
      text = const Text(' ', style: style);
      break;
  }

  return SideTitleWidget(child: text, axisSide: title.axisSide);
}
