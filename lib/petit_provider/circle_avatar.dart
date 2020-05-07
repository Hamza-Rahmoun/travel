import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel/responsiveui/size-config.dart';

class CircleAvatarProvider with ChangeNotifier {
  Widget buildCircleAvatar({
    Function pressed,
    Color colour,
    IconData iconData,
  }) {
    return GestureDetector(
      onTap: pressed,
      child: CircleAvatar(
        backgroundColor: colour,
        radius: SizeConfig.widthMultiplier * 4,
        child: Icon(
          iconData,
          color: Colors.white,
          size: SizeConfig.imageSizeMultiplier * 4,
        ),
      ),
    );
  }
}
