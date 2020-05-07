import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travel/petit_provider/circle_avatar.dart';
import 'package:travel/petit_provider/sized_box.dart';
import 'package:travel/provider/authentication.dart';
import 'package:travel/responsiveui/size-config.dart';
import 'package:travel/screen/forgot-password.dart';
import 'package:travel/screen/home-page.dart';

class LoginProvider with ChangeNotifier {
  var isShow = false;
  var isShow1 = false;
  void show() {
    isShow = !isShow;
    notifyListeners();
  }

  void show1() {
    isShow1 = !isShow1;
    notifyListeners();
  }

  void showErrorDialog(String message, context) {
    AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.BOTTOMSLIDE,
            tittle: 'An Error Occurred!',
            desc: '$message',
            btnOkOnPress: () {})
        .show();
  }

  final passwordController = TextEditingController();
  Map<String, dynamic> authData = {
    'email': '',
    'password': '',
    'acceptTerms': false,
    'error': '',
  };
  Row buildCircleAvatar(CircleAvatarProvider circleAvatar, Auth auth,
      BuildContext context, SizedBoxProvider sizedBox) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        circleAvatar.buildCircleAvatar(
          pressed: () {
            auth.googleSignIn(context).then((value) {
              if (value != null) {
                Navigator.pushReplacementNamed(context, HomePage.routeName);
              }
            });
          },
          iconData: FontAwesomeIcons.googlePlusG,
          colour: Color.fromRGBO(220, 77, 68, 1),
        ),
        sizedBox.sizedBoxWidth(
          width: 4,
        ),
        circleAvatar.buildCircleAvatar(
          pressed: () {
            auth.loginWithFb(context);
          },
          iconData: FontAwesomeIcons.facebookF,
          colour: Color.fromRGBO(32, 105, 194, 1),
        ),
      ],
    );
  }

  Row buildForgotTransition(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                child: ForgotPassword(),
                type: PageTransitionType.scale,
              ),
            );
          },
          child: Text(
            'Forgot Password?',
            style: TextStyle(
              fontSize: SizeConfig.textMultiplier * 1.4,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
