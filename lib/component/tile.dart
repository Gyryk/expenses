import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class Tile extends StatelessWidget {
  final String name;
  final String amount;
  final String category;
  final DateTime date;
  void Function(BuildContext)? deletePress;
  void Function(BuildContext)? editPress;

  Tile(
      {super.key,
      required this.name,
      required this.amount,
      required this.category,
      required this.date,
      required this.deletePress,
      required this.editPress});

  @override
  Widget build(BuildContext context) {
    const title = TextStyle(
        color: Colors.white, fontWeight: FontWeight.w300, fontSize: 19);
    const time = TextStyle(
        color: Colors.white, fontWeight: FontWeight.w200, fontSize: 11);
    const price = TextStyle(
        color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17);
    const categ = TextStyle(
        color: Colors.white, fontWeight: FontWeight.w200, fontSize: 13);

    return Slidable(
      endActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
          onPressed: editPress,
          icon: Icons.edit,
          backgroundColor: Colors.black12,
          foregroundColor: Colors.red,
          borderRadius: BorderRadius.circular(2),
        ),
        SlidableAction(
          onPressed: deletePress,
          icon: Icons.delete,
          backgroundColor: Colors.black12,
          foregroundColor: Colors.red,
          borderRadius: BorderRadius.circular(2),
        ),
      ]),
      child: ListTile(
        title: Text(name, style: title),
        subtitle: Text('${date.day}/${date.month}/${date.year}', style: time),
        trailing: RichText(
            text: TextSpan(children: [
              TextSpan(text: '£$amount', style: price),
              TextSpan(text: '\n$category', style: categ)
            ]),
            textAlign: TextAlign.right),
      ),
    );
  }
}
