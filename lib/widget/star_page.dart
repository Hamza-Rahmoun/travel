import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/petit_provider/circle_avatar.dart';
import 'package:travel/petit_provider/clip_path.dart';
import 'package:travel/petit_provider/sized_box.dart';
import 'package:travel/provider/authentication.dart';
import 'package:travel/provider/start_page.dart';
import 'package:travel/screen/home-page.dart';

class StartedPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sizedBox = Provider.of<SizedBoxProvider>(context);
    final clipPath = Provider.of<ClipPathProvider>(context);
    final circleAvatar = Provider.of<CircleAvatarProvider>(context);
    final startPage = Provider.of<StartPageProvider>(context);
    final auth = Provider.of<Auth>(context);
    return ListView(
      children: <Widget>[
        sizedBox.sizedBoxHeight(
          height: 5,
        ),
        startPage.buildImageContainer(),
        sizedBox.sizedBoxHeight(
          height: 1,
        ),
        startPage.buildTitle(),
        sizedBox.sizedBoxHeight(
          height: 8,
        ),
        startPage.buildText(),
        sizedBox.sizedBoxHeight(
          height: 1,
        ),
        startPage.buildText1(),
        sizedBox.sizedBoxHeight(
          height: 6,
        ),
        startPage.buildFbBottom(
            sizedBox: sizedBox,
            pressed: () {
              auth.loginWithFb(context);
            }),
        sizedBox.sizedBoxHeight(
          height: 4,
        ),
        startPage.buildEmailBottom(
          context: context,
        ),
        sizedBox.sizedBoxHeight(
          height: 5,
        ),
        startPage.buildCircle(
          pressed: () {
            auth.googleSignIn(context).then((value) {
              if (value != null) {
                Navigator.pushReplacementNamed(context, HomePage.routeName);
              }
            });
          },
          circleAvatar: circleAvatar,
        ),
        sizedBox.sizedBoxHeight(
          height: 3,
        ),
        startPage.buildPageTransition(
          sizedBox: sizedBox,
          context: context,
        )
      ],
    );
  }
}
