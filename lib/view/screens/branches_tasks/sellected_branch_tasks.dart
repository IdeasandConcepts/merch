



import 'package:arrow_merchandising/view/screens/reports/availability/availability_report.dart';
import 'package:arrow_merchandising/view/screens/reports/capture_photo/capture_photo_report.dart';
import 'package:arrow_merchandising/view/screens/reports/inventory/inventory_report.dart';
import 'package:arrow_merchandising/view/screens/reports/planogram/planogram_report.dart';
import 'package:arrow_merchandising/view/screens/reports/pricing/pricing_report.dart';
import 'package:arrow_merchandising/view/screens/reports/rtv/rtv_report.dart';
import 'package:arrow_merchandising/view/screens/reports/share0fshelfs/share_of_shelfs_reports.dart';
import 'package:arrow_merchandising/view/screens/super_visor/super_app_bar.dart';
import 'package:arrow_merchandising/view/widgets/custom_dropdown.dart';
import 'package:arrow_merchandising/models/ai_planogram_model.dart';
import 'package:arrow_merchandising/models/ai_share_model.dart';
import 'package:arrow_merchandising/models/availability_task.dart';
import 'package:arrow_merchandising/models/inventory_task.dart';
import 'package:arrow_merchandising/models/new_task.dart';
import 'package:arrow_merchandising/models/pricing_model.dart';
import 'package:arrow_merchandising/models/rtv_model.dart';
import 'package:arrow_merchandising/models/Visits.dart';
import 'package:arrow_merchandising/view/screens/add_task/add_task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:arrow_merchandising/const.dart';
import 'package:intl/intl.dart';




class AndroidBranchTasksScreen extends StatefulWidget {
  final int id, phone;
  final String username,
      marketImage,
      profileImage,
      branch,
      role,
      market,
      nationality;
  const AndroidBranchTasksScreen({
    Key? key,
    required this.username,
    required this.profileImage,
    required this.id,
    required this.phone,
    required this.nationality,
    required this.role,
    required this.marketImage,
    required this.branch,
    required this.market,

  }) : super(key: key);

  @override
  State<AndroidBranchTasksScreen> createState() => _AndroidBranchTasksScreenState();
}

