import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/petit_provider/circle_avatar.dart';
import 'package:travel/petit_provider/clip_path.dart';
import 'package:travel/petit_provider/sized_box.dart';
import 'package:travel/provider/authentication.dart';
import 'package:travel/provider/login_provider.dart';
import 'package:travel/provider/signup_provider.dart';
import 'package:travel/provider/start_page.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  var _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  Future<void> _submit(context) async {
    final login = Provider.of<LoginProvider>(context, listen: false);
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).login(
        login.authData['email'],
        login.authData['password'],
      );
    } catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('USER_DISABLED')) {
        errorMessage = 'The user account has been disabled by an administrator';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      login.showErrorDialog(errorMessage, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizedBox = Provider.of<SizedBoxProvider>(context);
    final clipPath = Provider.of<ClipPathProvider>(context);
    final circleAvatar = Provider.of<CircleAvatarProvider>(context);
    final startPage = Provider.of<StartPageProvider>(context);
    final signUp = Provider.of<SignUpProvider>(context);
    final auth = Provider.of<Auth>(context);
    final login = Provider.of<LoginProvider>(context);

    return ListView(
      children: <Widget>[
        clipPath.buildClipPath(
          text: 'Welcome Back,',
          text1: 'Log In!',
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
                signUp.buildEmailField(
                  pressed: (value) {
                    login.authData['email'] = value;
                  },
                ),
                sizedBox.sizedBoxHeight(
                  height: 3,
                ),
                signUp.buildPasswordField(
                  pressed: (value) {
                    login.authData['password'] = value;
                  },
                  showBottom: login.show,
                  show: login.isShow,
                  editingController: null,
                ),
                sizedBox.sizedBoxHeight(
                  height: 4,
                ),
                login.buildForgotTransition(context),
                sizedBox.sizedBoxHeight(
                  height: 2,
                ),
                signUp.buildSignBottom(
                  text: 'Log In',
                  onTap: () => _submit(context),
                  loading: _isLoading,
                ),
                sizedBox.sizedBoxHeight(
                  height: 4,
                ),
                login.buildCircleAvatar(circleAvatar, auth, context, sizedBox),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
