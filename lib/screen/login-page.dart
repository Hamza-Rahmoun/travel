import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:travel/cliperr/clip-path.dart';
import 'package:travel/provider/login-provider.dart';
import 'package:travel/responsiveui/size-config.dart';
import 'package:travel/screen/forgot-password.dart';
import 'package:travel/screen/home-page.dart';

class LoginPage extends StatefulWidget {
  static const routeName = 'login page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _isShow = false;
  void show() {
    setState(() {
      _isShow = !_isShow;
    });
  }

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
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

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  Future<void> _login() async {
    try {
      await _googleSignIn.signIn();
    } catch (err) {
      print(err);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).login(
        _authData['email'],
        _authData['password'],
      );
    } catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('USER_DISABLED')) {
        errorMessage = 'The user account has been disabled by an administrator';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
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
        : GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SafeArea(
              child: Scaffold(
                resizeToAvoidBottomPadding: false,
                body: Form(
                    key: _formKey,
                    child: Column(
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.ideographic,
                                  children: <Widget>[
                                    Text(
                                      'Welcome Back,',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: SizeConfig.textMultiplier * 3,
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.heightMultiplier * 2,
                                    ),
                                    Text(
                                      'Log In!',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: SizeConfig.textMultiplier * 9,
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
                          child: Container(
                            height: 400,
                            child: ListView(
                              children: <Widget>[
                                SizedBox(
                                  height: SizeConfig.heightMultiplier * 3,
                                ),
                                TextFormField(
                                  strutStyle: StrutStyle(
                                    height: SizeConfig.heightMultiplier * 0.1,
                                    fontSize: SizeConfig.textMultiplier * 2,
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
                                  onSaved: (value) {
                                    _authData['password'] = value;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty || value.length < 5) {
                                      return 'Password is too short!';
                                    }
                                    return null;
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
                                      iconSize: SizeConfig.textMultiplier * 2.5,
                                      icon: Icon(_isShow
                                          ? FontAwesomeIcons.eye
                                          : FontAwesomeIcons.eyeSlash),
                                      color: Colors.blue,
                                      onPressed: show,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.heightMultiplier * 4,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            child: ForgotPassword(),
                                            type: PageTransitionType.scale,
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Forgot Password?',
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.textMultiplier * 1.4,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
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
                                          height:
                                              SizeConfig.heightMultiplier * 7,
                                          width:
                                              SizeConfig.widthMultiplier * 30,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              Color.fromRGBO(32, 105, 194, 1),
                                              Colors.lightBlueAccent,
                                            ]),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Log In',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize:
                                                    SizeConfig.textMultiplier *
                                                        2,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 2,
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                                SizedBox(
                                  height: SizeConfig.heightMultiplier * 4,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundColor:
                                          Color.fromRGBO(32, 105, 194, 1),
                                      radius: SizeConfig.widthMultiplier * 4,
                                      child: Icon(
                                        FontAwesomeIcons.twitter,
                                        color: Colors.white,
                                        size:
                                            SizeConfig.imageSizeMultiplier * 4,
                                      ),
                                    ),
                                    SizedBox(
                                      width: SizeConfig.widthMultiplier * 4,
                                    ),
                                    CircleAvatar(
                                      backgroundColor:
                                          Color.fromRGBO(220, 77, 68, 1),
                                      radius: SizeConfig.widthMultiplier * 4,
                                      child: IconButton(
                                        onPressed: () {
                                          _login().then((_) {
                                            Navigator.pushReplacementNamed(
                                                context, HomePage.routeName);
                                          });
                                        },
                                        iconSize:
                                            SizeConfig.imageSizeMultiplier * 4,
                                        icon:
                                            Icon(FontAwesomeIcons.googlePlusG),
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: SizeConfig.widthMultiplier * 4,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        auth.loginWithFb().then((_) {
                                          Navigator.pushReplacementNamed(
                                              context, HomePage.routeName);
                                        });
                                      },
                                      child: CircleAvatar(
                                        backgroundColor:
                                            Color.fromRGBO(32, 105, 194, 1),
                                        radius: SizeConfig.widthMultiplier * 4,
                                        child: Icon(
                                          FontAwesomeIcons.facebookF,
                                          color: Colors.white,
                                          size: SizeConfig.imageSizeMultiplier *
                                              4,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          );
  }
}
