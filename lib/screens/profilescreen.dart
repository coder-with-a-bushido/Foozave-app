import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:foozave/screens/loginscreen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Stack(children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'assets/images/doughnut_bg1.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 23),
                      height: 50,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CupertinoNavigationBar(
                            leading: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                size: 25,
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            middle: Text(
                              'User',
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                MdiIcons.email,
                                color: Colors.black54,
                              ),
                              title: Text('Email id'),
                              subtitle: Text(
                                  FirebaseAuth.instance.currentUser!.email!),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      FirebaseAuth.instance.signOut();
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()),
                                          (route) => false);
                                    },
                                    child: Text('Logout')),
                                SizedBox(
                                  width: 15,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 3),
                        color: Colors.black87,
                        child: Image.asset(
                          'assets/images/Name logo.png',
                          width: 120,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Made with ',
                          style: TextStyle(fontSize: 17),
                        ),
                        Icon(
                          MdiIcons.heart,
                          color: Colors.red,
                          size: 17,
                        ),
                        Text(
                          ' and ',
                          style: TextStyle(fontSize: 17),
                        ),
                        FlutterLogo(
                          size: 17,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'By ',
                          style: TextStyle(fontSize: 15),
                        ),
                        InkWell(
                          child: Text(
                            'Karthikeyan S',
                            style: TextStyle(
                              color: Colors.pink,
                            ),
                          ),
                          onTap: () => launch(
                              'https://www.linkedin.com/in/karthikeyanssvk/'),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Logo and design by ',
                          style: TextStyle(fontSize: 15),
                        ),
                        InkWell(
                          child: Text(
                            'Gowrav Krishna',
                            style: TextStyle(
                              color: Colors.pink,
                            ),
                          ),
                          onTap: () => launch(
                              'https://www.linkedin.com/in/gowrav-krishna-ab840b1aa/'),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}
