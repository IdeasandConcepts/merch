import 'package:arrow_merchandising/view/screens/splash/auth_page.dart';
import 'package:arrow_merchandising/view/screens/branches_tasks/sellected_branch_tasks.dart';
import 'package:arrow_merchandising/view/screens/full_tasks/full_task_page.dart';
import 'package:arrow_merchandising/view/screens/market_tasks/market_tasks_page.dart';
import 'package:arrow_merchandising/const.dart';
import 'package:arrow_merchandising/controller/localization_and_theme/changelocal_and_theme_controller.dart';
import 'package:arrow_merchandising/view/screens/add_task/add_task.dart';
import 'package:arrow_merchandising/controller/services/services.dart';
import 'package:arrow_merchandising/view/screens/mechandiser%20list/super_clients_lists.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../view/components/default_button.dart';


class SuperDrawerItems extends StatefulWidget {
  final int phone, id;
  final String name, role, nationality;
  final String profileImage;
  final String branch, market,marketImage;
  final String comeFrom;
  const SuperDrawerItems({
    super.key,
    required this.name,
    required this.market,
    required this.profileImage,
    required this.branch,
    required this.phone,
    required this.id,
    required this.role,
    required this.nationality, 
    required this.comeFrom,
    required this.marketImage,
  });
  @override
  State<SuperDrawerItems> createState() => _SuperDrawerItemsState();
}

class _SuperDrawerItemsState extends State<SuperDrawerItems> {
  IconData langIcon = Icons.arrow_downward_sharp;
  bool openLang = false;
  LocaleAndThemeController controller = Get.put(LocaleAndThemeController());
  MyServices myServices = Get.find();
  String? sharedlang;
  @override
  void initState() {
    // TODO: implement initState
    sharedlang = myServices.sharedPreferences.getString("lang");
    super.initState();
  }

