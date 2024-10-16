
import 'package:arrow_merchandising/controller/localization_and_theme/theme.dart';

import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier{
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme(){
    if (_themeData == lightMode){
      themeData = darkMode;
    }else{
      themeData = lightMode;
    }
  }
}



// ThemeData lightMode = ThemeData(
//     brightness: Brightness.light,
//     colorScheme: ColorScheme.light(
//       primary:  Colors.black,
//       //secondary: Colors.black
//     )
// );
//
// ThemeData darkMode = ThemeData(
//     brightness:  Brightness.dark,
//     colorScheme: ColorScheme.dark(
//       primary: Colors.white,
//       //secondary: Colors.white
//     )
// );