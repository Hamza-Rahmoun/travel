import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/provider/authentication.dart';
import 'package:travel/screen/home-page.dart';
import 'package:travel/widget/login_widget.dart';

class LoginPage extends StatelessWidget {
  static const routeName = 'login page';
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    return auth.isAuth
        ? HomePage()
        : GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SafeArea(
              child: Scaffold(
                body: LoginWidget(),
              ),
            ),
          );
  }
}
