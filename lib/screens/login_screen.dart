import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flyingwolf/screens/home_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  String userName = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 150.0,
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(80),
                      child: Image.asset('images/gamedottvlogo.png')),
                  radius: 80.0,
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  userName = value;
                  if (userName.length < 3 || userName.length > 10) {
                    showToast(
                        "Username length should be minimum 3 and maximum 10 characters.");
                  }
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your user name'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                  if (password.length < 3 || password.length > 10) {
                    showToast(
                        "Password length should be minimum 3 and maximum 10 characters.");
                  }
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(30.0),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: isButtonDisabled,
                    height: 42.0,
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  isButtonDisabled() async {
    if (userName.length < 3 || userName.length > 10) {
      showToast(
          "Username length should be minimum 3 and maximum 10 characters.");
    } else if (password.length < 3 || password.length > 10) {
      showToast(
          "Password length should be minimum 3 and maximum 10 characters.");
    } else {
      if ((userName == "9898989898" || userName == "9876543210") &&
          password == "password12") {
        SharedPreferences isUserLoggedIn =
            await SharedPreferences.getInstance();
        isUserLoggedIn.setBool("isLoggedIn", true);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
      } else {
        showToast("Either user name or password is wrong.");
      }
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER);
  }
}
