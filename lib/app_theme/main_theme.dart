import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: Colors.cyan,
      background: Colors.white,
      secondary: Colors.cyan,
    ),
    scaffoldBackgroundColor: Colors.white,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.cyan,
      ),
    ),
    bottomAppBarTheme: BottomAppBarTheme(color: Colors.cyan),
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: Colors.deepPurple,
      background: Color(0xFF252835),
      secondary: Colors.deepPurple,
    ),
    scaffoldBackgroundColor: Color(0xFF252835),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurple,
      ),
    ),
    bottomAppBarTheme: BottomAppBarTheme(color: Colors.deepPurple),
  );
}
