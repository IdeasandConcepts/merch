



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


class AndroidMarketTasksScreen extends StatefulWidget {
  final int id, phone;
  final String username,nationality, profileImage;
  final String marketImage, branch, role, market;
  const AndroidMarketTasksScreen({
    Key? key,
    required this.username,
    required this.profileImage,
    required this.id,
    required this.phone,
    required this.nationality,
    required this.role,
    required this.marketImage,
    required this.market,
    required this.branch,

  }) : super(key: key);

  @override
  State<AndroidMarketTasksScreen> createState() => _AndroidMarketTasksScreenState();
}

class _AndroidMarketTasksScreenState extends State<AndroidMarketTasksScreen>
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
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kprimaryColor,
          title: SuperAppBar(
            comeFrom: widget.market,
            title: widget.market.toUpperCase(),
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
                height: MediaQuery.of(context).size.height-500,
                child: Wrap(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.broken_image),
                      title: Text("RTV Section".tr),
                      onTap: () {
                        Navigator.of(context).pop();
                        Get.to(() => AddTaskScreen(
                          taskTitle: "RTV",
                          comeFrom: "Market",
                          selectedMarketImage:widget.marketImage,
                          id:widget. id,
                          phone:widget. phone,
                          selectedMarket:"All Markets",
                          userName:widget. username,
                          profileImage:widget. profileImage,
                          selectedBranch:"All Branches",
                          selectedMerch: "",
                        ));
                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.inventory),
                      title: Text("Inventory".tr),
                      onTap: () {
                        Navigator.of(context).pop();
                        Get.to(() => AddTaskScreen(
                          taskTitle: "Inventory",
                          comeFrom: "Full Tasks",
                          selectedMarketImage:"",
                          id:widget. id,
                          phone:widget. phone,
                          selectedMarket:"All Markets",
                          userName:widget. username,
                          profileImage:widget. profileImage,
                          selectedBranch:"All Branches",
                          selectedMerch: "",
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
                          comeFrom: "Full Tasks",
                          selectedMarketImage:"",
                          id:widget. id,
                          phone:widget. phone,
                          selectedMarket:"All Markets",
                          userName:widget. username,
                          profileImage:widget. profileImage,
                          selectedBranch:"All Branches",
                          selectedMerch: "",
                        ));

                      },
                    ),

                    ListTile(
                      leading: const Icon(Icons.currency_exchange),
                      title: Text("Pricing".tr),
                      onTap: () {
                        Navigator.of(context).pop();
                        Get.to(() => AddTaskScreen(
                          taskTitle: "Pricing",
                          comeFrom: "Full Tasks",
                          selectedMarketImage:"",
                          id:widget. id,
                          phone:widget. phone,
                          selectedMarket:"All Markets",
                          userName:widget. username,
                          profileImage:widget. profileImage,
                          selectedBranch:"All Branches",
                          selectedMerch: "",
                        ));
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.shelves),
                      title: Text("Share of Shelves".tr),
                      onTap: () {
                        Navigator.of(context).pop();
                        Get.to(() => AddTaskScreen(
                          taskTitle: "Share",
                          comeFrom: "Full Tasks",
                          selectedMarketImage:"",
                          id:widget. id,
                          phone:widget. phone,
                          selectedMarket:"All Markets",
                          userName:widget. username,
                          profileImage:widget. profileImage,
                          selectedBranch:"All Branches",
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

          icon: Icon(color: kprimaryColor,Icons.add_circle,size: 40,)),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 15.h),
        child: Column(children: [
          ///  Filter
          Container(
            height:(tCase=="Done")&&(tName != "RTV") ? 240.h:
            (tName == "RTV") &&(tCase=="Done")? 300.h : 200.h,
            width: 378.w,
            decoration: BoxDecoration(
                border: Border.all(width: 1.w),
                borderRadius: BorderRadius.circular(10.r)),
            child: Column(
                children: [
                  Text("Filter",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28.sp)),
                  SizedBox(height: 12.h),
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
                  if(tCase=="Done")
                    CustomDropdownButton(
                        onChanged: (value) {},
                        onTap: () {

                        },
                        hintText: selectedPlace.tr,
                        items: List.generate(
                          places.length,
                              (index) =>
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
                  if (tName == "RTV" && tCase=="Done")
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
          /// Done
          (tCase=="Done")?
          /// RTV Expired
          Container(
            height: (tName == "RTV") ?MediaQuery.of(context).size.height /2.4.h
                :MediaQuery.of(context).size.height / 2.1.h,
            child: (tName=="RTV")?
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child:
              StreamBuilder<List<RTVTaskModel>>(
                  stream: readDoneRTVTasks(rTVCase),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error ya Ahmed :: ${snapshot.error}');
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
              /// Visits
            ):
            (tName=="Visits")?
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25)),
                child: StreamBuilder<
                    List<FullVisit>>(
                    stream: readDonePhotosTask(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error ya Hantop :: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final task = snapshot.data!;
                        return ListView(
                          controller: _scrollController,
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
            ):
                /// Availability
            (tName=="Availability")?
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(25)),
                child: StreamBuilder<
                    List<AvailabilityTaskModel>>(
                    stream: readDoneAvailabilityTasks(selectedPlace),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error ya Hantop :: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final task = snapshot.data!;
                        return ListView(
                          controller: _scrollController,
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
            ):
            (tName=="Inventory")?
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
                    stream: readDoneInventoryTasks('On Shelves'),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error ya Hantop :: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final task = snapshot.data!;
                        return ListView(
                          shrinkWrap: true,
                          controller: _scrollController,
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
            ):
                /// Share Of Shelves
            (tName=="Share Of Shelves")?
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: StreamBuilder<List<AiShareModel>>(
                  stream: readDoneShareOfShellTask(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error ya Hantop :: ${snapshot.error}');
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
            ):
                /// Planogram
            (tName=="Planogram")?
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: StreamBuilder<List<AiPlanogramModel>>(
                  stream: readDonePlanogramTasks(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error ya Hantop :: ${snapshot.error}');
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
            ):
                /// Offers
            (tName=="Offers")?
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: StreamBuilder<List<PricingTask>>(
                  stream: readDonePricingTask("Offers"),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(
                          ' Error ya Hantop :: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final task = snapshot.data!;
                      return ListView(
                        controller: _scrollController,
                        shrinkWrap: true,
                        children: task.map(buildDonePricingTask).toList(),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ) :Container(height: 20,),
          ):
/// Run Tasks
          (tCase=="Run")?
          Container(
              height:MediaQuery.of(context).size.height / 2.1.h,
              child:
                  /// RTV
              (tName=="RTV")?
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: StreamBuilder<List<NewAllTask>>(
                    stream: readAllTask("RTV", "run"),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error ya Hantop :: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final task = snapshot.data!;
                        return ListView(
                          controller: _scrollController,
                          shrinkWrap: true,
                          children: task.map(buildNewTasks).toList(),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ):
                  /// Availability
              (tName=="Availability")?
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25)),
                  child: StreamBuilder<List<NewAllTask>>(
                      stream: readAllTask("Availability", "run"),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error ya Hantop :: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final task = snapshot.data!;
                          return ListView(
                            controller: _scrollController,
                            shrinkWrap: true,
                            children: task.map(buildNewTasks).toList(),
                          );
                        } else {
                          return Center(
                            child:
                            CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
              ):
                  /// Inventory
              (tName=="Inventory")?
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
                          return Text('Error ya Hantop :: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final task = snapshot.data!;
                          return ListView(
                            controller: _scrollController,
                            shrinkWrap: true,
                            children:task.map(buildNewTasks).toList(),
                          );
                        } else {
                          return Center(
                            child:
                            CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
              ):
                  /// Share Of Shelves
              (tName=="Share Of Shelves")?
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: StreamBuilder<List<NewAllTask>>(
                    stream: readAllTask("Share of shelves", "run"),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error ya Hantop :: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final task = snapshot.data!;
                        return ListView(
                          controller: _scrollController,
                          shrinkWrap: true,
                          children: task.map(buildNewTasks).toList(),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ):
                  /// Planogram
              (tName=="Planogram")?
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: StreamBuilder<List<NewAllTask>>(
                    stream: readAllTask("Planogram", "run"),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error ya Hantop :: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final task = snapshot.data!;
                        return ListView(
                          controller: _scrollController,
                          shrinkWrap: true,
                          children: task.map(buildNewTasks).toList(),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ):
                  /// Offers
              (tName=="Offers")?
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: StreamBuilder<List<NewAllTask>>(
                    stream: readAllTask("Offers", "run"),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error ya Hantop :: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final task = snapshot.data!;
                        return ListView(
                          controller: _scrollController,
                          shrinkWrap: true,
                          children: task.map(buildNewTasks).toList(),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ) :
              Container(height: 20,)):
              /// New Tasks
          (tCase=="New")?
          Container(
              height: (tName == "RTV") ?MediaQuery.of(context).size.height /2.4.h
                  :MediaQuery.of(context).size.height / 2.1.h,
              child:
                  /// RTV
              (tName=="RTV")?
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: StreamBuilder<List<NewAllTask>>(
                    stream: readAllTask("RTV", "not yet"),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error ya Hantop :: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final task = snapshot.data!;
                        return ListView(
                          controller: _scrollController,
                          shrinkWrap: true,
                          children:task.map(buildNewTasks).toList(),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
                // ),
              ):
            /// Availability
              (tName=="Availability")?
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25)),
                  child: StreamBuilder<List<NewAllTask>>(
                      stream: readAllTask("Availability", "not yet"),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error ya Hantop :: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final task = snapshot.data!;
                          return ListView(
                            controller: _scrollController,
                            shrinkWrap: true,
                            children: task.map(buildNewTasks).toList(),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
              ):
                  /// Inventory
              (tName=="Inventory")?
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  decoration: BoxDecoration(
                      color: kprimaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(25)),
                  child: StreamBuilder<List<NewAllTask>>(
                      stream: readAllTask("Inventory", "not yet"),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error ya Hantop :: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final task = snapshot.data!;
                          return ListView(
                            controller: _scrollController,
                            shrinkWrap: true,
                            children: task.map(buildNewTasks).toList(),
                          ); } else {
                          return Center(
                            child:
                            CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
              ):
                  /// Share of shelves
              (tName=="Share Of Shelves")?
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: StreamBuilder<List<NewAllTask>>(
                    stream: readAllTask("Share of shelves", "not yet"),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error ya Hantop :: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final task = snapshot.data!;
                        return ListView(
                          controller: _scrollController,
                          shrinkWrap: true,
                          children: task.map(buildNewTasks).toList(),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ):
                  /// Planogram
              (tName=="Planogram")?
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: StreamBuilder<List<NewAllTask>>(
                    stream: readAllTask("Planogram", "not yet"),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error ya Hantop :: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final task = snapshot.data!;
                        return ListView(
                          controller: _scrollController,
                          shrinkWrap: true,
                          children: task.map(buildNewTasks).toList(),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              )
                  :
              /// Offers
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: StreamBuilder<List<NewAllTask>>(
                    stream: readAllTask("Offers", "not yet"),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error ya Hantop :: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final task = snapshot.data!;
                        return ListView(
                          controller: _scrollController,
                          shrinkWrap: true,
                          children: task.map(buildNewTasks).toList(),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              )
          )
          :Container(height: 20,),
        ]
        ),
      ),
    );
  }

  Widget titleAndDetailsNew(String title, String details) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: (MediaQuery.of(context).size.width /5.5).w,
             child: Text(
                (title.length<=10)?title:title.substring(0,4)+"...",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp)),
          ),
          SizedBox(width: 5.w),
          GestureDetector(
            onTap: (details.length>10)?(){
              Get.defaultDialog(
                title: "",
                content: Text(details),
              );
            }:(){ },
            child: Container(
              width: MediaQuery.of(context).size.width / 4.1,
              child: Text((details.length<=10)?details:details.substring(0,10)+"...",
                  style: TextStyle(
                      color: fontgrey,
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp)),
            ),
          ),
        ],

      );
  }


  Widget titleAndDetailsDone(String title, String details) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: (MediaQuery.of(context).size.width /6.5).w,
            child: Text((title.length<=10)?title:title.substring(0,4)+"...",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp)),
          ),
          SizedBox(width: 5.w),
          GestureDetector(
            onTap: (details.length>10)?(){
              Get.defaultDialog(
                title: "",
                content: Text(details),
              );
            }:(){ },
            child: Container(
              width: MediaQuery.of(context).size.width / 4.1,
              child: Text((details.length<=10)?details:details.substring(0,10)+"...",
                  style: TextStyle(
                      color: fontgrey,
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp)),
            ),
          ),
        ],
      );
  }

  Widget buildDoneRTVTask(RTVTaskModel task) =>  Column
    (
      children:<Widget> [
        Material(
          elevation: 10,
          color: backgroundColor2,
          borderRadius: BorderRadius.circular(10.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            onTap: (){
              Get.to(()=> AndroidRtvReport(
                    marketImage:widget.marketImage,
                    role:widget.role,
                    branch: widget.branch,
                    nationality: widget.nationality,
                    id: widget.id,
                    phone: widget.phone,
                    market: widget.market,
                    username: widget.username,
                    profileImage: widget.profileImage,
                    rtvTasks: task,
                  )
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 15.h),
              height: 82.h,
              width:MediaQuery.of(context).size.width-20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetailsDone("Market".tr+"\t", task.market),
                      titleAndDetailsDone("Merchandiser".tr+"\t", task.madeBy),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetailsDone("Branch".tr+"\t",task.branch),
                      titleAndDetailsDone('Date'.tr+"\t", task.taskDate),
                    ],
                  ),

                ],
              ),
            ),
          ),),
        SizedBox(height: 10.h,)
      ]
  );

  Widget buildDoneInventoryTask(InventoryTask task) =>  Column
    (
      children:<Widget> [
        Material(
          elevation: 10,
          color: backgroundColor2,
          borderRadius: BorderRadius.circular(10.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            onTap: (){
              Get.to(()=>
                  AndroidInventoryReport(
                    marketImage:widget.marketImage,
                    role:widget.role,
                    branch: widget.branch,
                    nationality: widget.nationality,
                    id: widget.id,
                    phone: widget.phone,
                    market: widget.market,
                    username: widget.username,
                    profileImage: widget.profileImage,
                    inventoryTask: task,
                  )
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 15.h),
              height: 82.h,
              width:MediaQuery.of(context).size.width-20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetailsDone("Market".tr+"\t", task.market),
                      titleAndDetailsDone("Merchandiser".tr+"\t", task.madeBy),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetailsDone("Branch".tr+"\t",task.branch),
                      titleAndDetailsDone('Date'.tr+"\t", task.taskDate),
                    ],
                  ),

                ],
              ),
            ),
          ),),
        SizedBox(height: 10.h,)
      ]
  );

  Widget buildDonePieceTask(AvailabilityTaskModel task) =>  Column(
      children:<Widget> [
        Material(
          elevation: 10,
          color: backgroundColor2,
          borderRadius: BorderRadius.circular(10.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            onTap: (){
              Get.to(()=> AndroidAvailabilityReport(
                    role: widget.role,
                    availability: task,
                    nationality: widget.nationality,
                    phone: widget.phone,
                    marketImage:task.market ,
                    profileImage: widget.profileImage,
                    market:task.market ,
                    branch: task.branch,
                    username: widget.username,
                    id: widget.id,
                  )
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 15.h),
              height: 82.h,
              width:MediaQuery.of(context).size.width-20,
              //344.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetailsDone("Market".tr+"\t", task.market),
                      titleAndDetailsDone("Merchandiser".tr+"\t", task.madeBy),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetailsDone("Branch".tr+"\t",task.branch),
                      titleAndDetailsDone('Date'.tr+"\t", task.taskDate),
                    ],
                  ),
                ],
              ),
            ),
          ),),
        SizedBox(height: 10.h,)
      ]
  );

  Widget buildDonePlanogramTask(AiPlanogramModel task) => Column(
      children:<Widget> [
        Material(
          elevation: 10,
          color: backgroundColor2,
          borderRadius: BorderRadius.circular(10.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            onTap: (){
              Get.to(()=> AndroidPlanogramReport(
                    role: widget.role,
                    planogramModel: task,
                    nationality: widget.nationality,
                    phone: widget.phone,
                    marketImage:task.market ,
                    profileImage: widget.profileImage,
                    market:task.market ,
                    branch: task.branch,
                    username: widget.username,
                    id: widget.id,
                  )
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 15.h),
              height: 82.h,
              width:MediaQuery.of(context).size.width-20,
              //344.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetailsDone("Market".tr+"\t", task.market),
                      titleAndDetailsDone("Merchandiser".tr+"\t", task.madeBy),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetailsDone("Branch".tr+"\t",task.branch),
                      titleAndDetailsDone('Date'.tr+"\t", task.taskDate),
                    ],
                  ),

                ],
              ),
            ),
          ),),
        SizedBox(height: 10.h,)
      ]
  );

  Widget buildDoneShareTask(AiShareModel task) => Column(
      children:<Widget> [
        Material(
          elevation: 10,
          color: backgroundColor2,
          borderRadius: BorderRadius.circular(10.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            onTap: (){
              Get.to(()=> AndroidShareOfShelvesReport(
                    role: widget.role,
                    shareOfShellTask: task,
                    nationality: widget.nationality,
                    phone: widget.phone,
                    marketImage:task.market ,
                    profileImage: widget.profileImage,
                    market:task.market ,
                    branch: task.branch,
                    username: widget.username,
                    id: widget.id,
                  )
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 15.h),
              height: 82.h,
              width:MediaQuery.of(context).size.width-20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetailsDone("Market".tr+"\t", task.market),
                      titleAndDetailsDone("Merchandiser".tr+"\t", task.madeBy),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetailsDone("Branch".tr+"\t",task.branch),
                      titleAndDetailsDone('Date'.tr+"\t", task.taskDate),
                    ],
                  ),
                ],
              ),
            ),
          ),),
        SizedBox(height: 10.h,)
      ]
  );

  Widget buildDonePricingTask(PricingTask task) =>  Column(
      children:<Widget> [
        Material(
          elevation: 10,
          color: backgroundColor2,
          borderRadius: BorderRadius.circular(10.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            onTap: (){
              Get.to(()=> AndroidPricingReport(
                    role: widget.role,
                    pricingTaskModel: task,
                    nationality: widget.nationality,
                    phone: widget.phone,
                    marketImage:task.market ,
                    profileImage: widget.profileImage,
                    market:task.market ,
                    branch: task.branch,
                    username: widget.username,
                    id: widget.id,
                  )
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 15.h),
              height: 82.h,
              width:MediaQuery.of(context).size.width-20,
              //344.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetailsDone("Market".tr+"\t", task.market),
                      titleAndDetailsDone("Merchandiser".tr+"\t", task.madeBy),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetailsDone("Branch".tr+"\t",task.branch),
                      titleAndDetailsDone('Date'.tr+"\t", task.taskDate),
                    ],
                  ),
                ],
              ),
            ),
          ),),
        SizedBox(height: 10.h,)
      ]
  );

  Widget buildDonePhotosTask(FullVisit task) =>  Column(
      children:<Widget> [
        Material(
          elevation: 10,
          color: backgroundColor2,
          borderRadius: BorderRadius.circular(10.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            onTap: (){
              Get.to(()=>
                  AndroidCapturePhotoReport(
                    role: widget.role,
                    capturePhotos: task,
                    nationality: widget.nationality,
                    phone: widget.phone,
                    marketImage:task.market ,
                    profileImage: widget.profileImage,
                    market:task.market ,
                    branch: task.branch,
                    username: widget.username,
                    id: widget.id,
                  )
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 15.h),
              height: 82.h,
              width:MediaQuery.of(context).size.width-20,
              //344.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetailsDone("Market".tr+"\t", task.market),
                      titleAndDetailsDone("Merchandiser".tr+"\t", task.madeBy),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetailsDone("Branch".tr+"\t",task.branch),
                      titleAndDetailsDone('Date'.tr+"\t", task.date),
                    ],
                  ),

                ],
              ),
            ),
          ),),
        SizedBox(height: 10.h,)
      ]
  );

  /// stream function
  /// all Tasks
  Stream<List<NewAllTask>> readAllTask(String title,String taskCase) =>
      FirebaseFirestore.instance
          .collection('New Tasks')
          .where("status", isEqualTo: taskCase)
          .where("title",isEqualTo: title)
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => NewAllTask.fromJson(doc.data()))
          .toList());


  Stream<List<RTVTaskModel>> readDoneRTVTasks(String tittle) =>
      FirebaseFirestore.instance
          .collection("RTV Products")
          .where("market",isEqualTo :widget.market)
          .where("type", isEqualTo: tittle)
          .where("status", isEqualTo: "done")
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => RTVTaskModel.fromMap(doc.data()))
          .toList());

  Stream<List<InventoryTask>> readDoneInventoryTasks(String title) =>
      FirebaseFirestore.instance
          .collection('Inventory Tasks')
          .where("market",isEqualTo :widget.market)
          .where("status", isEqualTo: "Done")
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => InventoryTask.fromMap(doc.data()))
          .toList());

  Stream<List<AvailabilityTaskModel>> readDoneAvailabilityTasks(String place) =>
      FirebaseFirestore.instance
          .collection("Availability")
          .where("market",isEqualTo :widget.market)
          .where("status", isEqualTo: "Done")
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => AvailabilityTaskModel.fromMap(doc.data()))
          .toList());

  Stream<List<FullVisit>> readDonePhotosTask() =>
      FirebaseFirestore.instance
          .collection("Visits")
          .where("market",isEqualTo :widget.market)
          .where("status", isEqualTo: "done")
      // .where(taskTitle)
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => FullVisit.fromMap(doc.data()))
          .toList());

  Stream<List<PricingTask>> readDonePricingTask(String taskTitle) =>
      FirebaseFirestore.instance
          .collection("Offers")
          .where("market",isEqualTo :widget.market)
          .where("status", isEqualTo: "done")
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => PricingTask.fromMap(doc.data()))
          .toList());

  Stream<List<AiPlanogramModel>> readDonePlanogramTasks() =>
      FirebaseFirestore.instance
          .collection("Planogram")
          .where("market",isEqualTo :widget.market)
          .where("status", isEqualTo: "done")
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => AiPlanogramModel.fromJson(doc.data()))
          .toList());

  Stream<List<AiShareModel>> readDoneShareOfShellTask() =>
      FirebaseFirestore.instance
          .collection('Share Of Shelves')
          .where("market",isEqualTo :widget.market)
          .where("status", isEqualTo: "Done")
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => AiShareModel.fromJson(doc.data()))
          .toList());

  /// new Tasks Widgets
  Widget buildNewTasks(NewAllTask task) =>  Column(
      children:<Widget> [
        Material(
          elevation: 10,
          color: backgroundColor2,
          borderRadius: BorderRadius.circular(10.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 15.h),
              height: 82.h,
              width:MediaQuery.of(context).size.width-20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetailsNew("Market".tr+"\t", task.market),
                      titleAndDetailsNew("Merchandiser".tr+"\t", task.madeBy),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetailsNew("Branch".tr+"\t",task.branch),
                      titleAndDetailsNew('Date'.tr+"\t", DateFormat('yyyy-MM-dd')
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



}


