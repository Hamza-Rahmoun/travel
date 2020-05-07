import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:travel/petit_provider/circle_avatar.dart';
import 'package:travel/petit_provider/clip_path.dart';
import 'package:travel/petit_provider/sized_box.dart';
import 'package:travel/provider/authentication.dart';
import 'package:travel/provider/forgotpasword_provider.dart';
import 'package:travel/provider/login_provider.dart';
import 'package:travel/provider/signup_provider.dart';
import 'package:travel/provider/start_page.dart';
import 'package:travel/responsiveui/size-config.dart';
import 'package:travel/screen/home-page.dart';
import 'package:travel/screen/login-page.dart';

import 'screen/singup-page.dart';
import 'screen/started-page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MultiProvider(
              providers: [
                ChangeNotifierProvider.value(value: SizedBoxProvider()),
                ChangeNotifierProvider.value(value: Auth()),
                ChangeNotifierProvider.value(value: ClipPathProvider()),
                ChangeNotifierProvider.value(value: CircleAvatarProvider()),
                ChangeNotifierProvider.value(value: StartPageProvider()),
                ChangeNotifierProvider.value(value: SignUpProvider()),
                ChangeNotifierProvider.value(value: LoginProvider()),
                ChangeNotifierProvider.value(value: ForgotProvider()),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                home: StartPage(),
                routes: {
                  LoginPage.routeName: (ctx) => LoginPage(),
                  SignUpPage.routeName: (ctx) => SignUpPage(),
                  HomePage.routeName: (ctx) => HomePage(),
                  StartPage.routeName: (ctx) => StartPage(),
                },
              ),
            );
          },
        );
      },
    );
  }
}
