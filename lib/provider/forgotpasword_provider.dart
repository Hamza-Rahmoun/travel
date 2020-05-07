import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel/responsiveui/size-config.dart';

class ForgotProvider with ChangeNotifier {
  String warning;
  Widget showAlert() {
    if (warning != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.error_outline,
                size: SizeConfig.textMultiplier * 2.5,
              ),
            ),
            Expanded(
              child: AutoSizeText(
                warning,
                maxLines: 3,
                style: TextStyle(
                  fontSize: SizeConfig.textMultiplier * 1.8,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                iconSize: SizeConfig.textMultiplier * 2.5,
                onPressed: () {
                  warning = null;
                  notifyListeners();
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }

  Stack buildLoading() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          height: SizeConfig.heightMultiplier * 8,
          width: SizeConfig.widthMultiplier * 80,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
          ),
          child: OutlineButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Loading...',
                  style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 2.5,
                  ),
                ),
                SizedBox(
                  width: SizeConfig.widthMultiplier * 5,
                ),
                CircularProgressIndicator(
                  strokeWidth: SizeConfig.widthMultiplier * 0.3,
                ),
              ],
            ),
            onPressed: () {},
          ),
        )
      ],
    );
  }

  Center buildText() {
    return Center(
      child: Text(
        'Reset Password',
        style: TextStyle(
          fontSize: SizeConfig.textMultiplier * 5,
          color: Colors.lightBlueAccent,
        ),
      ),
    );
  }

  GestureDetector buildReturn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Text(
        'Return to Login',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
    );
  }

  GestureDetector submitBottom({Function pressed}) {
    return GestureDetector(
      onTap: pressed,
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeConfig.widthMultiplier * 12,
          right: SizeConfig.widthMultiplier * 12,
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[400], borderRadius: BorderRadius.circular(30)),
          height: SizeConfig.heightMultiplier * 7,
          width: SizeConfig.widthMultiplier * 60,
          child: Center(
            child: Text(
              'Submit',
              style: TextStyle(
                color: Colors.red,
                fontSize: SizeConfig.textMultiplier * 3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
