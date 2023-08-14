import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'data.dart';

class Chart extends StatelessWidget {
  final double? maxY;
  final double monY;
  final double tueY;
  final double wedY;
  final double thuY;
  final double friY;
  final double satY;
  final double sunY;
  const Chart(
      {super.key,
      required this.maxY,
      required this.monY,
      required this.tueY,
      required this.wedY,
      required this.thuY,
      required this.friY,
      required this.satY,
      required this.sunY});

  @override
  Widget build(BuildContext context) {
    ChartData dat = ChartData(
        monY: monY,
        tueY: tueY,
        wedY: wedY,
        thuY: thuY,
        friY: friY,
        satY: satY,
        sunY: sunY);

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
      text = const Text('M', style: style);
      break;
    case 1:
      text = const Text('T', style: style);
      break;
    case 2:
      text = const Text('W', style: style);
      break;
    case 3:
      text = const Text('T', style: style);
      break;
    case 4:
      text = const Text('F', style: style);
      break;
    case 5:
      text = const Text('S', style: style);
      break;
    case 6:
      text = const Text('S', style: style);
      break;
    default:
      text = const Text(' ', style: style);
      break;
  }

  return SideTitleWidget(child: text, axisSide: title.axisSide);
}
