import 'package:arrow_merchandising/view/widgets/custom_dropdown.dart';
import 'package:arrow_merchandising/models/ai_planogram_model.dart';
import 'package:arrow_merchandising/models/ai_share_model.dart';
import 'package:arrow_merchandising/models/availability_task.dart';
import 'package:arrow_merchandising/models/inventory_task.dart';
import 'package:arrow_merchandising/models/pricing_model.dart';
import 'package:arrow_merchandising/models/rtv_model.dart';
import 'package:arrow_merchandising/models/Visits.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:arrow_merchandising/const.dart';

class MyTasksHistory extends StatefulWidget {
  final String nationality;
  final String username, manegerName, marketImage, profileImage, branch, market;
  final int id, phone, managerPhone;
  const MyTasksHistory({
    Key? key,
    required this.username,
    required this.marketImage,
    required this.profileImage,
    required this.branch,
    required this.market,
    required this.id,
    required this.phone,
    required this.nationality,
    required this.managerPhone,
    required this.manegerName,
  }) : super(key: key);

  @override
  State<MyTasksHistory> createState() => _MyTasksHistoryState();
}

class _MyTasksHistoryState extends State<MyTasksHistory> {
  ScrollController _scrollController = ScrollController();
  List<String> places = [
    "On Shelves",
    "On Display",
    "On Gandola",
    "On Back Door"
  ];
  String selectedPlace = "On Shelves";
  List<String> taskCase = ["Done", "Run", "New", "Expired"];
  List<String> taskName = [
    "RTV",
    "Inventory",
    "Availability",
    "Share Of Shelves",
    "Visits",
    "Offers",
    "Planogram",
  ];
  List<String> rtvCase = ["Expired", "Near Expired", "Damaged"];

