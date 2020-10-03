import 'package:fresh_cornar/login/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:fresh_cornar/register/screen/signup.dart';

//import 'package:google_fonts/google_fonts.dart';
class UserAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            // backgroundColor: Colors.white,
            actions: <Widget>[

            ],
            // backgroundColor: Theme.of(context).accentIconTheme.color,
            elevation: 0.0,
            title: Container(
              width: MediaQuery.of(context).size.width / 2,
              child: TabBar(
                labelColor: Theme.of(context).primaryTextTheme.display1.color,
                indicatorColor: Theme.of(context).primaryColor,
                tabs: <Widget>[
                  Tab(
                    text: "Login",
                  ),
                  Tab(
                    text: "Signup",
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Login(),
              SignUp(),
            ],
          )),
    );
  }
}
