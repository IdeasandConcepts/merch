import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/view/screens/splash/auth_page.dart';
import 'package:arrow_merchandising/controller/localization_and_theme/changelocal_and_theme_controller.dart';
import 'package:arrow_merchandising/controller/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:arrow_merchandising/const.dart';

class MerchandiserDrower extends GetView<LocaleAndThemeController> {
  final int phone;
  final String name, market;
  final String profileImage;
  final String branch;
  const MerchandiserDrower({
    super.key,
    required this.name,
    required this.market,
    required this.profileImage,
    required this.branch,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    IconData langIcon = Icons.arrow_downward_sharp;
    bool openLang = false;
    LocaleAndThemeController controller = Get.put(LocaleAndThemeController());
    MyServices myServices = Get.find();
    String? sharedlang = myServices.sharedPreferences.getString("lang");
    //  Locale language = Locale(deviceLocale);
    bool isDarkMode = Get.isDarkMode;
    return Drawer(
      child: Container(
          height: 200,
          child: Wrap(
            runSpacing: 2,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 90.0),
                child: ListTile(
                  leading: ClipOval(
                    clipBehavior: Clip.hardEdge,
                    child: Material(
                      color: Colors.transparent,
                      child: Ink.image(
                        image: NetworkImage(profileImage),
                        fit: BoxFit.cover,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(name),
                      const Icon(Icons.arrow_forward),
                    ],
                  ),
                  onTap: () {},
                ),
              ),
              ListTile(
                leading: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: kprimaryColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: const Icon(
                      Icons.language,
                      color: Colors.white,
                    )),
                title: StatefulBuilder(
                  builder: (context, setState) =>
                      //child:
                      GestureDetector(
                    onTap: () {
                      setState(() {
                        openLang = !openLang;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "LANGUAGE".tr,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (openLang == false)
                ListTile(
                  leading: ElevatedButton(
                      onPressed: () {
                        controller.changLang("ar");
                      },
                      child: Text("AR".tr,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold))),
                  title: (sharedlang == "ar")
                      ? const Icon(
                          Icons.done,
                          color: kprimaryColor,
                        )
                      : null,
                ),
              // if(openLang==true)
              StatefulBuilder(
                builder: (context, setState) =>
                    //child:
                    ListTile(
                  leading: ElevatedButton(
                      onPressed: () {
                        controller.changLang("en");
                      },
                      child: Text("English".tr,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold))),
                  title: (sharedlang == "en")
                      ? const Icon(
                          Icons.done,
                          color: kprimaryColor,
                        )
                      : null,
                ),
              ),
              ListTile(
                leading: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: kprimaryColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: Icon(
                      Icons.logout_outlined,
                      color: Colors.white,
                    )),
                title: //
                    GestureDetector(
                  child: Text("Logout".tr),
                  onTap: () {
                    Get.defaultDialog(
                        title: "",
                        content: Container(
                            child: MaterialButton(
                                onPressed: () {
                                  FirebaseAuth.instance.signOut();
                                  Get.offAll(AndroidAuthPage());
                                },
                                child: DefualtButton(
                                    selected: true, text: "Logout".tr))));
                  },
                ),
                onTap: () {
                  Get.defaultDialog(
                      title: "",
                      content: Container(
                          child: MaterialButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Get.offAll(AndroidAuthPage());
                              },
                              child: DefualtButton(
                                  selected: true, text: "Logout".tr))));
                },
              ),
            ],
          )),
    );
  }
}
