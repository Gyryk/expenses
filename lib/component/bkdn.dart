import 'package:expenses/charts/grph.dart';
import 'package:expenses/data/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Breakdown extends StatelessWidget {
  const Breakdown({super.key});

  double getMax(
      Data val,
      String grocery,
      String dining,
      String housing,
      String clothes,
      String travel,
      String shopping,
      String entertainment,
      String miscellaneous) {
    double? max = 150;
    List<double> values = [
      val.getCategories()[grocery] ?? 0,
      val.getCategories()[dining] ?? 0,
      val.getCategories()[housing] ?? 0,
      val.getCategories()[clothes] ?? 0,
      val.getCategories()[travel] ?? 0,
      val.getCategories()[shopping] ?? 0,
      val.getCategories()[entertainment] ?? 0,
      val.getCategories()[miscellaneous] ?? 0
    ];
    values.sort();
    if (values.last > 100) {
      max = values.last * 1;
    }
    return max;
  }

  double getTotal(
      Data val,
      String grocery,
      String dining,
      String housing,
      String clothes,
      String travel,
      String shopping,
      String entertainment,
      String miscellaneous) {
    double result = 0;
    List<double> values = [
      val.getCategories()[grocery] ?? 0,
      val.getCategories()[dining] ?? 0,
      val.getCategories()[housing] ?? 0,
      val.getCategories()[clothes] ?? 0,
      val.getCategories()[travel] ?? 0,
      val.getCategories()[shopping] ?? 0,
      val.getCategories()[entertainment] ?? 0,
      val.getCategories()[miscellaneous] ?? 0
    ];
    for (var i = 0; i < values.length; i++) {
      result += values[i];
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    String gro = "Groceries";
    String din = "Dining";
    String hou = "Housing";
    String clo = "Clothes";
    String tra = "Travel";
    String sho = "Shopping";
    String ent = "Entertainment";
    String mis = "Miscellaneous";

    return Consumer<Data>(
      builder: (context, value, child) => Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(children: [
              Center(
                child: Text(
                    'Total Spent: £${getTotal(value, gro, din, hou, clo, tra, sho, ent, mis)}',
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
              height: 300,
              child: Graph(
                  maxY: getMax(value, gro, din, hou, clo, tra, sho, ent, mis),
                  groY: value.getCategories()[gro] ?? 0,
                  dinY: value.getCategories()[din] ?? 0,
                  houY: value.getCategories()[hou] ?? 0,
                  cloY: value.getCategories()[clo] ?? 0,
                  traY: value.getCategories()[tra] ?? 0,
                  shoY: value.getCategories()[sho] ?? 0,
                  entY: value.getCategories()[ent] ?? 0,
                  misY: value.getCategories()[mis] ?? 0),
            ),
          ),
        ],
      ),
    );
  }
}
