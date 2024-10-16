import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/main%20data/daily_tasks.dart';
import 'package:arrow_merchandising/const.dart';
import 'package:arrow_merchandising/controller/localization_and_theme/changelocal_and_theme_controller.dart';
import 'package:arrow_merchandising/models/availability_products.dart';
import 'package:arrow_merchandising/models/inventory_products.dart';
import 'package:arrow_merchandising/models/pricing_product.dart';
import 'package:arrow_merchandising/models/rtv_product.dart';
import 'package:arrow_merchandising/models/share_products.dart';
import 'package:arrow_merchandising/controller/services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class HomeDetails extends StatefulWidget {
  final String marketImage, userImage, market, branch;
  final int mangerPhone, merchPhone, id;
  final String userName, manegerName, nationality;
  final int completeTasks, restedTasks, notYetList;
  final List<String> pricingNotYetList,
      rtvNotYetList,
      shareNotYetList,
      inventoryNotYetList,
      availabilityNotYetList;

  const HomeDetails(
      {super.key,
      required this.userName,
      required this.market,
      required this.marketImage,
      required this.manegerName,
      required this.mangerPhone,
      required this.userImage,
      required this.completeTasks,
      required this.restedTasks,
      required this.notYetList,
      required this.pricingNotYetList,
      required this.rtvNotYetList,
      required this.shareNotYetList,
      required this.inventoryNotYetList,
      required this.availabilityNotYetList,
      required this.merchPhone,
      required this.id,
      required this.nationality,
      required this.branch});

  @override
  State<HomeDetails> createState() => _HomeDetailsState();
}

class _HomeDetailsState extends State<HomeDetails> {
  List<String> category = [
    "Saturday",
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday"
  ];
  DateTime dt1 = DateTime.now();
  String dateFormat = "";

  LocaleAndThemeController controller = Get.put(LocaleAndThemeController());
  MyServices myServices = Get.find();
  String? sharedlang;
  @override
  void initState() {
    // TODO: implement initState
    sharedlang = myServices.sharedPreferences.getString("lang");
    dateFormat = DateFormat('EEEE').format(dt1);
    print(dateFormat);
    super.initState();
  }
  bool closeBranch = false;
  List<int> categoriesDay = [0, 1, 2, 3, 4, 5, 6];

