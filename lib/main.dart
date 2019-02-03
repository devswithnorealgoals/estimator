import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:estimator/screens/login_screen.dart';
import 'package:estimator/screens/main_screen.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: _handleCurrentScreen(),
    );
  }

  Widget _handleCurrentScreen() {
    return new StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
                appBar: new AppBar(title: Text("LOADING")),
                body: Text("LOADING"));
          } else {
            if (snapshot.hasData) {
              return new MainScreen();
            }
            return new LoginScreen();
          }
        });
  }
}
