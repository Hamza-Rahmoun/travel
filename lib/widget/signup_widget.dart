import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/petit_provider/circle_avatar.dart';
import 'package:travel/petit_provider/clip_path.dart';
import 'package:travel/petit_provider/sized_box.dart';
import 'package:travel/provider/authentication.dart';
import 'package:travel/provider/login_provider.dart';
import 'package:travel/provider/signup_provider.dart';
import 'package:travel/provider/start_page.dart';

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;
  Future<void> _submit(context) async {
    final login = Provider.of<LoginProvider>(context, listen: false);
    if (!_formKey.currentState.validate() || !login.authData['acceptTerms']) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).signUp(
        login.authData['email'],
        login.authData['password'],
      );
    } catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('OPERATION_NOT_ALLOWED')) {
        errorMessage = 'Password sign-in is disabled for this project.';
      } else if (error.toString().contains('TOO_MANY_ATTEMPTS_TRY_LATER')) {
        errorMessage =
            'We have blocked all requests from this device due to unusual activity. Try again later.';
      }
      login.showErrorDialog(errorMessage, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    final sizedBox = Provider.of<SizedBoxProvider>(context);
    final clipPath = Provider.of<ClipPathProvider>(context);
    final circleAvatar = Provider.of<CircleAvatarProvider>(context);
    final startPage = Provider.of<StartPageProvider>(context);
    final signUp = Provider.of<SignUpProvider>(context);
    final login = Provider.of<LoginProvider>(context);
    return ListView(
      children: <Widget>[
        clipPath.buildClipPath(
          text: 'hello,',
          text1: 'Sign Up!',
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                sizedBox.sizedBoxHeight(
                  height: 3,
                ),
                signUp.buildEmailField(pressed: (value) {
                  login.authData['email'] = value;
                }),
                sizedBox.sizedBoxHeight(
                  height: 3,
                ),
                signUp.buildPasswordField(
                  pressed: (value) {
                    login.authData['password'] = value;
                  },
                  editingController: login.passwordController,
                  show: login.isShow,
                  showBottom: login.show,
                ),
                sizedBox.sizedBoxHeight(
                  height: 2,
                ),
                signUp.buildConfirmPasswordField(
                  pressed: (value) {
                    login.authData['password'] = value;
                  },
                  editingController: login.passwordController,
                  show: login.isShow1,
                  showBottom: login.show1,
                ),
                sizedBox.sizedBoxHeight(
                  height: 2,
                ),
                signUp.build(
                  value: login.authData['acceptTerms'],
                  changed: (bool value) {
                    setState(() {
                      login.authData['acceptTerms'] = value;
                    });
                  },
                ),
                sizedBox.sizedBoxHeight(
                  height: 2,
                ),
                signUp.buildSignBottom(
                  text: 'Sign up',
                  onTap: () => _submit(context),
                  loading: _isLoading,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
