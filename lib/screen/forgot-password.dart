import 'dart:async';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:travel/provider/login-provider.dart';
import 'package:travel/responsiveui/size-config.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, dynamic> _authData = {
    'email': '',
  };
  var isLoading = false;
  void _showErrorDialog(String message) {
    AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.BOTTOMSLIDE,
            tittle: 'An Error Occurred!',
            desc: '$message',
            btnOkOnPress: () {})
        .show();
  }

  void done() {
    showDialog(
        context: context,
        builder: (context) {
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: SizeConfig.heightMultiplier * 40,
                child: Container(
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
                ),
              )
            ],
          );
        });
  }

  String _warning;
  Widget showAlert() {
    if (_warning != null) {
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
                _warning,
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
                  setState(() {
                    _warning = null;
                  });
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

  void _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false)
          .sendPasswordResetEmail(
        _authData['email'],
      )
          .then((_) {
        _warning =
            "A password reset link has been sent to ${_authData['email']} ";
      });
      Timer.periodic(Duration(seconds: 5), (time) {
        Navigator.pop(context);
        time.cancel();
      });
    } catch (error) {
      var errorMessage =
          'There is no user record corresponding to this identifier. The user may have been deleted.';
      if (error.toString().contains('EMAIL_NOT_FOUND')) {}
      _showErrorDialog(errorMessage);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Stack(
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
          )
        : GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              body: ListView(
                children: <Widget>[
                  showAlert(),
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
                    height: SizeConfig.heightMultiplier * 10,
                  ),
                  Center(
                    child: Text(
                      'Reset Password',
                      style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 5,
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            strutStyle: StrutStyle(
                              height: SizeConfig.heightMultiplier * 0.1,
                            ),
                            validator: (String value) {
                              if (value.isEmpty ||
                                  !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                      .hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _authData['email'] = value;
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
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 4,
                          ),
                          GestureDetector(
                            onTap: _submit,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: SizeConfig.widthMultiplier * 12,
                                right: SizeConfig.widthMultiplier * 12,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.circular(30)),
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
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 10,
                          ),
                          GestureDetector(
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
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
