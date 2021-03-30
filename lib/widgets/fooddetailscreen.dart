import 'package:flutter/material.dart';
import 'package:foozave/models/foodModel.dart';

class FoodDetail extends StatelessWidget {
  final Food food;
  FoodDetail({required this.food});
  @override
  Widget build(BuildContext context) {
    return Dialog(
        clipBehavior: Clip.hardEdge,
        //insetPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
              food.name,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.w800),
            ),
            SizedBox(
              height: 15,
            ),
            Text('Available till: ' +
                food.expireAt.day.toString() +
                '/' +
                food.expireAt.month.toString() +
                '/' +
                food.expireAt.year.toString() +
                ' ' +
                food.expireAt.hour.toString() +
                ':' +
                (food.expireAt.minute == 0
                    ? '00'
                    : food.expireAt.minute.toString())),
            SizedBox(
              height: 15,
            ),
            Container(
                decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(15)),
                padding: EdgeInsets.all(13),
                child: Text(food.description,
                    style: TextStyle(color: Colors.black87, fontSize: 15))),
            SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'))
          ]),
        ));
  }
}
