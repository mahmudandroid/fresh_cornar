import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppTheme {
  static hexColor(String hex) {
    String finalcolor = '0xff' + hex;
    int integerColor = int.parse(finalcolor);
    return integerColor;
  }

  /*ThemeData get myAppThemeData {
    return myAppThemeData;
  }*/

  static ThemeData myAppThemeData = new ThemeData(
    fontFamily: 'Roboto',
    primaryColor: Color(hexColor("FF5757")),
    primaryColorLight: Color(hexColor("FB7754")),
    primaryColorDark: Color(hexColor("d32f2f")),
    accentColor: Color(hexColor("FACD7A")),
    primaryTextTheme: TextTheme(
      //header
      headline1: TextStyle(fontWeight: FontWeight.w300,fontSize:95,letterSpacing: -1.5 ,color: Color(hexColor("212121"))),
      headline2: TextStyle(fontWeight: FontWeight.w300,fontSize:60,letterSpacing: -0.5 ,color: Color(hexColor("212121"))),
      headline3: TextStyle(fontWeight: FontWeight.w400,fontSize:48,letterSpacing: 0 ,color: Color(hexColor("212121"))),
      headline4: TextStyle(fontWeight: FontWeight.w400,fontSize:34,letterSpacing: 0.25 ,color: Color(hexColor("212121"))),
      headline5: TextStyle(fontWeight: FontWeight.w400,fontSize:24,letterSpacing: 0 ,color: Color(hexColor("212121"))),
      headline6: TextStyle(fontWeight: FontWeight.w500,fontSize:20,letterSpacing: 0.15 ,color: Color(hexColor("212121"))),
      subtitle1: TextStyle(fontWeight: FontWeight.w400,fontSize:16,letterSpacing: 0.15 ,color: Color(hexColor("757575"))),
      subtitle2: TextStyle(fontWeight: FontWeight.w500,fontSize:14,letterSpacing: 0.1 ,color: Color(hexColor("757575"))),
      button: TextStyle(fontWeight: FontWeight.w500,fontSize:14,letterSpacing: 1.25 ,color: Color(hexColor("ffffff"))),
      caption: TextStyle(fontWeight: FontWeight.w400,fontSize:12,letterSpacing: 0.4 ,color: Color(hexColor("bdbdbd"))),

      //TextStyle(color: Color(hexColor("212121")), ),
      //subtitle
      overline:TextStyle(fontWeight: FontWeight.w400,fontSize:10,letterSpacing: 0.5 ,color: Color(hexColor("212121"))),
      //subtitle

    ),
    dividerColor: Color(hexColor("BDBDBD")),
    //subtitle
    secondaryHeaderColor: Color(
      hexColor("757575"),
    ),
    iconTheme: IconThemeData(
      color: Color(hexColor("ffffff")),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(hexColor("f44336")),
    ),
    dialogBackgroundColor: Color(hexColor('00C851')), //as success
    dialogTheme: DialogTheme(
      backgroundColor: Color(hexColor('ffbb33')), //as Warning
      contentTextStyle: TextStyle(color: Color(hexColor('ff4444'))),
    ),
    errorColor: Color(hexColor('ff4444')), //as danger

    appBarTheme: AppBarTheme(
      elevation: 0.0,
      color: Colors.white,
      iconTheme: IconThemeData(color: Color(hexColor("212121")))
    ),
    scaffoldBackgroundColor: Color(hexColor("ffffff")),
    bottomAppBarTheme: BottomAppBarTheme(
      color: Color(hexColor("ffffff")),
      elevation: 0.0,
    ),

    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  );
}
