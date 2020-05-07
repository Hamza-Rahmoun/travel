import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel/responsiveui/size-config.dart';

class SignUpProvider with ChangeNotifier {
  TextFormField buildEmailField({Function pressed}) {
    return TextFormField(
      strutStyle: StrutStyle(
        height: SizeConfig.heightMultiplier * 0.1,
      ),
      onSaved: pressed,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            style: BorderStyle.none,
            width: 1,
          ),
        ),
        hintText: 'Email Address',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        prefixIcon: Icon(
          Icons.email,
          size: SizeConfig.textMultiplier * 3,
          color: Colors.blue,
        ),
      ),
    );
  }

  TextFormField buildPasswordField(
      {TextEditingController editingController,
      Function pressed,
      bool show,
      Function showBottom}) {
    return TextFormField(
      strutStyle: StrutStyle(
        height: SizeConfig.heightMultiplier * 0.1,
      ),
      validator: (value) {
        if (value.isEmpty || value.length < 5) {
          return 'Password is too short!';
        }
        return null;
      },
      controller: editingController,
      onSaved: pressed,
      obscureText: show ? false : true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            style: BorderStyle.none,
            width: 1,
          ),
        ),
        hintText: 'Password',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        prefixIcon: Icon(
          Icons.lock,
          size: SizeConfig.textMultiplier * 3,
          color: Colors.blue,
        ),
        suffixIcon: IconButton(
          icon: Icon(show ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye),
          iconSize: SizeConfig.textMultiplier * 2.5,
          onPressed: showBottom,
          color: Colors.blue,
        ),
      ),
    );
  }

  TextFormField buildConfirmPasswordField(
      {TextEditingController editingController,
      Function pressed,
      bool show,
      Function showBottom}) {
    return TextFormField(
      strutStyle: StrutStyle(
        height: SizeConfig.heightMultiplier * 0.1,
      ),
      validator: (value) {
        if (value.isEmpty || value.length < 5) {
          return 'Password is too short!';
        }
        if (value.length > 50) {
          return 'Password is too long!';
        }
        if (value != editingController.text) {
          return 'Passwords do not match!!';
        }
        return null;
      },
      onSaved: pressed,
      obscureText: show ? false : true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            style: BorderStyle.none,
            width: 1,
          ),
        ),
        hintText: 'Confirm Password',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        prefixIcon: Icon(
          Icons.lock,
          size: SizeConfig.textMultiplier * 3,
          color: Colors.blue,
        ),
        suffixIcon: IconButton(
          icon: Icon(show ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye),
          iconSize: SizeConfig.textMultiplier * 2.5,
          onPressed: showBottom,
          color: Colors.blue,
        ),
      ),
    );
  }

  GestureDetector buildSignBottom({Function onTap, bool loading, String text}) {
    return GestureDetector(
      onTap: onTap,
      child: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: SizeConfig.heightMultiplier * 7,
              width: SizeConfig.widthMultiplier * 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(32, 105, 194, 1),
                  Colors.lightBlueAccent,
                ]),
              ),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.textMultiplier * 2,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
    );
  }

  SwitchListTile buildSwitchListTile({bool value, Function changed}) {
    return SwitchListTile(
      title: Row(
        children: <Widget>[
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'I Accepte',
                style: TextStyle(
                  fontSize: SizeConfig.textMultiplier * 1.7,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: 'The Policy And Terms',
                style: TextStyle(
                  fontSize: SizeConfig.textMultiplier * 1.7,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print('Label has been tapped.');
                  },
              )
            ]),
          ),
        ],
      ),
      value: value,
      onChanged: changed,
    );
  }

  Widget build({bool value, Function changed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'I Accepte',
                style: TextStyle(
                  fontSize: SizeConfig.textMultiplier * 1.7,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: 'The Policy And Terms',
                style: TextStyle(
                  fontSize: SizeConfig.textMultiplier * 1.7,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print('Label has been tapped.');
                  },
              )
            ]),
          ),
          Switch(
            value: value,
            onChanged: changed,
          ),
        ],
      ),
    );
  }
}
