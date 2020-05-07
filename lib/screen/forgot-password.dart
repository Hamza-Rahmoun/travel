import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:travel/petit_provider/circle_avatar.dart';
import 'package:travel/petit_provider/clip_path.dart';
import 'package:travel/petit_provider/sized_box.dart';
import 'package:travel/provider/authentication.dart';
import 'package:travel/provider/forgotpasword_provider.dart';
import 'package:travel/provider/login_provider.dart';
import 'package:travel/provider/signup_provider.dart';
import 'package:travel/provider/start_page.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var isLoading = false;
  void _submit(context) async {
    final login = Provider.of<LoginProvider>(context, listen: false);
    final forgot = Provider.of<ForgotProvider>(context, listen: false);

    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false)
          .sendPasswordResetEmail(
        login.authData['email'],
      )
          .then((_) {
        forgot.warning =
            "A password reset link has been sent to ${login.authData['email']} ";
      });
      Timer.periodic(Duration(seconds: 5), (time) {
        Navigator.pop(context);
        time.cancel();
      });
    } catch (error) {
      var errorMessage =
          'There is no user record corresponding to this identifier. The user may have been deleted.';
      if (error.toString().contains('EMAIL_NOT_FOUND')) {}
      login.showErrorDialog(errorMessage, context);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final login = Provider.of<LoginProvider>(context, listen: false);
    final auth = Provider.of<Auth>(context);
    final sizedBox = Provider.of<SizedBoxProvider>(context);
    final clipPath = Provider.of<ClipPathProvider>(context);
    final circleAvatar = Provider.of<CircleAvatarProvider>(context);
    final startPage = Provider.of<StartPageProvider>(context);
    final signUp = Provider.of<SignUpProvider>(context);
    final forgot = Provider.of<ForgotProvider>(context);
    return isLoading
        ? forgot.buildLoading()
        : GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              body: ListView(
                children: <Widget>[
                  forgot.showAlert(),
                  sizedBox.sizedBoxHeight(height: 5),
                  startPage.buildImageContainer(),
                  sizedBox.sizedBoxHeight(height: 1),
                  startPage.buildTitle(),
                  sizedBox.sizedBoxHeight(height: 10),
                  forgot.buildText(),
                  sizedBox.sizedBoxHeight(height: 3),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          signUp.buildEmailField(
                            pressed: (value) {
                              login.authData['email'] = value;
                            },
                          ),
                          sizedBox.sizedBoxHeight(height: 4),
                          forgot.submitBottom(pressed: () => _submit(context)),
                          sizedBox.sizedBoxHeight(height: 10),
                          forgot.buildReturn(context)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
