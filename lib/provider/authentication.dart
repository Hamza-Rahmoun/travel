import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/screen/home-page.dart';

class Auth with ChangeNotifier {
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;
  Stream<String> get onAuthStateChanged => _fireBaseAuth.onAuthStateChanged.map(
        (FirebaseUser user) => user?.uid,
      );
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    return _fireBaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyD2CXBpCIUGVX_nhMjnTCgQ8LHHIqxEBcI';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'expiryDate': _expiryDate.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  void _showErrorDialog(String message, context) {
    AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.BOTTOMSLIDE,
            tittle: 'An Error Occurred!',
            desc: '$message',
            btnOkOnPress: () {})
        .show();
  }

  final facebookLogin = FacebookLogin();
  Future<void> loginWithFb(context) async {
    FacebookLoginResult facebookLoginResult =
        await facebookLogin.logInWithReadPermissions([
      'email',
    ]);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.loggedIn:
        final accessToken = facebookLoginResult.accessToken.token;
        final facebookAuthCred =
            FacebookAuthProvider.getCredential(accessToken: accessToken);
        final user = await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCred)
            .then((value) {
          if (value != null) {
            Navigator.pushReplacementNamed(context, HomePage.routeName);
          }
        }).catchError((error) {
          var errorMessage = 'Authentication failed';
          if (error
              .toString()
              .contains('ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL')) {
            errorMessage =
                'there already exists an account with the email address asserted by Google';
          } else if (error.toString().contains('ERROR_INVALID_CREDENTIAL')) {
            errorMessage = ' the credential data is malformed or has expired';
          } else if (error.toString().contains('ERROR_USER_DISABLED')) {
            errorMessage = 'the user has been disabled';
          } else if (error.toString().contains('ERROR_OPERATION_NOT_ALLOWED')) {
            errorMessage = 'Google accounts are not enabled.';
          } else if (error.toString().contains('ERROR_INVALID_ACTION_CODE')) {
            errorMessage =
                'the action code in the link is malformed, expired, or has already been used.';
          } else if (error
              .toString()
              .contains('ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL')) {
            errorMessage =
                'An account already exists with the same email address but different sign-in credentials';
          }
          _showErrorDialog(errorMessage, context);
        });
        return user;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        break;
    }
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future googleSignIn(context) async {
    try {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      FirebaseUser _user = (await _auth.signInWithCredential(credential)).user;
      return _user;
    } catch (error) {
      var errorMessage = 'Authentication failed';
      if (error
          .toString()
          .contains('ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL')) {
        errorMessage =
            'there already exists an account with the email address asserted by Google';
      } else if (error.toString().contains('ERROR_INVALID_CREDENTIAL')) {
        errorMessage = ' the credential data is malformed or has expired';
      } else if (error.toString().contains('ERROR_USER_DISABLED')) {
        errorMessage = 'the user has been disabled';
      } else if (error.toString().contains('ERROR_OPERATION_NOT_ALLOWED')) {
        errorMessage = 'Google accounts are not enabled.';
      } else if (error.toString().contains('ERROR_INVALID_ACTION_CODE')) {
        errorMessage =
            'the action code in the link is malformed, expired, or has already been used.';
      } else if (error
          .toString()
          .contains('ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL')) {
        errorMessage =
            'An account already exists with the same email address but different sign-in credentials';
      }
      _showErrorDialog(errorMessage, context);
    }
  }
}
