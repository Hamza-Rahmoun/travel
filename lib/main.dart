import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:travel/provider/login-provider.dart';
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
                ChangeNotifierProvider.value(value: Auth()),
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
