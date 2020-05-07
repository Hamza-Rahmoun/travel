import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/provider/authentication.dart';
import 'package:travel/widget/star_page.dart';

class StartPage extends StatelessWidget {
  static const routeName = 'start page';
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (context, snapshot) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: StartedPageWidget(),
          ),
        );
      },
    );
  }
}
