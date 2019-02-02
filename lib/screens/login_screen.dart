import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // final container = AppStateContainer.of(context);
    void authenticateWithGoogle() async {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential creds = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      final FirebaseUser user = await _auth.signInWithCredential(creds);

      print(user);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: RaisedButton(
        onPressed: () async {
          authenticateWithGoogle();
        },
        child: Text("Login"),
      ),
    );
  }
}
