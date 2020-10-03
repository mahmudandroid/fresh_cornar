import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fresh_cornar/login/screen/login.dart';
import 'package:fresh_cornar/registration_home/screen/user-admin.dart';
import 'package:fresh_cornar/utility/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
//    void initState() {
//      // TODO: implement initState
//      super.initState();
//      checkUserExisting();
//    }
  //  checkUserExisting(context);

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return UserAdmin();
          },
        ),
      );
    });




    TextStyle _testStyle = new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22.0,
        color: MyAppTheme.myAppThemeData.primaryColor,
        fontFamily: "Roboto"
    );
    TextStyle _testStyleHeader = new TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15.0,
    );

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Image.asset(
          "assets/spalsh.png", fit: BoxFit.fitWidth, height: double.infinity, ),
    );
  }

  Future<void> checkUserExisting(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool seen = preferences.getBool("seen");

    if (seen == null) seen = false;

    if (seen) {
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Login();
            },
          ),
        );
      });
    } else {
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Login();
            },
          ),
        );
      });
    }
  }
}