class _AndroidBranchTasksScreenState extends State<AndroidBranchTasksScreen>
// with TickerProviderStateMixin 
    {

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
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kprimaryColor,
          title: SuperAppBar(
            comeFrom: "Branch",
            title: widget.market.toLowerCase() + "\t:\t" +
                widget.branch.toLowerCase(),
            //manegerName: widget.manegerName,
            phone: widget.phone,
            market: widget.market,
            marketImage: widget.marketImage,
            branch: widget.branch,
            username: widget.username,
            profileImage: widget.profileImage,
          )),

      floatingActionButton: IconButton(
          onPressed: () {
            Get.defaultDialog(
              title: "Select Your Task".tr,
              content: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height - 500,
                child: Wrap(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.broken_image),
                      title: Text("RTV Section".tr),
                      onTap: () {
                        Navigator.of(context).pop();
                        Get.to(() =>
                            AddTaskScreen(
                              taskTitle: "RTV Section",
                              comeFrom: widget.market,
                              selectedMarketImage: widget.marketImage,
                              id: widget.id,
                              phone: widget.phone,
                              selectedMarket: widget.market,
                              userName: widget.username,
                              profileImage: widget.profileImage,
                              selectedBranch: widget.branch,
                              selectedMerch: "",
                            ));
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.inventory),
                      title: Text("Inventory".tr),
                      onTap: () {
                        Navigator.of(context).pop();
                        Get.to(() =>
                            AddTaskScreen(
                              taskTitle: "Inventory",
                              comeFrom: widget.market,
                              selectedMarketImage: widget.marketImage,
                              id: widget.id,
                              phone: widget.phone,
                              selectedMarket: widget.market,
                              userName: widget.username,
                              profileImage: widget.profileImage,
                              selectedBranch: widget.branch,
                              selectedMerch: "",
                            ));
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.event_available),
                      title: Text("Availability".tr),
                      onTap: () {
                        Navigator.of(context).pop();
                        Get.to(() =>
                            AddTaskScreen(
                              taskTitle: "Availability",
                              comeFrom: widget.market,
                              selectedMarketImage: widget.marketImage,
                              id: widget.id,
                              phone: widget.phone,
                              selectedMarket: widget.market,
                              userName: widget.username,
                              profileImage: widget.profileImage,
                              selectedBranch: widget.branch,
                              selectedMerch: "",
                            ));
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.currency_exchange),
                      title: Text("Offers".tr),
                      onTap: () {
                        Navigator.of(context).pop();
                        Get.to(() =>
                            AddTaskScreen(
                              taskTitle: "Offers",
                              comeFrom: widget.market,
                              selectedMarketImage: widget.marketImage,
                              id: widget.id,
                              phone: widget.phone,
                              selectedMarket: widget.market,
                              userName: widget.username,
                              profileImage: widget.profileImage,
                              selectedBranch: widget.branch,
                              selectedMerch: "",
                            ));
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.dehaze),
                      title: Text("Planogram".tr),
                      onTap: () {
                        Navigator.of(context).pop();
                        Get.to(() =>
                            AddTaskScreen(
                              taskTitle: "Planogram",
                              comeFrom: "All Markets",
                              selectedMarketImage: "",
                              id: widget.id,
                              phone: widget.phone,
                              selectedMarket: widget.market,
                              userName: widget.username,
                              profileImage: widget.profileImage,
                              selectedBranch: widget.branch,
                              selectedMerch: "",
                            ));
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.shelves),
                      title: Text("Share of Shelves".tr),
                      onTap: () {
                        Navigator.of(context).pop();
                        Get.to(() =>
                            AddTaskScreen(
                              taskTitle: "Share of Shelves",
                              comeFrom: widget.market,
                              selectedMarketImage: widget.marketImage,
                              id: widget.id,
                              phone: widget.phone,
                              selectedMarket: widget.market,
                              userName: widget.username,
                              profileImage: widget.profileImage,
                              selectedBranch: widget.branch,
                              selectedMerch: "",
                            ));
                      },
                    ),
                  ],
                ),
                // ),
              ),

            );
          },

          icon: Icon(
            color: kprimaryColor, Icons.add_circle, size: 60,)),
      // appBar: CoustomAppBar(globalkey: globalkey),
      // key: globalkey,
      //drawer: const CustomDrawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 15.h),
        child: Column(children: [

          ///  Filter
          Container(

            height: (tCase == "Done") && (tName != "RTV") ? 240.h :
            (tName == "RTV") && (tCase == "Done") ?
            300.h :
            //(tName == "RTV" && tCase=="Run")?150:
            200.h,
            // height: 240.h,
            width: 378.w,
            // padding: EdgeInsets.symmetric(horizontal: 8.w),
            decoration: BoxDecoration(
                border: Border.all(width: 1.w),
                borderRadius: BorderRadius.circular(10.r)),
            child: Column(
                children: [
                  Text("Filter",
                      style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 28.sp)),

                  SizedBox(height: 12.h),
                  // category
                  /// Done Task's DropdownButton
                  CustomDropdownButton(
                      onChanged: (value) {},
                      onTap: () {},
                      hintText: tCase.tr,
                      items: List.generate(
                        taskCase.length,
                            (index) =>
                        // null)[
                        DropdownMenuItem(
                            onTap: () {
                              setState(() {
                                tCase = taskCase[index];
                              });
                            },
                            value: 1,
                            child: Text("${taskCase[index].tr}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp))),
                      )),
                  SizedBox(height: 12.h),
                  if(tCase == "Done")
                    CustomDropdownButton(
                        onChanged: (value) {},
                        onTap: () {

                        },
                        hintText: selectedPlace.tr,
                        items: List.generate(
                          places.length,
                              (index) =>
                          // null)[
                          DropdownMenuItem(
                              onTap: () {
                                setState(() {
                                  selectedPlace =
                                  places[index];
                                });
                              },
                              value: 1,
                              child: Text("${places[index].tr}",
                                  style: TextStyle(
                                      fontWeight:
                                      FontWeight.w500,
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
                  if (tName == "RTV" && tCase == "Done")
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
// Done
          (tCase == "Done") ?

          // RTV Expired
          Container(
            height: (tName == "RTV") ? MediaQuery
                .of(context)
                .size
                .height / 2.4.h
                : MediaQuery
                .of(context)
                .size
                .height / 2.1.h,
            child:
            (tName == "RTV") ?
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child:
              StreamBuilder<List<RTVTaskModel>>(
                  stream: readDoneRTVTasks(rTVCase),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(
                          ' Error ya Ahmed :: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final task = snapshot.data!;
                      return ListView(
                        shrinkWrap: true,
                        children: task
                            .map(buildDoneRTVTask)
                            .toList(),
                      );
                    } else {
                      return Center(
                        child:
                        CircularProgressIndicator(),
                      );
                    }
                  }),
              // ),
            ) :
            (tName == "Visits") ?
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                decoration: BoxDecoration(
                  // color: kprimaryColor.withOpacity(0.8),
                    borderRadius:
                    BorderRadius.circular(25)),
                child: StreamBuilder<
                    List<FullVisit>>(
                    stream:
                    readDonePhotosTask(),
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
                          children: task
                              .map(buildDonePhotosTask)
                              .toList(),
                        );
                      } else {
                        return Center(
                          child:
                          CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ) :
            (tName == "Availability") ?
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                decoration: BoxDecoration(
                  //color: kprimaryColor.withOpacity(0.1),
                    borderRadius:
                    BorderRadius.circular(25)),
                child: StreamBuilder<
                    List<AvailabilityTaskModel>>(
                    stream:
                    readDoneAvailabilityTasks(
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
                          children: task
                              .map(buildDonePieceTask)
                              .toList(),
                        );
                      } else {
                        return Center(
                          child:
                          CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ) :
            (tName == "Inventory") ?
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                decoration: BoxDecoration(
                    color: kprimaryColor
                        .withOpacity(0.1),
                    borderRadius:
                    BorderRadius.circular(25)),
                child: StreamBuilder<
                    List<InventoryTask>>(
                    stream: readDoneInventoryTasks(
                        'On Shelves'),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text(
                            ' Error ya Hantop :: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final task = snapshot.data!;
                        return ListView(
                          shrinkWrap: true,
                          controller:
                          _scrollController,
                          children: task
                              .map(buildDoneInventoryTask)
                              .toList(),
                        );
                      } else {
                        return Center(
                          child:
                          CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ) :
            (tName == "Share Of Shelves") ?
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: StreamBuilder<List<AiShareModel>>(
                  stream: readDoneShareOfShellTask(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(
                          ' Error ya Hantop :: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final task = snapshot.data!;
                      return ListView(
                        controller: _scrollController,
                        shrinkWrap: true,
                        children: task.map(buildDoneShareTask).toList(),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ) :
            (tName == "Planogram") ?
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: StreamBuilder<List<AiPlanogramModel>>(
                  stream: readDonePlanogramTasks(),
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
                        task.map(buildDonePlanogramTask).toList(),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ) :
            (tName == "Offers") ?
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: StreamBuilder<List<PricingTask>>(
                  stream: readDonePricingTask(),
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
                        //[Text("ghhg")]
                        task.map(buildDonePricingTask).toList(),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ) : Container(height: 20,),
          ) :

          //:
          (tCase == "Run") ?
// RTV Expired
          Container(
              height
              //: (tName == "RTV") ?MediaQuery.of(context).size.height /2.4.h
                  : MediaQuery
                  .of(context)
                  .size
                  .height / 2.1.h,
              child:
              (tName == "RTV") ?
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: StreamBuilder<List<NewAllTask>>(
                    stream: readAllTask("RTV", "run"),
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
                          //[Text("ghhg")]
                          task.map(buildNewTasks).toList(),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ) :
              (tName == "Availability") ?
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  decoration: BoxDecoration(
                    //color: kprimaryColor.withOpacity(0.1),
                      borderRadius:
                      BorderRadius.circular(25)),
                  child: StreamBuilder<List<NewAllTask>>(
                      stream: readAllTask("Availability", "run"),
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
                            //[Text("ghhg")]
                            task.map(buildNewTasks).toList(),
                          );
                        } else {
                          return Center(
                            child:
                            CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
              ) :
              (tName == "Inventory") ?
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  decoration: BoxDecoration(
                      color: kprimaryColor
                          .withOpacity(0.1),
                      borderRadius:
                      BorderRadius.circular(25)),
                  child: StreamBuilder<List<NewAllTask>>(
                      stream: readAllTask("Inventory", "run"),
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
                            //[Text("ghhg")]
                            task.map(buildNewTasks).toList(),
                          );
                        } else {
                          return Center(
                            child:
                            CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
              ) :
              (tName == "Share Of Shelves") ?
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: StreamBuilder<List<NewAllTask>>(
                    stream: readAllTask("Share of shelves", "run"),
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
                          //[Text("ghhg")]
                          task.map(buildNewTasks).toList(),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ) :
              (tName == "Planogram") ?
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: StreamBuilder<List<NewAllTask>>(
                    stream: readAllTask("Planogram", "run"),
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
                          //[Text("ghhg")]
                          task.map(buildNewTasks).toList(),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ) :
              (tName == "Offers") ?
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: StreamBuilder<List<NewAllTask>>(
                    stream: readAllTask("Offers", "run"),
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
                          //[Text("ghhg")]
                          task.map(buildNewTasks).toList(),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ) :
              Container(height: 20,)) :
          (tCase == "New") ?
          // RTV Expired
          Container(
              height: (tName == "RTV") ? MediaQuery
                  .of(context)
                  .size
                  .height / 2.4.h
                  : MediaQuery
                  .of(context)
                  .size
                  .height / 2.1.h,
              child:
              (tName == "RTV") ?
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: StreamBuilder<List<NewAllTask>>(
                    stream: readAllTask("RTV", "not yet"),
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
                          //[Text("ghhg")]
                          task.map(buildNewTasks).toList(),
                        );
                      } else {
                        return Center(
                          child:
                          CircularProgressIndicator(),
                        );
                      }
                    }),
                // ),
              ) :

              (tName == "Availability") ?
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  decoration: BoxDecoration(
                    //color: kprimaryColor.withOpacity(0.1),
                      borderRadius:
                      BorderRadius.circular(25)),
                  child: StreamBuilder<List<NewAllTask>>(
                      stream: readAllTask("Availability", "not yet"),
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
                            //[Text("ghhg")]
                            task.map(buildNewTasks).toList(),
                          );
                        } else {
                          return Center(
                            child:
                            CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
              ) :
              (tName == "Inventory") ?
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  decoration: BoxDecoration(
                      color: kprimaryColor
                          .withOpacity(0.1),
                      borderRadius:
                      BorderRadius.circular(25)),
                  child: StreamBuilder<List<NewAllTask>>(
                      stream: readAllTask("Inventory", "not yet"),
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
                            //[Text("ghhg")]
                            task.map(buildNewTasks).toList(),
                          );
                        } else {
                          return Center(
                            child:
                            CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
              ) :
              (tName == "Share Of Shelves") ?
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: StreamBuilder<List<NewAllTask>>(
                    stream: readAllTask("Share of shelves", "not yet"),
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
                          //[Text("ghhg")]
                          task.map(buildNewTasks).toList(),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ) :
              (tName == "Planogram") ?
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: StreamBuilder<List<NewAllTask>>(
                    stream: readAllTask("Planogram", "not yet"),
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
                          //[Text("ghhg")]
                          task.map(buildNewTasks).toList(),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              )
                  :
              //(tName=="Offers")?
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: StreamBuilder<List<NewAllTask>>(
                    stream: readAllTask("Offers", "not yet"),
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
                          //[Text("ghhg")]
                          task.map(buildNewTasks).toList(),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              )
            //:Container(height: 20,),
          )
          // :Container(height: 20,),
//)
              : Container(height: 20,),


        ]
        ),
        // ),
      ),


    );
  }

  // Widget titleAndDetails(String title, String details) {
  //   return
  //     //SizedBox(
  //     // height: 44.h,
  //     //  child:
  //     Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Container(
  //           width: (title.length <= 6) ? (MediaQuery
  //               .of(context)
  //               .size
  //               .width / 6.5).w :
  //           (MediaQuery
  //               .of(context)
  //               .size
  //               .width / 6.5).w,
  //           color: kprimaryColor,
  //           child: Text(
  //               (title.length <= 10) ? title : title.substring(0, 4) + "...",
  //               //+"..",
  //               style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp)),
  //         ),
  //         SizedBox(width: 5.w),
  //         GestureDetector(
  //           onTap: (details.length > 10) ? () {
  //             Get.defaultDialog(
  //               title: "",
  //               content: Text(details),
  //             );
  //           } : () {},
  //           // width: 200.w,
  //           child: Container(
  //             width: MediaQuery
  //                 .of(context)
  //                 .size
  //                 .width / 4.1,
  //             // color: kprimaryColor,
  //             child: Text(
  //                 (details.length <= 10) ? details : details.substring(0, 12) +
  //                     "...",
  //                 // softWrap: true,
  //                 style: TextStyle(
  //                     color: fontgrey,
  //                     fontWeight: FontWeight.w600,
  //                     fontSize: 13.sp)),
  //           ),
  //         ),
  //       ],
  //       // ),
  //     );
  // }
  Widget titleAndDetailsNew(String title, String details) {
    return
      //SizedBox(
      // height: 44.h,
      //  child:
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width:
            //(title.length<=5)?(MediaQuery.of(context).size.width /6.5).w:
            (MediaQuery
                .of(context)
                .size
                .width / 5.5).w,
            //color: kprimaryColor,
            child: Text(
                (title.length <= 10) ? title : title.substring(0, 4) + "...",
                //+"..",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp)),
          ),
          SizedBox(width: 5.w),
          GestureDetector(
            onTap: (details.length > 10) ? () {
              Get.defaultDialog(
                title: "",
                content: Text(details),
              );
            } : () {},
            // width: 200.w,
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 4.1,
              // color: kprimaryColor,
              child: Text(
                  (details.length <= 10) ? details : details.substring(0, 10) +
                      "...",
                  // softWrap: true,
                  style: TextStyle(
                      color: fontgrey,
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp)),
            ),
          ),
        ],
        // ),
      );
  }


  Widget titleAndDetailsDone(String title, String details) {
    return
      //SizedBox(
      // height: 44.h,
      //  child:
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width:
            //(title.length<=4)?(MediaQuery.of(context).size.width /6.5).w:
            (MediaQuery
                .of(context)
                .size
                .width / 6.5).w,

            // color: kprimaryColor,
            child: Text(
                (title.length <= 10) ? title : title.substring(0, 4) + "...",
                //+"..",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp)),
          ),
          SizedBox(width: 5.w),
          GestureDetector(
            onTap: (details.length > 10) ? () {
              Get.defaultDialog(
                title: "",
                content: Text(details),
              );
            } : () {},
            // width: 200.w,
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 4.1,
              // color: kprimaryColor,
              child: Text(
                  (details.length <= 10) ? details : details.substring(0, 10) +
                      "...",
                  // softWrap: true,
                  style: TextStyle(
                      color: fontgrey,
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp)),
            ),
          ),
        ],
        // ),
      );
  }

  // Widget titleAndDetails(String title, String detalis) {
  //   return SizedBox(
  //     // height: 44.h,
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(title,
  //             style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp)),
  //         SizedBox(width: 15.w),
  //         SizedBox(
  //           // width: 200.w,
  //           child: Text(detalis,
  //               softWrap: true,
  //               style: TextStyle(
  //                   color: fontgrey,
  //                   fontWeight: FontWeight.w600,
  //                   fontSize: 14.sp)),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget buildDoneRTVTask(RTVTaskModel task) =>
      Column
        (
          children: <Widget>[
            Material(
              elevation: 10,
              color: backgroundColor2,
              borderRadius: BorderRadius.circular(10.r),
              child: InkWell(
                borderRadius: BorderRadius.circular(10.r),
                onTap: () {
                  Get.to(() =>
                      AndroidRtvReport(
                        marketImage: widget.marketImage,
                        role: widget.role,
                        branch: widget.branch,
                        nationality: widget.nationality,
                        // marketDetails: widget.marketDetails,
                        id: widget.id,
                        phone: widget.phone,
                        market: widget.market,
                        username: widget.username,
                        //marketImage: widget.marketImage,
                        profileImage: widget.profileImage,
                        rtvTasks: task,
                      )
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 11.w, vertical: 15.h),
                  height: 82.h,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 20,
                  //344.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          titleAndDetailsDone("Market".tr + "\t",
                              task.market),
                          titleAndDetailsDone(
                              "Merchandiser".tr + "\t", task.madeBy),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          titleAndDetailsDone("Branch".tr + "\t", task.branch),

                          titleAndDetailsDone('Date'.tr + "\t", task.taskDate),
                        ],
                      ),

                    ],
                  ),
                ),
              ),),
            SizedBox(height: 10.h,)
          ]
      );

  Widget buildDoneInventoryTask(InventoryTask task) =>
      Column
        (
          children: <Widget>[
            Material(
              elevation: 10,
              color: backgroundColor2,
              borderRadius: BorderRadius.circular(10.r),
              child: InkWell(
                borderRadius: BorderRadius.circular(10.r),
                onTap: () {
                  Get.to(() =>
                      AndroidInventoryReport(
                        marketImage: widget.marketImage,
                        role: widget.role,
                        branch: widget.branch,
                        nationality: widget.nationality,
                        // marketDetails: widget.marketDetails,
                        id: widget.id,
                        phone: widget.phone,
                        market: widget.market,
                        username: widget.username,
                        //marketImage: widget.marketImage,
                        profileImage: widget.profileImage,
                        inventoryTask: task,
                      )
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 11.w, vertical: 15.h),
                  height: 82.h,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 20,
                  //344.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          titleAndDetailsDone("Market".tr + "\t",
                              task.market),
                          titleAndDetailsDone(
                              "Merchandiser".tr + "\t", task.madeBy),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          titleAndDetailsDone("Branch".tr + "\t", task.branch),

                          titleAndDetailsDone('Date'.tr + "\t", task.taskDate),
                        ],
                      ),

                    ],
                  ),
                ),
              ),),
            SizedBox(height: 10.h,)
          ]
      );

  Widget buildDonePieceTask(AvailabilityTaskModel task) =>
      Column
        (
          children: <Widget>[
            Material(
              elevation: 10,
              color: backgroundColor2,
              borderRadius: BorderRadius.circular(10.r),
              child: InkWell(
                borderRadius: BorderRadius.circular(10.r),
                onTap: () {
                  Get.to(() =>
                      AndroidAvailabilityReport(
                        marketImage: widget.marketImage,
                        role: widget.role,
                        branch: widget.branch,
                        nationality: widget.nationality,
                        // marketDetails: widget.marketDetails,
                        id: widget.id,
                        phone: widget.phone,
                        market: widget.market,
                        username: widget.username,
                        //marketImage: widget.marketImage,
                        profileImage: widget.profileImage,
                        availability: task,
                      )
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 11.w, vertical: 15.h),
                  height: 82.h,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 20,
                  //344.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          titleAndDetailsDone("Market".tr + "\t",
                              task.market),
                          titleAndDetailsDone(
                              "Merchandiser".tr + "\t", task.madeBy),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          titleAndDetailsDone("Branch".tr + "\t", task.branch),

                          titleAndDetailsDone('Date'.tr + "\t", task.taskDate),
                        ],
                      ),

                    ],
                  ),
                ),
              ),),
            SizedBox(height: 10.h,)
          ]
      );

  Widget buildDonePlanogramTask(AiPlanogramModel task) =>
      //  decoration: BoxDecoration(color: kprimaryColor.withOpacity(0.5)),
  Column
    (
      children: <Widget>[
        Material(
          elevation: 10,
          color: backgroundColor2,
          borderRadius: BorderRadius.circular(10.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            onTap: () {
              Get.to(() =>
                  AndroidPlanogramReport(
                    role: widget.role,
                    planogramModel: task,
                    nationality: widget.nationality,
                    phone: widget.phone,
                    marketImage: task.market,
                    profileImage: widget.profileImage,
                    market: task.market,
                    branch: task.branch,
                    username: widget.username,
                    id: widget.id,
                  )
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 15.h),
              height: 82.h,
              width: MediaQuery
                  .of(context)
                  .size
                  .width - 20,
              //344.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetailsDone("Market".tr + "\t",
                          task.market),
                      titleAndDetailsDone(
                          "Merchandiser".tr + "\t", task.madeBy),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetailsDone("Branch".tr + "\t", task.branch),

                      titleAndDetailsDone('Date'.tr + "\t", task.taskDate),
                    ],
                  ),

                ],
              ),
            ),
          ),),
        SizedBox(height: 10.h,)
      ]
  );

  Widget buildDoneShareTask(AiShareModel task) =>
      //  decoration: BoxDecoration(color: kprimaryColor.withOpacity(0.5)),
  Column
    (
      children: <Widget>[
        Material(
          elevation: 10,
          color: backgroundColor2,
          borderRadius: BorderRadius.circular(10.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            onTap: () {
              Get.to(() =>
                  AndroidShareOfShelvesReport(
                    role: widget.role,
                    shareOfShellTask: task,
                    nationality: widget.nationality,
                    phone: widget.phone,
                    marketImage: task.market,
                    profileImage: widget.profileImage,
                    market: task.market,
                    branch: task.branch,
                    username: widget.username,
                    id: widget.id,
                  )
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 15.h),
              height: 82.h,
              width: MediaQuery
                  .of(context)
                  .size
                  .width - 20,
              //344.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetailsDone("Market".tr + "\t",
                          task.market),
                      titleAndDetailsDone(
                          "Merchandiser".tr + "\t", task.madeBy),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetailsDone("Branch".tr + "\t", task.branch),

                      titleAndDetailsDone('Date'.tr + "\t", task.taskDate),
                    ],
                  ),

                ],
              ),
            ),
          ),),
        SizedBox(height: 10.h,)
      ]
  );

  Widget buildDonePricingTask(PricingTask task) =>
      Column
        (
          children: <Widget>[
            Material(
              elevation: 10,
              color: backgroundColor2,
              borderRadius: BorderRadius.circular(10.r),
              child: InkWell(
                borderRadius: BorderRadius.circular(10.r),
                onTap: () {
                  Get.to(() =>
                      AndroidPricingReport(
                        role: widget.role,
                        pricingTaskModel: task,
                        nationality: widget.nationality,
                        phone: widget.phone,
                        marketImage: task.market,
                        profileImage: widget.profileImage,
                        market: task.market,
                        branch: task.branch,
                        username: widget.username,
                        id: widget.id,
                      )
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 11.w, vertical: 15.h),
                  height: 82.h,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 20,
                  //344.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          titleAndDetailsDone("Market".tr + "\t",
                              task.market),
                          titleAndDetailsDone(
                              "Merchandiser".tr + "\t", task.madeBy),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          titleAndDetailsDone("Branch".tr + "\t", task.branch),

                          titleAndDetailsDone('Date'.tr + "\t", task.taskDate),
                        ],
                      ),

                    ],
                  ),
                ),
              ),),
            SizedBox(height: 10.h,)
          ]
      );

  Widget buildDonePhotosTask(FullVisit task) =>
      Column
        (
          children: <Widget>[
            Material(
              elevation: 10,
              color: backgroundColor2,
              borderRadius: BorderRadius.circular(10.r),
              child: InkWell(
                borderRadius: BorderRadius.circular(10.r),
                onTap: () {
                  Get.to(() =>
                      AndroidCapturePhotoReport(
                        role: widget.role,
                        capturePhotos: task,
                        nationality: widget.nationality,
                        phone: widget.phone,
                        marketImage: task.market,
                        profileImage: widget.profileImage,
                        market: task.market,
                        branch: task.branch,
                        username: widget.username,
                        id: widget.id,
                      )
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 11.w, vertical: 15.h),
                  height: 82.h,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 20,
                  //344.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          titleAndDetailsDone("Market".tr + "\t",
                              task.market),
                          titleAndDetailsDone(
                              "Merchandiser".tr + "\t", task.madeBy),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          titleAndDetailsDone("Branch".tr + "\t", task.branch),

                          titleAndDetailsDone('Date'.tr + "\t", task.date),
                        ],
                      ),

                    ],
                  ),
                ),
              ),),
            SizedBox(height: 10.h,)
          ]
      );

  Stream<List<RTVTaskModel>> readDoneRTVTasks(String tittle) =>
      FirebaseFirestore.instance
          .collection("RTV Products")
          .where("market", isEqualTo: widget.market)
          .where("branch", isEqualTo: widget.branch)
          .where("type", isEqualTo: tittle)
      //.where("made_by", isEqualTo: widget.username)
          .where("status", isEqualTo: "done")
          .snapshots()
          .map((snapshot) =>
          snapshot.docs
              .map((doc) => RTVTaskModel.fromMap(doc.data()))
              .toList());

  Stream<List<InventoryTask>> readDoneInventoryTasks(String title) =>
      FirebaseFirestore.instance
          .collection('Inventory Tasks')
          .where("market", isEqualTo: widget.market)
          .where("branch", isEqualTo: widget.branch)
      //.where("made_by", isEqualTo: widget.username)
          .where("status", isEqualTo: "Done")
      // .where("type", isEqualTo: title)

      //  .orderBy('taskDate', descending: true)
          .snapshots()
          .map((snapshot) =>
          snapshot.docs
              .map((doc) => InventoryTask.fromMap(doc.data()))
              .toList());

  Stream<List<AvailabilityTaskModel>> readDoneAvailabilityTasks(String place) =>
      FirebaseFirestore.instance
          .collection("Availability")
          .where("market", isEqualTo: widget.market)
          .where("branch", isEqualTo: widget.branch)
      // .where("madeBy", isEqualTo: widget.username)
          .where("status", isEqualTo: "Done")
      //.where("type", isEqualTo: place)
          .snapshots()
          .map((snapshot) =>
          snapshot.docs
              .map((doc) => AvailabilityTaskModel.fromMap(doc.data()))
              .toList());

  Stream<List<FullVisit>> readDonePhotosTask() =>
      FirebaseFirestore.instance
          .collection("Visits")
          .where("market", isEqualTo: widget.market)
          .where("branch", isEqualTo: widget.branch)
      // .where("made_by", isEqualTo: widget.username)
          .where("status", isEqualTo: "done")
      // .where(taskTitle)
          .snapshots()
          .map((snapshot) =>
          snapshot.docs
              .map((doc) => FullVisit.fromMap(doc.data()))
              .toList());

  Stream<List<PricingTask>> readDonePricingTask() =>
      FirebaseFirestore.instance
          .collection("Offers")
          .where("market", isEqualTo: widget.market)
          .where("branch", isEqualTo: widget.branch)
      // .where("made_by", isEqualTo: widget.username)
          .where("status", isEqualTo: "done")
          .snapshots()
          .map((snapshot) =>
          snapshot.docs
              .map((doc) => PricingTask.fromMap(doc.data()))
              .toList());

  Stream<List<AiPlanogramModel>> readDonePlanogramTasks() =>
      FirebaseFirestore.instance
          .collection("Planogram")
          .where("market", isEqualTo: widget.market)
          .where("branch", isEqualTo: widget.branch)
      //.where("made_by", isEqualTo: widget.username)
          .where("status", isEqualTo: "done")
          .snapshots()
          .map((snapshot) =>
          snapshot.docs
              .map((doc) => AiPlanogramModel.fromJson(doc.data()))
              .toList());

  Stream<List<AiShareModel>> readDoneShareOfShellTask() =>
      FirebaseFirestore.instance
          .collection('Share Of Shelves')
          .where("market", isEqualTo: widget.market)
          .where("branch", isEqualTo: widget.branch)
      // .where("made_by", isEqualTo: widget.username)
          .where("status", isEqualTo: "Done")
          .snapshots()
          .map((snapshot) =>
          snapshot.docs
              .map((doc) => AiShareModel.fromJson(doc.data()))
              .toList());

  //


  Widget buildNewTasks(NewAllTask task) =>
      Column
        (
          children: <Widget>[
            Material(
              elevation: 10,
              color: backgroundColor2,
              borderRadius: BorderRadius.circular(10.r),
              child: InkWell(
                borderRadius: BorderRadius.circular(10.r),
                // onTap: onTap,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 11.w, vertical: 15.h),
                  height: 82.h,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 20,
                  //344.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          titleAndDetailsNew("Market".tr + "\t",
                              task.market),
                          titleAndDetailsNew(
                              "Merchandiser".tr + "\t", task.madeBy),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          titleAndDetailsNew("Branch".tr + "\t", task.branch),

                          titleAndDetailsNew(
                            'Date'.tr + "\t", DateFormat('yyyy-MM-dd')
                              .format(
                              task.date),),
                        ],
                      ),

                    ],
                  ),
                ),
              ),),
            SizedBox(height: 10.h,)
          ]
      );

  Stream<List<NewAllTask>> readAllTask(String title, String tStatus) =>
      FirebaseFirestore.instance
          .collection('New Tasks')
          .where("market", isEqualTo: widget.market)
          .where("branch", isEqualTo: widget.branch)
      // .where("made_by", isEqualTo: widget.username)
          .where("status", isEqualTo: tStatus)
          .snapshots()
          .map((snapshot) =>
          snapshot.docs
              .map((doc) => NewAllTask.fromJson(doc.data()))
              .toList());
  }