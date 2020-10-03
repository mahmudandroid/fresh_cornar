import 'package:flutter/material.dart';
import 'package:fresh_cornar/login/screen/login.dart';
import 'package:fresh_cornar/otp/screen/otp.dart';
import 'package:fresh_cornar/register/provider/auth.dart';
import 'package:fresh_cornar/registration_home/screen/user-admin.dart';
import 'package:fresh_cornar/otp/screen/resetPassword.dart';
import 'package:fresh_cornar/splash_screen/screen/splash_screen.dart';
import './utility/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Auth>.value(
        value: Auth(),
        child: MaterialApp(
          //title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: MyAppTheme.myAppThemeData,
          home: SplashScreen(),
          routes: {
            RestPassword.routNameRestPassword: (cotext) => RestPassword(),
          },
        ));
  }
}
