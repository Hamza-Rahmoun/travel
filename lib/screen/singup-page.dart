import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/provider/authentication.dart';
import 'package:travel/screen/home-page.dart';
import 'package:travel/widget/signup_widget.dart';

class SignUpPage extends StatelessWidget {
  static const routeName = 'signup';
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    return auth.isAuth
        ? HomePage()
        : SafeArea(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Scaffold(
                body: SignUpWidget(),
              ),
            ),
          );
  }
}
