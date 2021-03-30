import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foozave/models/foodModel.dart';
import 'package:http/http.dart' as http;

Future postReq(Food food) async {
  try {
    http.Response res = await http.post(
      Uri.http('192.168.1.7:3000', '/food'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(food.toJson()),
    );
    if (res.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Successfully Posted!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 14.0);
    } else {
      Fluttertoast.showToast(
          msg: "Unable to post!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0);
    }
  } catch (e) {
    print(e);
    Fluttertoast.showToast(
        msg: "Unable to post!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0);
  }
}

Future<List<Food>?> getReq() async {
  try {
    http.Response res = await http.get(
      Uri.http('192.168.1.7:3000', '/food'),
      headers: {"Content-Type": "application/json"},
    );
    if (res.statusCode == 200) {
      List<Food> food = (jsonDecode(res.body) as List)
          .map((jsonObj) => Food.fromJson(jsonObj))
          .toList();
      return food;
      //
    } else {
      Fluttertoast.showToast(
          msg: "Unable to fetch data!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0);
      return null;
    }
  } catch (e) {
    print(e);
    Fluttertoast.showToast(
        msg: "Unable to fetch data!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0);
  }
}
