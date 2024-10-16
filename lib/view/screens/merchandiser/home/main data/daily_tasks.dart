import 'dart:math';

import 'package:arrow_merchandising/view/screens/merchandiser/merch_nav_bar.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/profile/profile_screen.dart';
import 'package:arrow_merchandising/controller/localization_and_theme/changelocal_and_theme_controller.dart';
import 'package:arrow_merchandising/models/branch_model.dart';
import 'package:arrow_merchandising/controller/services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:arrow_merchandising/const.dart';
import 'package:vector_math/vector_math.dart';

class DailyTasks extends StatefulWidget {
  final int id, phone, adminPhone;
  final String username, marketImage, profileImage, branch, market, nationality;

  const DailyTasks(
      {super.key,
      required this.username,
      required this.marketImage,
      required this.profileImage,
      required this.branch,
      required this.market,
      required this.id,
      required this.phone,
      required this.nationality,
      required this.adminPhone});

  @override
  State<DailyTasks> createState() => _DailyTasksState();
}

class _DailyTasksState extends State<DailyTasks> with TickerProviderStateMixin {
  // {
  double distance = 0.0;
  double lat = 0.0, lang = 0.0;
  DateTime dt1 = DateTime.now();
  String dateFormat = "";
  LocaleAndThemeController controller = Get.put(LocaleAndThemeController());
  MyServices myServices = Get.find();
  String? sharedlang;
  @override
  void initState() {
    _handleLocationPermission();

    // TODO: implement initState
    sharedlang = myServices.sharedPreferences.getString("lang");
    dateFormat = DateFormat('EEEE').format(dt1);
    print(dateFormat);
    print(sharedlang);
  }

