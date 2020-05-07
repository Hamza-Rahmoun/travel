import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travel/petit_provider/circle_avatar.dart';
import 'package:travel/petit_provider/sized_box.dart';
import 'package:travel/responsiveui/size-config.dart';
import 'package:travel/screen/login-page.dart';
import 'package:travel/screen/singup-page.dart';

class StartPageProvider with ChangeNotifier {
  Row buildCircle({CircleAvatarProvider circleAvatar, Function pressed}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        circleAvatar.buildCircleAvatar(
          pressed: pressed,
          colour: Color.fromRGBO(220, 77, 68, 1),
          iconData: FontAwesomeIcons.googlePlusG,
        ),
      ],
    );
  }

  Row buildPageTransition({SizedBoxProvider sizedBox, BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Already Have Account ?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.textMultiplier * 2,
          ),
        ),
        sizedBox.sizedBoxWidth(
          width: 1,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    child: LoginPage(), type: PageTransitionType.rightToLeft));
          },
          child: Text(
            'Login',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.textMultiplier * 2,
            ),
          ),
        ),
      ],
    );
  }

  GestureDetector buildEmailBottom({BuildContext context}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            child: SignUpPage(),
            type: PageTransitionType.leftToRight,
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(
            left: SizeConfig.widthMultiplier * 13,
            right: SizeConfig.widthMultiplier * 13),
        child: Container(
          height: SizeConfig.heightMultiplier * 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              SizeConfig.widthMultiplier * 20,
            ),
            border: Border.all(
              color: Colors.black54,
              width: SizeConfig.widthMultiplier * 0.5,
            ),
          ),
          child: Center(
            child: Text(
              "i'll use email ",
              style: TextStyle(
                fontSize: SizeConfig.textMultiplier * 2,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector buildFbBottom({SizedBoxProvider sizedBox, Function pressed}) {
    return GestureDetector(
      onTap: pressed,
      child: Padding(
        padding: EdgeInsets.only(
            left: SizeConfig.widthMultiplier * 7,
            right: SizeConfig.widthMultiplier * 7),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: Container(
            height: SizeConfig.heightMultiplier * 9,
            color: Color.fromRGBO(88, 95, 255, 1),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.facebookF,
                    color: Colors.white,
                    size: SizeConfig.textMultiplier * 2.5,
                  ),
                  sizedBox.sizedBoxWidth(
                    width: 7,
                  ),
                  Text(
                    'Continue With Facebook',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.textMultiplier * 2.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Center buildText1() {
    return Center(
      child: Text(
        "it's easier to sign up now",
        style: TextStyle(
          fontSize: SizeConfig.textMultiplier * 2,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Center buildText() {
    return Center(
      child: Text(
        'Sign Up',
        style: TextStyle(
          fontSize: SizeConfig.textMultiplier * 5,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
    );
  }

  Center buildTitle() {
    return Center(
      child: Container(
        height: SizeConfig.heightMultiplier * 10,
        width: SizeConfig.widthMultiplier * 40,
        child: AutoSizeText(
          'Adventure Of A Lifetime',
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: SizeConfig.textMultiplier * 3,
            fontFamily: 'BioRhyme',
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }

  Container buildImageContainer() {
    return Container(
      height: SizeConfig.heightMultiplier * 14,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/travel.jpg',
          ),
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