  String tCase = "Done";
  String tName = "All Tasks";
  String rTVCase = "Expired";
  @override
  Widget build(BuildContext context) {
    // final GlobalKey<ScaffoldState> globalkey = GlobalKey();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 15.h),
        child: Column(children: [
          ///  Filter
          Container(
            height: (tName != "RTV") ? 180.h : 240.h,
            width: 378.w,
            decoration: BoxDecoration(
                border: Border.all(width: 1.w),
                borderRadius: BorderRadius.circular(10.r)),
            child: Column(children: [
              Text("Filter",
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 28.sp)),

              SizedBox(height: 12.h),
              if (tCase == "Done")
                CustomDropdownButton(
                    onChanged: (value) {},
                    onTap: () {},
                    hintText: selectedPlace.tr,
                    items: List.generate(
                      places.length,
                      (index) =>
                          // null)[
                          DropdownMenuItem(
                              onTap: () {
                                setState(() {
                                  selectedPlace = places[index];
                                });
                              },
                              value: 1,
                              child: Text("${places[index].tr}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp))),
                    )),
              SizedBox(height: 12.h),

              /// RTV Section DropdownButton
              CustomDropdownButton(
                  onChanged: (value) {},
                  onTap: () {},
                  hintText: tName.tr,
                  items: List.generate(
                    taskName.length,
                    (index) =>
                        // null)[
                        DropdownMenuItem(
                            onTap: () {
                              setState(() {
                                tName = taskName[index];
                              });
                            },
                            value: 1,
                            child: Text("${taskName[index].tr}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp))),
                  )),

              /// Expired DropdownButton
              if (tName == "RTV")
                Column(
                  children: [
                    SizedBox(height: 12.h),
                    CustomDropdownButton(
                        onChanged: (value) {},
                        onTap: () {},
                        hintText: rTVCase.tr,
                        items: List.generate(
                          rtvCase.length,
                          (index) =>
                              // null)[
                              DropdownMenuItem(
                                  onTap: () {
                                    setState(() {
                                      rTVCase = rtvCase[index];
                                    });
                                  },
                                  value: 1,
                                  child: Text("${rtvCase[index].tr}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.sp))),
                        )),
                  ],
                ),
            ]),
          ),
          SizedBox(height: 15.h),

          // RTV Expired
          Container(
            height: (tName == "RTV")
                ? MediaQuery.of(context).size.height / 2.4.h
                : MediaQuery.of(context).size.height / 1.78.h,
            child: (tName == "RTV")
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: StreamBuilder<List<RTVTaskModel>>(
                        stream: readRTVTasks(rTVCase, selectedPlace),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text(' Error ya Ahmed :: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            final task = snapshot.data!;
                            return ListView(
                              shrinkWrap: true,
                              children: task.map(buildRTVTask).toList(),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                    // ),
                  )
                : (tName == "Visits")
                    ? SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Container(
                          decoration: BoxDecoration(
                              // color: kprimaryColor.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(25)),
                          child: StreamBuilder<List<FullVisit>>(
                              stream: createPhotosTask(selectedPlace),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text(
                                      ' Error ya Hantop :: ${snapshot.error}');
                                } else if (snapshot.hasData) {
                                  final task = snapshot.data!;
                                  return ListView(
                                    controller: _scrollController,
                                    shrinkWrap: true,
                                    children:
                                        task.map(buildPhotosTask).toList(),
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              }),
                        ),
                      )
                    : (tName == "Availability")
                        ? SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25)),
                              child: StreamBuilder<List<AvailabilityTaskModel>>(
                                  stream:
                                      readPieceAvailabilityTasks(selectedPlace),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Text(
                                          ' Error ya Hantop :: ${snapshot.error}');
                                    } else if (snapshot.hasData) {
                                      final task = snapshot.data!;
                                      return ListView(
                                        controller: _scrollController,
                                        shrinkWrap: true,
                                        children:
                                            task.map(buildPieceTask).toList(),
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  }),
                            ),
                          )
                        : (tName == "Inventory")
                            ? SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: kprimaryColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(25)),
                                  child: StreamBuilder<List<InventoryTask>>(
                                      stream: readInventoryTasks(selectedPlace),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasError) {
                                          return Text(
                                              ' Error ya Hantop :: ${snapshot.error}');
                                        } else if (snapshot.hasData) {
                                          final task = snapshot.data!;
                                          return ListView(
                                            shrinkWrap: true,
                                            controller: _scrollController,
                                            children: task
                                                .map(buildInventoryTask)
                                                .toList(),
                                          );
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      }),
                                ),
                              )
                            : (tName == "Share Of Shelves")
                                ? SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    child: StreamBuilder<List<AiShareModel>>(
                                        stream:
                                            readShareofShellTask(selectedPlace),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError) {
                                            return Text(
                                                ' Error ya Hantop :: ${snapshot.error}');
                                          } else if (snapshot.hasData) {
                                            final task = snapshot.data!;
                                            return ListView(
                                              controller: _scrollController,
                                              shrinkWrap: true,
                                              children: task
                                                  .map(buildShareTask)
                                                  .toList(),
                                            );
                                          } else {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                        }),
                                  )
                                : (tName == "Planogram")
                                    ? SingleChildScrollView(
                                        physics: BouncingScrollPhysics(),
                                        child: StreamBuilder<
                                                List<AiPlanogramModel>>(
                                            stream: readPlanogramTasks(
                                                selectedPlace),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasError) {
                                                return Text(
                                                    ' Error ya Hantop :: ${snapshot.error}');
                                              } else if (snapshot.hasData) {
                                                final task = snapshot.data!;
                                                return ListView(
                                                  controller: _scrollController,
                                                  shrinkWrap: true,
                                                  children: task
                                                      .map(buildPlanogramTask)
                                                      .toList(),
                                                );
                                              } else {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                            }),
                                      )
                                    : (tName == "Offers")
                                        ? SingleChildScrollView(
                                            physics: BouncingScrollPhysics(),
                                            child: StreamBuilder<
                                                    List<PricingTask>>(
                                                stream: createPricingTask(
                                                    selectedPlace),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasError) {
                                                    return Text(
                                                        ' Error ya Hantop :: ${snapshot.error}');
                                                  } else if (snapshot.hasData) {
                                                    final task = snapshot.data!;
                                                    return ListView(
                                                      controller:
                                                          _scrollController,
                                                      shrinkWrap: true,
                                                      children:
                                                          //[Text("ghhg")]
                                                          task
                                                              .map(
                                                                  buildPricingTask)
                                                              .toList(),
                                                    );
                                                  } else {
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  }
                                                }),
                                          )
                                        : Container(
                                            height: 20,
                                          ),
          )
        ]),
        // ),
      ),
    );
  }

  Widget titleAndDetalis(String title, String detalis) {
    return SizedBox(
      // height: 44.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 4.6,
            color: kprimaryColor,
            child: Text(title,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp)),
          ),
          SizedBox(width: 5.w),
          GestureDetector(
            onTap: (detalis.length > 10)
                ? () {
                    Get.defaultDialog(
                      title: "",
                      content: Text(detalis),
                    );
                  }
                : () {},
            // width: 200.w,
            child: Container(
              child: Text(
                  (detalis.length <= 10)
                      ? detalis
                      : detalis.substring(0, 7) + "...",
                  style: TextStyle(
                      color: fontgrey,
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp)),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRTVTask(RTVTaskModel task) => Column(children: <Widget>[
        Material(
          elevation: 10,
          color: backgroundColor2,
          borderRadius: BorderRadius.circular(10.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 15.h),
              height: 82.h,
              width: MediaQuery.of(context).size.width - 20,
              //344.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetalis("Market".tr + "\t", task.market),
                      (task.taskType != "New Task")
                          ? titleAndDetalis(
                              "Task Type".tr + "\t", "Dail Task".tr)
                          : titleAndDetalis(
                              "Order By".tr + "\t", task.orderBy.tr),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetalis("Branch".tr + "\t", task.branch),
                      titleAndDetalis('Date'.tr + "\t", task.taskDate),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        )
      ]);

  Widget buildInventoryTask(InventoryTask task) => Column(children: <Widget>[
        Material(
          elevation: 10,
          color: backgroundColor2,
          borderRadius: BorderRadius.circular(10.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 15.h),
              height: 82.h,
              width: MediaQuery.of(context).size.width - 20,
              //344.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetalis("Market".tr + "\t", task.market),
                      (task.taskType != "New Task")
                          ? titleAndDetalis(
                              "Task Type".tr + "\t", "Dail Task".tr)
                          : titleAndDetalis(
                              "Order By".tr + "\t", task.orderBy.tr),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetalis("Branch".tr + "\t", task.branch),
                      titleAndDetalis('Date'.tr + "\t", task.taskDate),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        )
      ]);

  Widget buildPieceTask(AvailabilityTaskModel task) =>
      Column(children: <Widget>[
        Material(
          elevation: 10,
          color: backgroundColor2,
          borderRadius: BorderRadius.circular(10.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 15.h),
              height: 82.h,
              width: MediaQuery.of(context).size.width - 20,
              //344.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetalis("Market".tr + "\t", task.market),
                      (task.taskType != "New Task")
                          ? titleAndDetalis(
                              "Task Type".tr + "\t", "Dail Task".tr)
                          : titleAndDetalis(
                              "Order By".tr + "\t", task.orderBy.tr),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetalis("Branch".tr + "\t", task.branch),
                      titleAndDetalis('Date'.tr + "\t", task.taskDate),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        )
      ]);

  Widget buildPlanogramTask(AiPlanogramModel task) =>
      //  decoration: BoxDecoration(color: kprimaryColor.withOpacity(0.5)),
      Column(children: <Widget>[
        Material(
          elevation: 10,
          color: backgroundColor2,
          borderRadius: BorderRadius.circular(10.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 15.h),
              height: 82.h,
              width: MediaQuery.of(context).size.width - 20,
              //344.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetalis("Market".tr + "\t", task.market),
                      (task.taskType != "New Task")
                          ? titleAndDetalis(
                              "Task Type".tr + "\t", "Dail Task".tr)
                          : titleAndDetalis(
                              "Order By".tr + "\t", task.orderBy.tr),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetalis("Branch".tr + "\t", task.branch),
                      titleAndDetalis('Date'.tr + "\t", task.taskDate),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        )
      ]);

  Widget buildShareTask(AiShareModel task) => Column(children: <Widget>[
        Material(
          elevation: 10,
          color: backgroundColor2,
          borderRadius: BorderRadius.circular(10.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            // onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 15.h),
              height: 82.h,
              width: MediaQuery.of(context).size.width - 20,
              //344.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetalis("Market".tr + "\t", task.market),
                      (task.taskType != "New Task")
                          ? titleAndDetalis(
                              "Task Type".tr + "\t", "Dail Task".tr)
                          : titleAndDetalis(
                              "Order By".tr + "\t", task.orderBy.tr),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetalis("Branch".tr + "\t", task.branch),
                      titleAndDetalis('Date'.tr + "\t", task.taskDate),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        )
      ]);

  Widget buildPricingTask(PricingTask task) => Column(children: <Widget>[
        Material(
          elevation: 10,
          color: backgroundColor2,
          borderRadius: BorderRadius.circular(10.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            // onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 15.h),
              height: 82.h,
              width: MediaQuery.of(context).size.width - 20,
              //344.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetalis("Market".tr + "\t", task.market),
                      (task.taskType != "New Task")
                          ? titleAndDetalis(
                              "Task Type".tr + "\t", "Dail Task".tr)
                          : titleAndDetalis(
                              "Order By".tr + "\t", task.orderBy.tr),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetalis("Branch".tr + "\t", task.branch),
                      titleAndDetalis('Date'.tr + "\t", task.taskDate),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        )
      ]);

  Widget buildPhotosTask(FullVisit task) => Column(children: <Widget>[
        Material(
          elevation: 10,
          color: backgroundColor2,
          borderRadius: BorderRadius.circular(10.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            // onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 15.h),
              height: 82.h,
              width: MediaQuery.of(context).size.width - 20,
              //344.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetalis("Market".tr + "\t", task.market),
                      // (task.)?
                      titleAndDetalis("Task Type".tr + "\t", "Dail Task".tr),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetalis("Branch".tr + "\t", task.branch),
                      titleAndDetalis('Date'.tr + "\t", task.date),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        )
      ]);

  Stream<List<RTVTaskModel>> readRTVTasks(String tittle, String tPlace) =>
      FirebaseFirestore.instance
          .collection("RTV Products")
          .where("type", isEqualTo: tittle)
          .where("made_by", isEqualTo: widget.username)
          .where("status", isEqualTo: "done")
          .where("place", isEqualTo: tPlace)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => RTVTaskModel.fromMap(doc.data()))
              .toList());

  Stream<List<InventoryTask>> readInventoryTasks(String tPlace) =>
      FirebaseFirestore.instance
          .collection('Inventory Tasks')
          .where("made_by", isEqualTo: widget.username)
          .where("status", isEqualTo: "Done")
          .where("place", isEqualTo: tPlace)

          //  .orderBy('taskDate', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => InventoryTask.fromMap(doc.data()))
              .toList());

  Stream<List<AvailabilityTaskModel>> readPieceAvailabilityTasks(
          String tPlace) =>
      FirebaseFirestore.instance
          .collection("Availability")
          .where("made_by", isEqualTo: widget.username)
          .where("status", isEqualTo: "Done")
          .where("place", isEqualTo: tPlace)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => AvailabilityTaskModel.fromMap(doc.data()))
              .toList());

  Stream<List<FullVisit>> createPhotosTask(String tPlace) => FirebaseFirestore
      .instance
      .collection("Visits")
      .where("place", isEqualTo: tPlace)
      .where("status", isEqualTo: "done")
      // .where(taskTitle)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => FullVisit.fromMap(doc.data())).toList());

  Stream<List<PricingTask>> createPricingTask(String tPlace) =>
      FirebaseFirestore.instance
          .collection("Offers")
          .where("made_by", isEqualTo: widget.username)
          //.where("field")
          .where("status", isEqualTo: "done")
          .where("place", isEqualTo: tPlace)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => PricingTask.fromMap(doc.data()))
              .toList());

  Stream<List<AiPlanogramModel>> readPlanogramTasks(String tPlace) =>
      FirebaseFirestore.instance
          .collection("Planogram")
          .where("made_by", isEqualTo: widget.username)
          .where("status", isEqualTo: "done")
          .where("place", isEqualTo: tPlace)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => AiPlanogramModel.fromJson(doc.data()))
              .toList());

  Stream<List<AiShareModel>> readShareofShellTask(String tPlace) =>
      FirebaseFirestore.instance
          .collection('Share Of Shelves')
          .where("made_by", isEqualTo: widget.username)
          .where("status", isEqualTo: "Done")
          .where("place", isEqualTo: tPlace)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => AiShareModel.fromJson(doc.data()))
              .toList());
}
