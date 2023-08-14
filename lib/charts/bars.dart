import 'clmn.dart';

class BarData {
  final double groY;
  final double dinY;
  final double houY;
  final double cloY;
  final double traY;
  final double shoY;
  final double entY;
  final double misY;

  BarData(
      {required this.groY,
      required this.dinY,
      required this.houY,
      required this.cloY,
      required this.traY,
      required this.shoY,
      required this.entY,
      required this.misY});

  List<Column> data = [];

  void initData() {
    data = [
      Column(x: 0, y: groY),
      Column(x: 1, y: dinY),
      Column(x: 2, y: houY),
      Column(x: 3, y: cloY),
      Column(x: 4, y: traY),
      Column(x: 5, y: shoY),
      Column(x: 6, y: entY),
      Column(x: 7, y: misY)
    ];
  }
}
