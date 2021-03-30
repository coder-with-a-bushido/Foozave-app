import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foozave/screens/profilescreen.dart';
import 'package:foozave/widgets/addfoodscreen.dart';
import 'package:foozave/utils/AppTheme.dart';

class TopBar extends StatefulWidget {
  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  late ThemeData themeData;
  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        height: 60,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: CupertinoNavigationBar(
            leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                }),
            middle: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3),
                color: Colors.black87,
                child: Image.asset(
                  'assets/images/Name logo.png',
                  width: 90,
                ),
              ),
            ),
            trailing: IconButton(
                icon: Icon(
                  Icons.add_circle_sharp,
                  size: 27,
                ),
                onPressed: () {
                  showDialog(
                      context: context, builder: (context) => AddFoodScreen());
                }),
          ),
        ),
      ),
    );
  }
}
