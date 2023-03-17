import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../component/constants.dart';

ThemeData theme() {
  return ThemeData(
    primaryColor: kPrimaryColor,
    primarySwatch: kPrimaryColor,
    focusColor: kPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Muli",
    appBarTheme: appBarTheme(),
  );
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light),
    iconTheme: IconThemeData(color: Colors.black),
  );
}

ThemeData lightTheme() => ThemeData(
  fontFamily: 'jannah',
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
          color: Colors.black
      ),
      textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.black,
            fontFamily: 'jannah',
            fontSize: 20,
          )
      ),
      elevation: 0
  ),

  scaffoldBackgroundColor: Colors.white,


);


ThemeData darkTheme() => ThemeData(
    fontFamily: 'jannah',
    brightness: Brightness.dark

);
