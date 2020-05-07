import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel/cliperr/clip-path.dart';
import 'package:travel/responsiveui/size-config.dart';

class ClipPathProvider with ChangeNotifier {
  Widget buildClipPath({String text, String text1}) {
    return Builder(builder: (context) {
      return ClipPath(
        clipper: CustomClipperWidget(),
        child: Container(
          height: SizeConfig.heightMultiplier * 40,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(32, 105, 194, 1),
                Colors.lightBlueAccent,
              ],
            ),
          ),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: SizeConfig.widthMultiplier * 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                children: <Widget>[
                  Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.textMultiplier * 4,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  Text(
                    text1,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.textMultiplier * 8,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
