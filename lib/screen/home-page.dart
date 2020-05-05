import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:travel/provider/login-provider.dart';
import 'package:travel/screen/started-page.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'home page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;
  final facebookLogin = FacebookLogin();
  Future<void> signOut() async {
    await _fireBaseAuth.signOut();
    await _googleSignIn.signOut();
    await facebookLogin.logOut();
    Provider.of<Auth>(context, listen: false).logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: GestureDetector(
        onTap: () {
          signOut().then((_) {
            return Navigator.pushReplacementNamed(context, StartPage.routeName);
          });
        },
        child: Container(
          color: Colors.red,
          child: Text(
            'Log Out',
            style: TextStyle(
              fontSize: 38,
            ),
          ),
        ),
      )),
    );
  }
}