  //  Locale language = Locale(deviceLocale);
  bool isDarkMode = Get.isDarkMode;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: (openLang == false) ? 360.h : 470.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          //shrinkWrap: true,
          children: <Widget>[
            // SizedBox(height: 40,),
            ListTile(
              leading: ClipOval(
                clipBehavior: Clip.hardEdge,
                child: Material(
                  color: Colors.transparent,
                  child: Ink.image(
                    image: NetworkImage(widget.profileImage),
                    fit: BoxFit.cover,
                    height: 40,
                    width: 40,
                    // ),
                  ),
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.name),
                  const Icon(Icons.arrow_forward),
                ],
              ),
              onTap: () {},
            ),
            // const Divider(
            // color: Colors.black45,
            // ),
            ListTile(
              leading:  Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: kprimaryColor,
                  borderRadius: BorderRadius.circular(50)),
                child: Icon(
                  Icons.history_toggle_off,size: 30,
                  color: Colors.white,
                ),
              ),
              title: Row(      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add Task".tr,
                    style: TextStyle(fontSize: 18, ),
                  ),
                  Icon(
                   Icons.arrow_forward,
                    // size: 30,
                    // color: Colors.black,
                  ),
                ],
              ),
              //subtitle:
              onTap: () {

                Get.defaultDialog(
                    title: "",
                    content: Container(
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.broken_image),
                            title: Text("RTV Section".tr),
                            onTap: () {
                              Navigator.of(context).pop();
                              Get.to(() => AddTaskScreen(
                                    taskTitle: "RTV Section",
                                    comeFrom: widget.comeFrom,
                                    selectedMarket: widget.market,
                                    selectedMarketImage: widget.marketImage,
                                    selectedMerch: "",
                                    id: widget.id,
                                    phone: widget.phone,
                                    selectedBranch: widget.branch,
                                    userName: widget.name,
                                    profileImage: widget.profileImage,
                                  ));
                              //Get.delegate();
                              //DrawerButton(onPressed: ,)
                              // Get.delete();
                              // Get.back();
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.inventory),
                            title: Text("Inventory".tr),

                            onTap: () {
                              Navigator.of(context).pop();
                              Get.to(() => AddTaskScreen(
                                    taskTitle: "Inventory",
                                comeFrom: widget.comeFrom,
                                selectedMarket: widget.market,
                                selectedMarketImage: widget.marketImage,
                                selectedMerch: "",
                                id: widget.id,
                                phone: widget.phone,
                                selectedBranch: widget.branch,
                                userName: widget.name,
                                profileImage: widget.profileImage,

                                    // amount: 3,
                                  ));
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.event_available),
                            title: Text("Availability".tr),
                            onTap: () {
                              Navigator.of(context).pop();
                              Get.to(() => AddTaskScreen(
                                    taskTitle: "Availability",
                                comeFrom: widget.comeFrom,
                                selectedMarket: widget.market,
                                selectedMarketImage: widget.marketImage,
                                selectedMerch: "",
                                id: widget.id,
                                phone: widget.phone,
                                selectedBranch: widget.branch,
                                userName: widget.name,
                                profileImage: widget.profileImage,
                              ));
                            },
                          ),
                          ListTile(
                              leading: const Icon(Icons.shelves),
                              title: Text("Share Of Shelve".tr),
                              onTap: () {
                                Navigator.of(context).pop();
                                Get.to(() => AddTaskScreen(
                                          taskTitle: "Share Of Shelve",
                                  comeFrom: widget.comeFrom,
                                  selectedMarket: widget.market,
                                  selectedMarketImage: widget.marketImage,
                                  selectedMerch: "",
                                  id: widget.id,
                                  phone: widget.phone,
                                  selectedBranch: widget.branch,
                                  userName: widget.name,
                                  profileImage: widget.profileImage,      //city: '',
                                          //  branch: "All "
                                        )
                                    // branches: [],
                                    );
                              }),
                          ListTile(
                              leading: const Icon(Icons.currency_exchange),
                              title: Text("Offers".tr),
                              onTap: () {
                                Navigator.of(context).pop();
                                Get.to(() => AddTaskScreen(
                                          taskTitle: "Offers",
                                  comeFrom: widget.comeFrom,
                                  selectedMarket: widget.market,
                                  selectedMarketImage: widget.marketImage,
                                  selectedMerch: "",
                                  id: widget.id,
                                  phone: widget.phone,
                                  selectedBranch: widget.branch,
                                  userName: widget.name,
                                  profileImage: widget.profileImage,
                                  //profileImage: widget.profileImage,

                                          //city: '',
                                          //  branch: "All "
                                        )
                                    // branches: [],
                                    );
                              }),
                          ListTile(
                              leading: const Icon(Icons.currency_exchange),
                              title: Text("Planogram".tr),
                              onTap: () {
                                Navigator.of(context).pop();
                                Get.to(() => AddTaskScreen(
                                  taskTitle: "Planogram",
                                  comeFrom: widget.comeFrom,
                                  selectedMarket: widget.market,
                                  selectedMarketImage: widget.marketImage,
                                  selectedMerch: "",
                                  id: widget.id,
                                  phone: widget.phone,
                                  selectedBranch: widget.branch,
                                  userName: widget.name,
                                  profileImage: widget.profileImage,
                                  //city: '',
                                  //  branch: "All "
                                )
                                  // branches: [],
                                );
                              }),
                        ],
                      ),
                    ));
              },
            ),

            ListTile(
              leading:Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: kprimaryColor,
                  borderRadius: BorderRadius.circular(50)),
                child: Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                ),
              ),
              title: Row(      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Task's List".tr,
                    style: TextStyle(fontSize: 18, ),
                  ),
                  Icon(Icons.arrow_forward, ),
                ],
              ),
              onTap: () {
                // Get.defaultDialog(
                // title: "",
                // content: Container(
                // child:  Column(
                // children: [
                // ListTile(
                // leading: const Icon(Icons.done_outline),
                // title: Text("Done Tasks".tr),
                // onTap: () {

                if(widget.comeFrom=="All Markets") {
                  Navigator.of(context).pop();
                  Get.to(() =>
                      FullTaskScreen(
                        role: widget.role,
                        username: widget.name,
                        profileImage: widget.profileImage,
                        id: widget.id,
                        phone: widget.phone,
                        nationality: widget.nationality,
                      )
                    // branches: [],
                  );
                }
                else if(
                (
                widget.comeFrom!="All Markets")
                &&
                    (widget.branch=="All Branches")
                )

                {
                  Navigator.of(context).pop();
                  print(widget.market);
                  Get.to(() =>
                      AndroidMarketTasksScreen(
                        market: widget.market,
                        marketImage: widget.marketImage,
                        branch: widget.branch,
                        role: widget.role,
                        username: widget.name,
                        profileImage: widget.profileImage,
                        id: widget.id,
                        phone: widget.phone,
                        nationality: widget.nationality,
                      )
                    // branches: [],
                  );
                }
                else{
                  Navigator.of(context).pop();
                  print(widget.branch);
                  Get.to(() =>
                      AndroidBranchTasksScreen(
                        market: widget.market,
                        marketImage: widget.marketImage,
                        branch: widget.branch,
                        role: widget.role,
                        username: widget.name,
                        profileImage: widget.profileImage,
                        id: widget.id,
                        phone: widget.phone,
                        nationality: widget.nationality,
                      )
                    // branches: [],
                  );
                }
              },
            ),
            ListTile(
                leading:  Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: kprimaryColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: Icon(
                    Icons.person, size: 30, color:  Colors.white,),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Merchandisers List".tr,
                      style: TextStyle(fontSize: 15, )),
                    Icon(Icons.arrow_forward)
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Get.to(() =>
                      AndroidSuperClientList(

                        marketImage: "",
                        role: widget.role,
                        //branchesList: branchesList,
                        market: widget.market,
                        name: widget.name,

                        // marketImage:,
                        profileImage: widget.profileImage,
                        city:"",
                        id: widget.id,
                        phone: widget.phone,
                        //marketDetails:marketDetails,
                        nationality: widget.nationality,
                        //branch: branch
                      )
                  );
                  //   // branches: [],
                  // );
                }),
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
              title: GestureDetector(
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
                    Icon((openLang == true) ? langIcon : Icons.arrow_forward),
                  ],
                ),
              ),
            ),
            if (openLang == true)
              ListTile(
                leading: ElevatedButton(
                    onPressed: () {
                      controller.changLang("ar");
                      setState(() {
                        controller.changLang("ar");
                      });
                      //Navigator.of(context).pop();
                      Get.offAll(AndroidAuthPage());
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
            if (openLang == true)
              StatefulBuilder(
                builder: (context, setState) =>
                    //child:
                    ListTile(
                  leading: ElevatedButton(
                      onPressed: () {
                        controller.changLang("en");
                        setState(() {
                          controller.changLang("en");
                        });
                        Get.offAll(AndroidAuthPage());
                        // Navigator.of(context).pop();
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
            // ListTile(
            //   leading: StatefulBuilder(
            //     builder: (context, setState) => Switch(
            //       value: isDarkMode,
            //       onChanged: (value) {
            //         isDarkMode = value;
            //         controller.changeTheme();
            //         setState(() {
            //           controller.changeTheme();
            //         });
            //       },
            //     ),
            //   ),
            //   title: Text("Dark Mode".tr,
            //       style: const TextStyle(
            //           fontSize: 12, fontWeight: FontWeight.bold)),
            // ),

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
                  // FirebaseAuth.instance.signOut();
                  // Get.offAll(AndroidAuthPage());
                },
              ),

              // ),

              //   ),

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
        )
        // Container(
        //   child: buildHeader(context),
        //   decoration:
        //       BoxDecoration(borderRadius: BorderRadius.circular(30)),
        // ),
        // buildMenueItems(context),
        //   ],
        );
  }
}
