import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foozave/screens/loginscreen.dart';
import 'package:foozave/utils/AppTheme.dart';
import 'package:foozave/utils/sizeconfig.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late ThemeData themeData;
  bool _passwordVisible = false;
  List<TextEditingController> userTextControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(left: MySize.size24, right: MySize.size24),
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              child: Center(
                child: Text(
                  "Create an Account",
                  style: AppTheme.getTextStyle(themeData.textTheme.headline6!,
                      fontWeight: 600),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: MySize.size24),
              child: TextFormField(
                controller: userTextControllers[0],
                style: AppTheme.getTextStyle(themeData.textTheme.bodyText1!,
                    letterSpacing: 0.1,
                    color: themeData.colorScheme.onBackground,
                    fontWeight: 500),
                decoration: InputDecoration(
                  hintText: "Username",
                  hintStyle: AppTheme.getTextStyle(
                      themeData.textTheme.bodyText1!,
                      letterSpacing: 0.1,
                      color: themeData.colorScheme.onBackground,
                      fontWeight: 500),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: themeData.colorScheme.background,
                  prefixIcon: Icon(
                    MdiIcons.accountOutline,
                    size: MySize.size22,
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.all(0),
                ),
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: MySize.size24),
              child: TextFormField(
                controller: userTextControllers[1],
                style: AppTheme.getTextStyle(themeData.textTheme.bodyText1!,
                    letterSpacing: 0.1,
                    color: themeData.colorScheme.onBackground,
                    fontWeight: 500),
                decoration: InputDecoration(
                  hintStyle: AppTheme.getTextStyle(
                      themeData.textTheme.bodyText1!,
                      letterSpacing: 0.1,
                      color: themeData.colorScheme.onBackground,
                      fontWeight: 500),
                  hintText: "Email address",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: themeData.colorScheme.background,
                  prefixIcon: Icon(
                    MdiIcons.emailOutline,
                    size: MySize.size22,
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.all(0),
                ),
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: MySize.size24),
              child: TextFormField(
                controller: userTextControllers[2],
                style: AppTheme.getTextStyle(themeData.textTheme.bodyText1!,
                    letterSpacing: 0.1,
                    color: themeData.colorScheme.onBackground,
                    fontWeight: 500),
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  hintStyle: AppTheme.getTextStyle(
                      themeData.textTheme.bodyText1!,
                      letterSpacing: 0.1,
                      color: themeData.colorScheme.onBackground,
                      fontWeight: 500),
                  hintText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: themeData.colorScheme.background,
                  prefixIcon: Icon(
                    MdiIcons.lockOutline,
                    size: MySize.size22,
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                    child: Icon(
                      _passwordVisible
                          ? MdiIcons.eyeOutline
                          : MdiIcons.eyeOffOutline,
                      size: MySize.size22,
                    ),
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.all(0),
                ),
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(MySize.size48)),
                boxShadow: [
                  BoxShadow(
                    color: themeData.primaryColor.withAlpha(20),
                    spreadRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              margin: EdgeInsets.only(top: MySize.size24),
              child: ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(Spacing.xy(16, 0))),
                onPressed: () {
                  if (userTextControllers[1].text.isEmpty ||
                      userTextControllers[2].text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: "Check email and password!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black87,
                        textColor: Colors.white,
                        fontSize: 14.0);
                  } else {
                    try {
                      FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: userTextControllers[1].text,
                          password: userTextControllers[2].text);
                    } catch (e) {
                      print(e);
                      userTextControllers[0].text = '';
                      userTextControllers[1].text = '';
                      userTextControllers[2].text = '';
                      Fluttertoast.showToast(
                          msg: "Check email and password!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black87,
                          textColor: Colors.white,
                          fontSize: 14.0);
                    }
                  }
                },
                child: Text(
                  "Register",
                  style: AppTheme.getTextStyle(themeData.textTheme.bodyText1!,
                      fontWeight: 600, color: themeData.colorScheme.onPrimary),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: MySize.size16),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text("I already have an account",
                      style: AppTheme.getTextStyle(
                          themeData.textTheme.bodyText2!,
                          decoration: TextDecoration.underline)),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
