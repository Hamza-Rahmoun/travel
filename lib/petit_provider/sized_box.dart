import 'package:flutter/cupertino.dart';
import 'package:travel/responsiveui/size-config.dart';

class SizedBoxProvider with ChangeNotifier {
  Widget sizedBoxHeight({double height}) {
    return SizedBox(
      height: SizeConfig.heightMultiplier * height,
    );
  }

  Widget sizedBoxWidth({double width}) {
    return SizedBox(
      width: SizeConfig.widthMultiplier * width,
    );
  }
}
