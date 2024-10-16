import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary:  Colors.black,
      //secondary: Colors.black
    )
);

ThemeData darkMode = ThemeData(
    brightness:  Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: Colors.white,
      //secondary: Colors.white
    )
);