import 'package:flutter/material.dart';
import 'package:sqlflite_class/Appcolor.dart';

class AppTheme {
  bool theme = false;

  static ThemeData checkTheme({required ThemeMode theme}) {
    if (theme == ThemeMode.light) {
      return ThemeData(
        textTheme: TextTheme(),
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        buttonTheme: ButtonThemeData(buttonColor: AppColors.appRed),
      );
    } else {
      return ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.deepPurple,
        buttonTheme: ButtonThemeData(buttonColor: Colors.white),
      );
    }
  }
}

class AppColors {
  static Color appRed = const Color.fromARGB(146, 251, 17, 1);
  static Color appSafe = const Color.fromARGB(172, 17, 255, 0);
  // static Color appRed = const Color.fromARGB(146, 251, 17, 1);
  // static Color appRed = const Color.fromARGB(146, 251, 17, 1);
}
