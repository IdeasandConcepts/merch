import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/merch_nav_bar.dart';
import 'package:arrow_merchandising/view/components/title_with_icon.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/availability/availability.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/capturephoto/after_test.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/capturephoto/before.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/invintory/inventory_screen.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/planogram/planogram_screen.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/pricing/offers.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/rtv/rtv_screen.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/share_of_shelves/share_screen.dart';
import 'package:arrow_merchandising/models/ai_planogram_model.dart';

import 'package:arrow_merchandising/models/availability_products.dart';
import 'package:arrow_merchandising/models/capture_photos.dart';

import 'package:arrow_merchandising/models/inventory_products.dart';

import 'package:arrow_merchandising/models/pricing_product.dart';
import 'package:arrow_merchandising/models/rtv_product.dart';
import 'package:arrow_merchandising/models/share_products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:arrow_merchandising/const.dart';

class AndroidDailyTasksScreen extends StatelessWidget {
  const AndroidDailyTasksScreen({
    super.key,
    required this.nationality,
    required this.manegerName,
    required this.branch,
    required this.market,
    required this.marketImage,
    required this.username,
    required this.profileImage,
    required this.id,
    required this.phone,
    required this.adminPhone,
  });

  final String nationality;
  final String manegerName;
  final String branch;
  final String market;
  final String marketImage;
  final String username;
  final String profileImage;
  final int id;
  final int phone;
  final int adminPhone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: [
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: GridView.count(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              crossAxisCount: 2,
              childAspectRatio: 1.3,
              crossAxisSpacing: 15.5,
              mainAxisSpacing: 15.5,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      Get.defaultDialog(
                          title: "Before Ordering".tr,
                          content: MaterialButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                updateMerchaData("Before Ordering");
                                Get.to(() => AndroidBeforePhoto(
                                    managerName: manegerName,
                                    title: 'Before Ordering',
                                    nationality: nationality,
                                    branch: branch,
                                    market: market,
                                    marketImage: marketImage,
                                    username: username,
                                    profileImage: profileImage,
                                    id: id,
                                    phone: phone,
                                    adminPhone: adminPhone));
                              },
                              child: DefualtButton(
                                  selected: true, text: "Start".tr)));
                    },
                    child: Card(
                      borderOnForeground: true,

                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: (completeFirstOrderingTask.length > 0)
                                    ? kprimaryColor
                                    : Colors.transparent,
                                width: 5),
                            //  color: kprimaryGradientColor,
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: TitleWithIcon(
                              icon: Icon(
                                Icons.photo_camera,
                                size: 42,
                              ),
                              title: 'Before Ordering'.tr.toUpperCase()),
                        ),
                      ),
                      //   ),
                    )),
                GestureDetector(
                  onTap: () {
                    (workingOnRtv.length > 0 || completeRtvTasks.length > 0)
                        ? (workingOnRtv.length > 0)
                            ? Get.defaultDialog(
                                title: "You have Running Task".tr,
                                content: MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: DefualtButton(
                                    text: "Back",
                                    selected: false,
                                  ),
                                ),
                              )
                            : (completeRtvTasks.length > 0)
                                ? Get.defaultDialog(
                                    title: "You Can't Open Task".tr,
                                    content: MaterialButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: DefualtButton(
                                        text: "Back",
                                        selected: false,
                                      ),
                                    ),
                                  )
                                : null
                        : Get.defaultDialog(
                            title: "RTV Section".tr,
                            content: MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  updateMerchaData("Rtv");
                                  Get.to(() => RtvSectionScreen(
                                        category: "All Categories",
                                        taskType: "Daily Task",
                                        place: "All Places",
                                        orderBy: "Daily Task",
                                        managerPhone: adminPhone,
                                        nationality: nationality,
                                        id: id,
                                        phone: phone,
                                        branch: branch,
                                        market: market,
                                        userName: username,
                                        marketImage: marketImage,
                                        profileImage: profileImage,
                                        manegerName: manegerName,
                                      ));
                                },
                                child: DefualtButton(
                                    selected: true, text: "Start".tr)));
                  },
                  child: Card(
                      borderOnForeground: true,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: (completeRtvTasks.length > 0)
                                    ? kprimaryColor
                                    : Colors.transparent,
                                width: 5),
                            //  color: kprimaryGradientColor,
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: TitleWithIcon(
                              icon: Icon(
                                Icons.bar_chart,
                                size: 42,
                              ),
                              title: 'RTV Section'.tr.toUpperCase()),
                        ),
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    Get.defaultDialog(
                        title: "Planogram".tr,
                        content: MaterialButton(
                            onPressed: () {
                              (workingOnPlanogramTasks.length > 0 ||
                                      completedPlanogramTasks.length > 0)
                                  ? (workingOnPlanogramTasks.length > 0)
                                      ? Get.defaultDialog(
                                          title: "You have Running Task".tr,
                                          content: MaterialButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: DefualtButton(
                                              text: "Back",
                                              selected: false,
                                            ),
                                          ),
                                        )
                                      : (completedPlanogramTasks.length > 0)
                                          ? Get.defaultDialog(
                                              title: "You Can't Open Task".tr,
                                              content: MaterialButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: DefualtButton(
                                                  text: "Back",
                                                  selected: false,
                                                ),
                                              ),
                                            )
                                          : null
                                  : Navigator.of(context).pop();
                              Get.to(() => PlanogramAI(
                                    taskType: "Daily Task",
                                    place: "All Places",
                                    orderBy: "Daily Task",
                                    managerName: manegerName,
                                    adminPhone: adminPhone,
                                    nationality: nationality,
                                    branch: branch,
                                    market: market,
                                    marketImage: marketImage,
                                    profileImage: profileImage,
                                    username: username,
                                    id: id,
                                    phone: phone,
                                  ));
                            },
                            child: DefualtButton(
                                selected: true, text: "Start".tr)));
                  },
                  child: Card(
                      borderOnForeground: true,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: (completedPlanogramTasks.length > 0)
                                    ? kprimaryColor
                                    : Colors.transparent,
                                width: 5),
                            //  color: kprimaryGradientColor,
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: TitleWithIcon(
                              icon: Icon(
                                Icons.browse_gallery,
                                size: 42,
                              ),
                              title: 'Planogram'.tr),
                        ),
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    (workingOnInventory.length > 0 ||
                            completeInventoryTasks.length > 0)
                        ? (workingOnInventory.length > 0)
                            ? Get.defaultDialog(
                                title: "You have Running Task".tr,
                                content: MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: DefualtButton(
                                    text: "Back",
                                    selected: false,
                                  ),
                                ),
                              )
                            : (completeInventoryTasks.length > 0)
                                ? Get.defaultDialog(
                                    title: "You Can't Open Task".tr,
                                    content: MaterialButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: DefualtButton(
                                        text: "Back",
                                        selected: false,
                                      ),
                                    ),
                                  )
                                : null
                        : Get.defaultDialog(
                            title: "Inventory".tr,
                            content: MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  updateMerchaData("Inventory");
                                  Get.to(() => InventoryScreen(
                                        category: "All Categories",
                                        taskType: "Daily Task",
                                        place: "All Places",
                                        orderBy: "Daily Task",
                                        managerName: manegerName,
                                        managerPhone: adminPhone,
                                        nationality: nationality,
                                        branch: branch,
                                        market: market,
                                        marketImage: marketImage,
                                        username: username,
                                        profileImage: profileImage,
                                        id: id,
                                        phone: phone,
                                      ));
                                },
                                child: DefualtButton(
                                    selected: true, text: "Start".tr)));
                  },
                  child: Card(
                      borderOnForeground: true,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: (completeInventoryTasks.length > 0)
                                    ? kprimaryColor
                                    : Colors.transparent,
                                width: 5),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: TitleWithIcon(
                              icon: Icon(
                                Icons.games,
                                size: 42,
                              ),
                              title: 'Inventory'.tr),
                        ),
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    (workingOnAvailability.length > 0 ||
                            completeAvailabilityTasks.length > 0)
                        ? (workingOnAvailability.length > 0)
                            ? Get.defaultDialog(
                                title: "You have Running Task".tr,
                                content: MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: DefualtButton(
                                    text: "Back",
                                    selected: false,
                                  ),
                                ),
                              )
                            : (completeAvailabilityTasks.length > 0)
                                ? Get.defaultDialog(
                                    title: "You Can't Open Task".tr,
                                    content: MaterialButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: DefualtButton(
                                        text: "Back",
                                        selected: false,
                                      ),
                                    ),
                                  )
                                : null
                        : Get.defaultDialog(
                            title: "Availability".tr,
                            content: MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  updateMerchaData("Availability");
                                  Get.to(() => Availability(
                                        category: "All Categories",
                                        taskType: "Daily Task",
                                        place: "All Places",
                                        orderBy: "Daily Task",
                                        manegerName: manegerName,
                                        managerPhone: adminPhone,
                                        nationality: nationality,
                                        // marketDetails: marketDetails,
                                        branch: branch,
                                        market: market,
                                        marketImage: marketImage,
                                        username: username,
                                        profileImage: profileImage,
                                        id: id,
                                        phone: phone,
                                      ));
                                },
                                child: DefualtButton(
                                    selected: true, text: "Start".tr)));
                  },
                  child: Card(
                      borderOnForeground: true,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: (completeAvailabilityTasks.length > 0)
                                    ? kprimaryColor
                                    : Colors.transparent,
                                width: 5),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: TitleWithIcon(
                              icon: Icon(
                                Icons.event_available,
                                size: 42,
                              ),
                              title: 'Availability'.tr),
                        ),
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    (workingOnShare.length > 0 || completeShareTasks.length > 0)
                        ? (workingOnShare.length > 0)
                            ? Get.defaultDialog(
                                title: "You have Running Task".tr,
                                content: MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: DefualtButton(
                                    text: "Back",
                                    selected: false,
                                  ),
                                ),
                              )
                            : (completeShareTasks.length > 0)
                                ? Get.defaultDialog(
                                    title: "You Can't Open Task".tr,
                                    content: MaterialButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: DefualtButton(
                                        text: "Back",
                                        selected: false,
                                      ),
                                    ),
                                  )
                                : null
                        : Get.defaultDialog(
                            title: "Share of Shelves".tr,
                            content: Container(
                              child: MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    updateMerchaData("Share of Shelves");
                                    Get.to(() => ShareOfShelfScreen(
                                          taskType: "Daily Task",
                                          place: "All Places",
                                          orderBy: "Daily Task",
                                          adminPhone: adminPhone,
                                          managerName: manegerName,
                                          nationality: nationality,
                                          branch: branch,
                                          market: market,
                                          username: username,
                                          marketImage: marketImage,
                                          profileImage: profileImage,
                                          id: id,
                                          phone: phone,
                                        ));
                                  },
                                  child: DefualtButton(
                                      selected: true, text: "Start".tr)),
                            ));
                  },
                  child: Card(
                      borderOnForeground: true,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: (completeShareTasks.length > 0)
                                    ? kprimaryColor
                                    : Colors.transparent,
                                width: 5),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: TitleWithIcon(
                              icon: Icon(
                                Icons.adjust_outlined,
                                size: 42,
                              ),
                              title: "Share of Shelves".tr.toUpperCase()),
                        ),
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    (workingOnOffers.length > 0 ||
                            completeOffersTasks.length > 0)
                        ? (workingOnOffers.length > 0)
                            ? Get.defaultDialog(
                                title: "You have Running Task".tr,
                                content: MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: DefualtButton(
                                    text: "Back",
                                    selected: false,
                                  ),
                                ),
                              )
                            : (completeOffersTasks.length > 0)
                                ? Get.defaultDialog(
                                    title: "You Can't Open Task".tr,
                                    content: MaterialButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: DefualtButton(
                                        text: "Back",
                                        selected: false,
                                      ),
                                    ),
                                  )
                                : null
                        : Get.defaultDialog(
                            title: "Offers".tr,
                            content: MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  updateMerchaData("Offers");
                                  Get.to(() => Offers(
                                      taskType: "Daily Task",
                                      place: "All Places",
                                      orderBy: "Daily Task",
                                      nationality: nationality,
                                      managerName: manegerName,
                                      branch: branch,
                                      market: market,
                                      marketImage: marketImage,
                                      username: username,
                                      profileImage: profileImage,
                                      id: id,
                                      phone: phone,
                                      adminPhone: adminPhone));
                                },
                                child: DefualtButton(
                                    selected: true, text: "Start".tr)));
                  },
                  child: Card(
                      borderOnForeground: true,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: (completeOffersTasks.length > 0)
                                    ? kprimaryColor
                                    : Colors.transparent,
                                width: 5),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: TitleWithIcon(
                              icon: Icon(
                                Icons.currency_exchange,
                                size: 42,
                              ),
                              title: 'Offers'.tr.toUpperCase()),
                        ),
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    if (firstVisitTask.length > 0)
                      Get.defaultDialog(
                          title: "After Ordering".tr,
                          content: MaterialButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                updateMerchaData("After Ordering");
                                Get.to(() => AndroidAfterPhoto(
                                    managerName: manegerName,
                                    title: 'After Ordering',
                                    nationality: nationality,
                                    //marketDetails: marketDetails,
                                    branch: branch,
                                    market: market,
                                    marketImage: marketImage,
                                    username: username,
                                    profileImage: profileImage,
                                    id: id,
                                    phone: phone,
                                    adminPhone: adminPhone));
                              },
                              child: DefualtButton(
                                  selected: true, text: "Start".tr))
                          //buildPage()
                          );
                  },
                  child: Card(
                      borderOnForeground: true,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: (completeLastOrderingTask.length > 0)
                                    ? kprimaryColor
                                    : Colors.transparent,
                                width: 5),
                            //  color: kprimaryGradientColor,
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: TitleWithIcon(
                              icon: Icon(
                                Icons.photo_camera,
                                size: 42,
                              ),
                              title: 'After Ordering'.tr.toUpperCase()),
                        ),
                      )),
                ),
              ]),
        ),
        SizedBox(
          height: 10,
        ),
        if ((completeFirstOrderingTask.length > 0) ||
            (completeRtvTasks.length > 0) ||
            (completedPlanogramTasks.length < 0) ||
            (completeInventoryTasks.length > 0) ||
            (completeAvailabilityTasks.length > 0) ||
            (completeShareTasks.length > 0) ||
            (completeOffersTasks.length > 0))
          InkWell(
            onTap: () {
              completedPlanogramTasks = [];
              completeLastOrderingTask = [];
              completeFirstOrderingTask = [];
              completeOffersTasks = [];
              completeRtvTasks = [];
              completeInventoryTasks = [];
              completeAvailabilityTasks = [];
              completeShareTasks = [];
              Get.offAll(() => MerchNavBar(
                  tab_index: 0,
                  manegerName: manegerName,
                  username: username,
                  marketImage: marketImage,
                  profileImage: profileImage,
                  branch: branch,
                  market: market,
                  id: id,
                  phone: phone,
                  nationality: nationality,
                  mangerphone: adminPhone));
            },
            child: Padding(
              padding: EdgeInsets.only(right: 15.h, left: 15.h, top: 15.h),
              child: DefualtButton(selected: true, text: "Send".tr),
            ),
          ),
      ]),
    ));
  }

  updateMerchaData(String taskTitle) async {
    var user = await FirebaseFirestore.instance
        .collection('Merchandisers')
        .where('national_id', isEqualTo: id)
        .get();
    if (user.docs.isNotEmpty) {
      var doc_Id = user.docs.first.id;
      await FirebaseFirestore.instance
          .collection('Merchandisers')
          .doc(doc_Id)
          .update({"Status".tr: "Working in".tr + " " + taskTitle + "Task".tr});
    }
  }
}