  List<int> categoriesDay = [0, 1, 2, 3, 4, 5, 6];
  List<String> category = [
    "Saturday",
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday"
  ];
  int FullIndex = 0;
  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < category.length; i++)
      if (category[i] == dateFormat) {
        FullIndex = i;
      }
    TabController controller = TabController(
        length: category.length, vsync: this, initialIndex: FullIndex);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kprimaryColor,
          title: IconButton(
              onPressed: () {
                Get.defaultDialog(
                  title: "",
                  content: MerchDrawerItems(
                    branch: widget.branch,
                    name: widget.username,
                    market: widget.market,
                    profileImage: widget.profileImage,
                    phone: widget.adminPhone,
                  ),
                );
              },
              icon: Icon(
                Icons.menu,
                color: whiteColor,
              ))),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12.h, right: 12.h),
                  child: Text(
                    "Schedule".tr,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 6.h, right: 6.h, top: 10.h),
                  child: TabBar(
                      controller: controller,
                      padding: EdgeInsets.all(1.h),
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      tabs: List.generate(
                        category.length,
                        (index) => Container(
                          height: 34.h,
                          width: 65.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: (dateFormat == category[index])
                                ? kprimaryColor
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              (sharedlang == "ar")
                                  ? category[index].tr
                                  : category[index].substring(0, 3).tr,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: (dateFormat == category[index])
                                      ? whiteColor
                                      : (categoriesDay[index] < FullIndex)
                                          ? redColor
                                          : blackColor.withOpacity(0.6),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )),
                )
              ]),
          SizedBox(
            height: 20.h,
          ),
          Container(
            height: 300,
            child: TabBarView(
                controller: controller,
                children: List.generate(
                  category.length,
                  (index) => Container(
                    height: MediaQuery.of(context).size.height - 140,
                    //padding: EdgeInsets.only(bottom: 8),
                    child: StreamBuilder<List<DailyBranch>>(
                        // builder: (context,snapshot),
                        stream: readSuperMarkets(category[index]),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text(' Error ya Ahmed :: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            final markets = snapshot.data!;
                            return GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.99,
                                  crossAxisSpacing: 12.5,
                                  mainAxisSpacing: 12.5,
                                ),
                                itemCount: markets.length,
                                itemBuilder: ((context, index) {
                                  return buildSuperMarkets(
                                    markets[index],
                                  );
                                })
                                // ]
                                );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ),
                )),
          )
        ],
      ),
    );
  }

  Widget buildSuperMarkets(DailyBranch branch) => GestureDetector(
        onTap: () async {
          Position position = await _handleLocationPermission();
          distance = distanceArea(position.latitude, branch.gpsLat,
              position.longitude, branch.gpsLon);
          print(distance);
          if ((branch.date ==
                      (DateFormat('yyyy/MM/dd')
                          .format(DateTime.now())
                          .toString()) &&
                  (branch.status != "done")) &&
              (distance > 0 && distance < 20)) {
            Get.to(() => MerchNavBar(
                  tab_index: 0,
                  manegerName: branch.managerName,
                  nationality: widget.nationality,
                  branch: branch.customerCode,
                  market: branch.customerName,
                  marketImage: branch.photo,
                  username: widget.username,
                  profileImage: widget.profileImage,
                  id: widget.id,
                  phone: widget.phone,
                  mangerphone: widget.adminPhone,
                ));
          } else {
            Get.defaultDialog(
                title: (distance < 0 || distance > 20)
                    ? "Wrong Day"
                    : "Wrong Location");

            Get.to(() => MerchNavBar(
                  tab_index: 0,
                  manegerName: branch.managerName,
                  nationality: widget.nationality,
                  branch: branch.customerCode,
                  market: branch.customerName,
                  marketImage: branch.photo,
                  username: widget.username,
                  profileImage: widget.profileImage,
                  id: widget.id,
                  phone: widget.phone,
                  mangerphone: widget.adminPhone,
                ));
          }
        },
        child: Padding(
          padding: EdgeInsets.only(right: 10.h, left: 10.h),
          child: Card(
            borderOnForeground: true,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: (branch.status == "done")
                          ? kprimaryColor
                          : transparentColor,
                      width: 5),
                  //  color: kprimaryGradientColor,
                  color: transparentColor,
                  borderRadius: BorderRadius.circular(20)),
              height: 220.h,
              width: 164.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      left: 5,
                      right: 2,
                      top: 5.h,
                    ),
                    child: Container(
                      width: 27,
                      height: 27,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: kprimaryColor.withOpacity(0.1),
                      ),
                      child: Center(
                        child: Text('${branch.marketId}',
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: blackColor,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 15,
                      right: 12,
                    ),
                    child: Text(branch.customerName,
                        style: TextStyle(
                            fontSize: 14,
                            color: blackColor,
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.all(5.h),
                    decoration: BoxDecoration(),
                    child: Image.network(
                      branch.photo,
                      width: 222.h,
                      height: 70.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateTo(branch.gpsLat, branch.gpsLon);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 8.h,
                        right: 20.h,
                        left: 20.h,
                      ),
                      child: Text(
                        "View Location".tr,
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: kTextColor,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );

  //}
  Stream<List<DailyBranch>> readSuperMarkets(String day) =>
      FirebaseFirestore.instance
          .collection('Daily Branches')
          //.orderBy('market_id')
          .where("day", isEqualTo: day)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => DailyBranch.fromJson(doc.data()))
              .toList());

  static void navigateTo(double lat, double lng) async {
    try {
      var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
      await launch(uri.toString());
    } catch (e) {
      throw "Could not launch " + e.toString();
    }
  }

  Future<Position> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      //return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        //return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  double distanceArea(double lat1, double lat2, double lang1, double lang2) {
    double area = 0.0;
    double earthRadius = 6371.0;
    setState(() {
      area = (acos((sin(radians(lat1)) * sin(radians(lat2))) +
              (cos(radians(lat1)) * cos(radians(lat2))) *
                  cos(radians(lang2) - radians(lang1)))) *
          earthRadius;
    });

    return area * 1000;
  }
}
