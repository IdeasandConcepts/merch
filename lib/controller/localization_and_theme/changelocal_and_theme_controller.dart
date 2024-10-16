import '../services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocaleAndThemeController extends GetxController {
  Locale? language;
  MyServices myServices = Get.find();
  late ThemeData appTheme;
  late bool openLang;
changeLangIcon()
{
  if(openLang==true)
  {
    openLang=false;
  }else {
    openLang=true;
  }

}
  changLang(String langCode) {
    Locale locale = Locale(langCode);
    // save in shard ...

    myServices.sharedPreferences.setString("lang", langCode);
    Get.updateLocale(locale);
  }

  changeTheme() {
    if (Get.isDarkMode) {
      Get.changeTheme(ThemeData.light(useMaterial3: true));
    } else {
      Get.changeTheme(ThemeData.dark(useMaterial3: true));
      // save in shard ...
    }
    myServices.sharedPreferences.setBool("isDarkMode", !Get.isDarkMode);
  }

  @override
  void onInit() {
    String? sharedlang = myServices.sharedPreferences.getString("lang");
    bool? sharedisDarkMode = myServices.sharedPreferences.getBool("isDarkMode");
    if (sharedlang == "en") {
      language = const Locale("en");
    } else if (sharedlang == "ar") {
      language = const Locale("ar");
    } else {
      String deviceLocale = Get.deviceLocale!.languageCode;
      language = Locale(deviceLocale);
    }
    if (sharedisDarkMode == true) {
      appTheme = ThemeData.dark(useMaterial3: true);
    } else {
      appTheme = ThemeData.light(useMaterial3: true);
    }
    openLang=false;
    super.onInit();
  }
}
