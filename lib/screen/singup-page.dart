import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travel/cliperr/clip-path.dart';
import 'package:travel/provider/login-provider.dart';
import 'package:travel/responsiveui/size-config.dart';
import 'package:travel/screen/home-page.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = 'signup';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var _isShow = false;
  var _isShow1 = false;
  void show() {
    setState(() {
      _isShow = !_isShow;
    });
  }

  void show1() {
    setState(() {
      _isShow1 = !_isShow1;
    });
  }

  final _passwordController = TextEditingController();
  Map<String, dynamic> _authData = {
    'email': '',
    'password': '',
    'acceptTerms': false,
    'error': '',
  };
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;
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

  Future<void> _submit() async {
    if (!_formKey.currentState.validate() || !_authData['acceptTerms']) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).signUp(
        _authData['email'],
        _authData['password'],
      );
    } catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('OPERATION_NOT_ALLOWED')) {
        errorMessage = 'Password sign-in is disabled for this project.';
      } else if (error.toString().contains('TOO_MANY_ATTEMPTS_TRY_LATER')) {
        errorMessage =
            'We have blocked all requests from this device due to unusual activity. Try again later.';
      }
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    return auth.isAuth
        ? HomePage()
        : SafeArea(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Scaffold(
                body: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      ClipPath(
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
                                    'hello,',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: SizeConfig.textMultiplier * 4,
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier * 2,
                                  ),
                                  Text(
                                    'Sign Up!',
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 3,
                            ),
                            TextFormField(
                              strutStyle: StrutStyle(
                                height: SizeConfig.heightMultiplier * 0.1,
                              ),
                              onSaved: (value) {
                                _authData['email'] = value;
                              },
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
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 3,
                            ),
                            TextFormField(
                              strutStyle: StrutStyle(
                                height: SizeConfig.heightMultiplier * 0.1,
                              ),
                              validator: (value) {
                                if (value.isEmpty || value.length < 5) {
                                  return 'Password is too short!';
                                }
                                return null;
                              },
                              controller: _passwordController,
                              onSaved: (value) {
                                _authData['password'] = value;
                              },
                              obscureText: _isShow ? false : true,
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
                                  icon: Icon(_isShow
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash),
                                  iconSize: SizeConfig.textMultiplier * 2.5,
                                  onPressed: show,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 2,
                            ),
                            TextFormField(
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
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match!!';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _authData['password'] = value;
                              },
                              obscureText: _isShow1 ? false : true,
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
                                  icon: Icon(_isShow1
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash),
                                  iconSize: SizeConfig.textMultiplier * 2.5,
                                  onPressed: show1,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 2,
                            ),
                            SwitchListTile(
                              title: Text(
                                'I Accepte The Policy And Terms',
                                style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 1.7,
                                ),
                              ),
                              value: _authData['acceptTerms'],
                              onChanged: (bool value) {
                                setState(() {
                                  _authData['acceptTerms'] = value;
                                });
                              },
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 2,
                            ),
                            GestureDetector(
                              onTap: _submit,
                              child: _isLoading
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
                                          'Sign up',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
