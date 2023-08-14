import 'clmn.dart';

class ChartData {
  final double monY;
  final double tueY;
  final double wedY;
  final double thuY;
  final double friY;
  final double satY;
  final double sunY;

  ChartData(
      {required this.monY,
      required this.tueY,
      required this.wedY,
      required this.thuY,
      required this.friY,
      required this.satY,
      required this.sunY});

  List<Column> data = [];

  void initData() {
    data = [
      Column(x: 0, y: monY),
      Column(x: 1, y: tueY),
      Column(x: 2, y: wedY),
      Column(x: 3, y: thuY),
      Column(x: 4, y: friY),
      Column(x: 5, y: satY),
      Column(x: 6, y: sunY),
    ];
  }
}