  int FullIndex = 0;
  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < category.length; i++)
      if (category[i] == dateFormat) {
        FullIndex = i;
      }

    return Container(
      padding: EdgeInsets.all(10),
      height: 800,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        // border: Border.all()
      ),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10.h,
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
                  child: Row(
                      children: List.generate(
                    category.length,
                    (index) => Container(
                      height: 34.h,
                      width: 50.w,
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
                              fontSize: 12.sp,
                              color: (dateFormat == category[index])
                                  ? Colors.white
                                  : (categoriesDay[index] < FullIndex)
                                      ? Colors.red
                                      : Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )),
                )
              ]),
          Padding(
            padding: EdgeInsets.all(10.h),
            child: Container(
              height: 150.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(55.0),
                  topRight: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0),
                  bottomLeft: Radius.circular(55.0),
                ),
              ),
              child: Image.asset(
                "assets/images/merch.jpeg",
                height: 141.h,
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 15.5,
              mainAxisSpacing: 15.5,
              padding: EdgeInsets.only(left: 10.h, right: 10.h),
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Card(
                    color: Color(0xf6f6f6f6),
                    clipBehavior: Clip.antiAlias,
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 10.h,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          height: 25,
                          child: Center(
                            child: Text(
                              'System Attendance'.tr,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: kprimaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Divider(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      ClipOval(
                        clipBehavior: Clip.antiAlias,
                        child: Material(
                          borderOnForeground: true,
                          color: Colors.black,
                          child: Ink.image(
                            image: NetworkImage(
                              widget.marketImage,
                            ),
                            fit: BoxFit.cover,
                            height: 100.h,
                            width: 102.h,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 10.h, right: 10.h, top: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (DateFormat('yyyy/MM/dd')
                                  .format(DateTime.now())
                                  .toString()),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp),
                            ),
                            Text(
                              DateFormat('kk:mm:a')
                                  .format(DateTime.now())
                                  .toString(),
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                              // DateTime.now().toString(),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
                Container(
                  //height: 149.h,
                  decoration: BoxDecoration(
                    // Colors.transparent
                    borderRadius: BorderRadius.circular(25),
                    //  border: Border.all()
                  ),
                  child: Card(
                    color: Color(0xf6f6f6f6),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10.h, right: 10.h, left: 10.h),
                          child: Container(
                            // padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              // color: kprimaryColor.withOpacity(0.5),
                            ),
                            height: 25.h,
                            child: Center(
                              child: Text(
                                'Job Information'.tr,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: kprimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Divider(
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          height: 140.h,
                          width: 150.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 10.h,
                                ),
                                child: Text(
                                  'Today Planned'.tr + '\t${widget.notYetList}',
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              //SizedBox(height: 10,),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 20.h,
                                ),
                                child: Text(
                                  'Complete'.tr +
                                      "\t:\t" +
                                      '${widget.completeTasks}',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: kprimaryColor,
                                  ),
                                ),
                              ),
                              //SizedBox(height: 10,),
                              GestureDetector(
                                  onTap: () {
                                    if (widget.notYetList > 0)
                                      Get.defaultDialog(
                                        title: 'Details'.tr,
                                        content: SingleChildScrollView(
                                            child: Padding(
                                          padding: EdgeInsets.only(
                                            right: 15.w,
                                            left: 15.w,
                                          ),
                                          child: Container(

                                              decoration: BoxDecoration(
                                                  color: kprimaryColor,
                                                  // .withOpacity(0.45),
                                                  borderRadius:
                                                      // border: BorderRadius.circular(15)
                                                      // border
                                                      BorderRadius.circular(
                                                          15)),
                                              child: DataTable(
                                                  dataTextStyle: TextStyle(
                                                      fontSize: 20.sp),

                                                  columns: [
                                                    DataColumn(
                                                        label: Text(
                                                      'Task'.tr.toUpperCase(),
                                                      style: TextStyle(
                                                          fontSize: 10.sp,
                                                          color:
                                                              Colors.black87),
                                                    )),
                                                    DataColumn(
                                                        label: Text(
                                                      "Numbers",
                                                      style: TextStyle(
                                                          fontSize: 10.sp,
                                                          color:
                                                              Colors.black87),
                                                    )),
                                                  ],
                                                  rows: [
                                                    if (widget.rtvNotYetList
                                                            .length >
                                                        0)
                                                      DataRow(cells: <DataCell>[
                                                        DataCell(Text(
                                                          'RTV Section'
                                                              .tr
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                              fontSize: 10.sp,
                                                              color: Colors
                                                                  .black87),
                                                        )),
                                                        DataCell(Text(
                                                          '${widget.rtvNotYetList.length}',
                                                          style: TextStyle(
                                                              fontSize: 10.sp,
                                                              color: Colors
                                                                  .black87),
                                                        )),
                                                      ]),
                                                    if (widget
                                                            .inventoryNotYetList
                                                            .length >
                                                        0)
                                                      DataRow(cells: <DataCell>[
                                                        DataCell(Text(
                                                          'Inventory'
                                                              .tr
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                              fontSize: 10.sp,
                                                              color: Colors
                                                                  .black87),
                                                        )),
                                                        DataCell(Text(
                                                          '${widget.inventoryNotYetList.length}',
                                                          style: TextStyle(
                                                              fontSize: 10.sp,
                                                              color: Colors
                                                                  .black87),
                                                        )),
                                                      ]),
                                                    if (widget
                                                            .availabilityNotYetList
                                                            .length >
                                                        0)
                                                      DataRow(cells: <DataCell>[
                                                        DataCell(Text(
                                                          'Availability'
                                                              .tr
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                              fontSize: 10.sp,
                                                              color: Colors
                                                                  .black87),
                                                        )),
                                                        DataCell(Text(
                                                          '${widget.availabilityNotYetList.length}',
                                                          style: TextStyle(
                                                              fontSize: 10.sp,
                                                              color: Colors
                                                                  .black87),
                                                        )),
                                                      ]),
                                                    if (widget.shareNotYetList
                                                            .length >
                                                        0)
                                                      DataRow(cells: <DataCell>[
                                                        DataCell(Text(
                                                          'Share Of Shelves'
                                                              .tr
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                              fontSize: 10.sp,
                                                              color: Colors
                                                                  .black87),
                                                        )),
                                                        DataCell(Text(
                                                          '${widget.shareNotYetList.length}',
                                                          style: TextStyle(
                                                              fontSize: 10.sp,
                                                              color: Colors
                                                                  .black87),
                                                        )),
                                                      ]),
                                                    if (widget.pricingNotYetList
                                                            .length >
                                                        0)
                                                      DataRow(cells: <DataCell>[
                                                        DataCell(Text(
                                                          'Offers'
                                                              .tr
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                              fontSize: 10.sp,
                                                              color: Colors
                                                                  .black87),
                                                        )),
                                                        DataCell(Text(
                                                          '${widget.pricingNotYetList.length}',
                                                          style: TextStyle(
                                                              fontSize: 10.sp,
                                                              color: Colors
                                                                  .black87),
                                                        )),
                                                      ]),

                                                    // )
                                                  ])),
                                        )),
                                      );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: 20.h,
                                    ),
                                    child: Text(
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.sp,
                                        color: Colors.red,
                                        decoration: TextDecoration.underline,
                                      ),
                                      'Un Completed'.tr +
                                          "\t:\t" +
                                          '${widget.notYetList - widget.completeTasks}',
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    //height: 110,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                    ),

                    child: Card(
                        color: Color(0xf6f6f6f6),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 10.h, right: 10.h, left: 10.h),
                                child: Container(
                                    child: Center(
                                  child: Text(
                                    'Finish Branch'.tr,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: kprimaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Divider(
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 7.h,
                              ),
                              Padding(
                                  padding:
                                      EdgeInsets.only(left: 25.w, right: 25.w),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipOval(
                                          clipBehavior: Clip.antiAlias,
                                          //  clipBehavior: Clip.hardEdge,
                                          child: Material(
                                            borderOnForeground: true,
                                            color: Colors.white,
                                            child: Container(
                                              height: 85.h,
                                              width: 85.w,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: kprimaryColor),
                                              child: Icon(
                                                Icons.account_balance,
                                                size: 30.sp,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Close Branch'.tr,
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    Get.defaultDialog(
                                                        title:
                                                            "Close Branch".tr,
                                                        content: (workingOnAvailability.length > 0 ||
                                                                availabilityTaskDetails
                                                                        .length >
                                                                    0 ||
                                                                workingOnOffers
                                                                        .length >
                                                                    0 ||
                                                                offersTaskDetails
                                                                        .length >
                                                                    0 ||
                                                                workingOnShare.length >
                                                                    0 ||
                                                                shareTaskDetails
                                                                        .length >
                                                                    0 ||
                                                                workingOnRtv.length >
                                                                    0 ||
                                                                rTVTaskDetails.length >
                                                                    0 ||
                                                                workingOnInventory
                                                                        .length >
                                                                    0 ||
                                                                inventoryTaskDetails
                                                                        .length >
                                                                    0)
                                                            ? Column(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            10),
                                                                    child: Text(
                                                                        "You have uncompleted Tasks"
                                                                            .tr),
                                                                  ),
                                                                  MaterialButton(
                                                                      onPressed:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          closeBranch =
                                                                              !closeBranch;
                                                                        });
                                                                        updateDatatoFinish();
                                                                        Get.offAll(
                                                                            DailyTasks(
                                                                          nationality:
                                                                              widget.nationality,
                                                                          branch:
                                                                              widget.branch,
                                                                          market:
                                                                              widget.market,
                                                                          username:
                                                                              widget.userName,
                                                                          profileImage:
                                                                              widget.userImage,
                                                                          marketImage:
                                                                              widget.marketImage,
                                                                          id: widget
                                                                              .id,
                                                                          phone:
                                                                              widget.merchPhone,
                                                                          adminPhone:
                                                                              widget.mangerPhone,
                                                                        ));
                                                                      },
                                                                      child: DefualtButton(
                                                                          selected:
                                                                              true,
                                                                          text:
                                                                              "Confirm".tr)),
                                                                ],
                                                              )
                                                            : MaterialButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    closeBranch =
                                                                        !closeBranch;
                                                                  });
                                                                  updateDatatoFinish();
                                                                  Get.offAll(
                                                                      DailyTasks(
                                                                    nationality:
                                                                        widget
                                                                            .nationality,
                                                                    branch: widget
                                                                        .branch,
                                                                    market: widget
                                                                        .market,
                                                                    username: widget
                                                                        .userName,
                                                                    profileImage:
                                                                        widget
                                                                            .userImage,
                                                                    marketImage:
                                                                        widget
                                                                            .marketImage,
                                                                    id: widget
                                                                        .id,
                                                                    phone: widget
                                                                        .merchPhone,
                                                                    adminPhone:
                                                                        widget
                                                                            .mangerPhone,
                                                                  ));
                                                                },
                                                                child: DefualtButton(
                                                                    selected:
                                                                        true,
                                                                    text: "Confirm"
                                                                        .tr)));
                                                  },
                                                  icon: Icon(
                                                    (closeBranch != true)
                                                        ? Icons
                                                            .check_box_outline_blank
                                                        : Icons.check_box,
                                                    color: kprimaryColor,
                                                    size: 25.sp,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ])),
                            ]))),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(25),
                  ),

                  child: Card(
                    color: Color(0xf6f6f6f6),
                    child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10.h, right: 10.w, left: 10.w),
                            child: Container(
                                child: Center(
                              child: Text(
                                'Call Supervisor'.tr,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: kprimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Divider(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 7.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 25.w, right: 25.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipOval(
                                  clipBehavior: Clip.antiAlias,
                                  //  clipBehavior: Clip.hardEdge,
                                  child: Material(
                                    borderOnForeground: true,
                                    color: Colors.white,
                                    child: Ink.image(
                                      image: NetworkImage(
                                          "https://firebasestorage.googleapis.com/v0/b/arrow-9ad35.appspot.com/o/trans37.jpg?alt=media&token=a0956d6f-68d7-408b-b68e-08b4924b9243"
                                         ),
                                      fit: BoxFit.cover,
                                      height: 85.h,
                                      width: 85.w,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10.h),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            UrlLauncher.launch(
                                                'tel:0 ${widget.mangerPhone.toString()}');
                                          },
                                          icon: Icon(
                                            Icons.call,
                                            color: Colors.black,
                                            size: 15.sp,
                                          )),
                                      Text(
                                        widget.manegerName,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  updateDatatoFinish() async {
    var user = await FirebaseFirestore.instance
        .collection("Daily Branches")
        .where("CustomerName", isEqualTo: widget.market)
        .where('CustomerCode', isEqualTo: widget.branch)
        //.where('branch', isEqualTo: widget.branch)
        .where('status', isEqualTo: 'normal')
        .get();
    if (user.docs.isNotEmpty) {
      var doc_Id = user.docs.first.id;
      await FirebaseFirestore.instance
          .collection("Daily Branches")
          .doc(doc_Id)
          .update({"status": "done"});

      //  statusstr = "done";
      print(doc_Id);
    }
  }
}
