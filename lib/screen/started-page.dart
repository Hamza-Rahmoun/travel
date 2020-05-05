import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:travel/provider/login-provider.dart';
import 'package:travel/responsiveui/size-config.dart';
import 'package:travel/screen/home-page.dart';
import 'package:travel/screen/login-page.dart';
import 'package:travel/screen/singup-page.dart';

class StartPage extends StatefulWidget {
  static const routeName = 'start page';
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    return FutureBuilder(
        future: auth.tryAutoLogin(),
        builder: (context, snapshot) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: ListView(
                children: <Widget>[
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 5,
                  ),
                  Container(
                    height: SizeConfig.heightMultiplier * 14,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/travel.jpg',
                        ),
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1,
                  ),
                  Center(
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
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 8,
                  ),
                  Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 5,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1,
                  ),
                  Center(
                    child: Text(
                      "it's easier to sign up now",
                      style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 2,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 6,
                  ),
                  GestureDetector(
                    onTap: () {
                      auth.loginWithFb().then((_) {
                        Navigator.pushReplacementNamed(
                            context, HomePage.routeName);
                      });
                    },
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
                                SizedBox(
                                  width: SizeConfig.widthMultiplier * 7,
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
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 4,
                  ),
                  GestureDetector(
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
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Color.fromRGBO(32, 105, 194, 1),
                        radius: SizeConfig.widthMultiplier * 4,
                        child: Icon(
                          FontAwesomeIcons.twitter,
                          color: Colors.white,
                          size: SizeConfig.imageSizeMultiplier * 4,
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 4,
                      ),
                      CircleAvatar(
                        backgroundColor: Color.fromRGBO(220, 77, 68, 1),
                        radius: SizeConfig.widthMultiplier * 4,
                        child: Icon(
                          FontAwesomeIcons.googlePlusG,
                          color: Colors.white,
                          size: SizeConfig.imageSizeMultiplier * 4,
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 4,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Already Have Account ?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.textMultiplier * 2,
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 1,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: LoginPage(),
                                  type: PageTransitionType.rightToLeft));
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
                  )
                ],
              ),
            ),
          );
        });
  }
}
