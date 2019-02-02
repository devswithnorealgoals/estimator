import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  MainState createState() {
    return MainState();
  }
}

class MainState extends State<MainScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main'),
      ),
      body: RaisedButton(
        child: Text("Logout"),
        onPressed: () {
          _auth.signOut();
        },
      ),
    );
  }
}
