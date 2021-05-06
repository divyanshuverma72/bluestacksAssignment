import 'package:flutter/material.dart';
import 'package:flyingwolf/screens/login_screen.dart';
import 'package:flyingwolf/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Future<bool> _getLoggedInStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<bool>(
        future: _getLoggedInStatus(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data != null) {
            if (snapshot.data == false) {
              return LoginScreen();
            } else {
              return HomeScreen();
            }
          }
          return CircularProgressIndicator();
        },
      ),
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        HomeScreen.id: (context) => HomeScreen()
      },
    );
  }
}
