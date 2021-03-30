import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:foozave/screens/loginscreen.dart';
import 'package:foozave/screens/mainscreen.dart';

class IntroScreen extends StatefulWidget {
  final bool goIn;
  IntroScreen({required this.goIn});
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.goIn) {
      User? result = FirebaseAuth.instance.currentUser;
      Timer(Duration(seconds: 3), () {
        if (result != null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainScreen()));
        } else
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
      });
    }
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, child) {
            return Transform.rotate(
              angle: _controller.value * 2 * math.pi,
              child: child,
            );
          },
          child: Image.asset(
            'assets/images/Doughnut.png',
            width: MediaQuery.of(context).size.width - 100,
          ),
        ),
      ),
    );
  }
}
