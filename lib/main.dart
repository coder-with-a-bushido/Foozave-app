import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:foozave/screens/loginscreen.dart';
import 'package:foozave/screens/mainscreen.dart';
import 'package:foozave/utils/sizeconfig.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return SomethingWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MyAwesomeApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Loading();
      },
    );
  }
}

class SomethingWentWrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Unable to connect to Firebase!'));
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class MyAwesomeApp extends StatefulWidget {
  @override
  _MyAwesomeAppState createState() => _MyAwesomeAppState();
}

class _MyAwesomeAppState extends State<MyAwesomeApp> {
  late final auth;
  AuthState isSignedin = AuthState.Checking;
  @override
  void initState() {
    auth = FirebaseAuth.instance;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        setState(() {
          isSignedin = AuthState.NotSignedIn;
        });
        print('User is currently signed out!');
      } else {
        setState(() {
          isSignedin = AuthState.SignedIn;
        });
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isSignedin == AuthState.Checking
          ? Loading()
          : isSignedin == AuthState.NotSignedIn
              ? LoginScreen()
              : MainScreen(),
    );
  }
}

enum AuthState { Checking, SignedIn, NotSignedIn }
