import 'clmn.dart';

class LineData {
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

  LineData(
      {required this.janY,
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

  List<Column> data = [];

  void initData() {
    data = [
      Column(x: 0, y: janY),
      Column(x: 1, y: febY),
      Column(x: 2, y: marY),
      Column(x: 3, y: aprY),
      Column(x: 4, y: mayY),
      Column(x: 5, y: junY),
      Column(x: 6, y: julY),
      Column(x: 2, y: augY),
      Column(x: 3, y: sepY),
      Column(x: 4, y: octY),
      Column(x: 5, y: novY),
      Column(x: 6, y: decY),
    ];
  }
}
