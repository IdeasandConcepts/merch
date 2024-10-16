

import 'package:arrow_merchandising/view/screens/reports/availability/availability_report.dart';
import 'package:arrow_merchandising/view/screens/reports/capture_photo/capture_photo_report.dart';
import 'package:arrow_merchandising/view/screens/reports/inventory/inventory_report.dart';
import 'package:arrow_merchandising/view/screens/reports/pricing/pricing_report.dart';
import 'package:arrow_merchandising/view/screens/reports/rtv/rtv_report.dart';
import 'package:arrow_merchandising/view/screens/reports/share0fshelfs/share_of_shelfs_reports.dart';
import 'package:arrow_merchandising/models/Visits.dart';

import 'package:arrow_merchandising/models/ai_planogram_model.dart';
import 'package:arrow_merchandising/models/ai_share_model.dart';
import 'package:arrow_merchandising/models/availability_task.dart';

import 'package:flutter/material.dart';
import 'package:arrow_merchandising/models/inventory_task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:arrow_merchandising/const.dart';
import 'package:arrow_merchandising/models/pricing_model.dart';
import 'package:arrow_merchandising/models/rtv_model.dart';

import 'package:arrow_merchandising/view/screens/reports/planogram/planogram_report.dart';
import 'package:arrow_merchandising/view/widgets/custom_dropdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class AndroidMerchTasks extends StatefulWidget {
  final String  profileImage,city, branch, nationality;
  final String market,marketImage,role,username;
  final int id, phone;

  final String merchandiser;
  const AndroidMerchTasks({Key? key,
    required this.city,
    required this.market,
    required this.username,
    required this.role,
    required this.marketImage,
    required this.profileImage,
    required this.branch,
    required this.id,
    required this.phone,
    required this.nationality,
    required this.merchandiser

  }) : super(key: key);

  @override
  State<AndroidMerchTasks> createState() => _AndroidMerchTasksState();
}

class _AndroidMerchTasksState extends State<AndroidMerchTasks> {

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
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return   Container(
          padding:  EdgeInsets.only(left:10.w,right: 10.w),
       width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: ListView(
          controller: _scrollController,
        children: [
          Container(
            height:(tName != "RTV")?180.h: 240.h,
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
                  if (tName == "RTV" )
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
         // SizedBox(height: 15.h),
        SizedBox(height: 10,),
          (tName=="RTV")?
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child:
            StreamBuilder<List<RTVTaskModel>>(
                stream: readDoneRTVTasks(rTVCase,selectedPlace),
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
          ):
          (tName=="Visits")?
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
                  readDonePhotosTask(selectedPlace),
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
          ):
          (tName=="Availability")?
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
                  stream: readDoneInventoryTasks(selectedPlace
                  ),
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
          ):
          (tName=="Share Of Shelves")?
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: StreamBuilder<List<AiShareModel>>(
                stream: readDoneShareOfShellTask(selectedPlace),
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
          ):
          (tName=="Planogram")?
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: StreamBuilder<List<AiPlanogramModel>>(
                stream: readDonePlanogramTasks(selectedPlace),
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
          ):
          (tName=="Offers")?
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: StreamBuilder<List<PricingTask>>(
                stream: readDonePricingTask(selectedPlace),
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
          ) :Container(height: 20,),

    ]
    ),
      ),
    );
  }


  /// planogram
  Widget buildPlanogramTask(AiPlanogramModel task) => Padding(
    padding: const EdgeInsets.only(left:15.0,right:15),
    child: Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: kprimaryColor.withOpacity(0.45),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Text(task.taskDate,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.only(left:18.0),
            child: Text(task.taskTime,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold

            ),),
          ),
          Padding(
            padding: const EdgeInsets.only(left:18.0),
            child: Text("Result'.tr+'\t${task.degree}",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.only(left:18.0),
            child: Text("Planogram",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold
            ),),
          ),
        ],
      ),
    ),
  );


  Widget titleAndDetails(String title, String details) {
    return
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: (MediaQuery.of(context).size.width /5.5).w,
            color: kprimaryColor,
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
        // ),
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
              Get.to(()=>
                  AndroidRtvReport(
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
                      titleAndDetails("Market".tr+"\t", task.market),
                      (task.taskType!="New Task")?  titleAndDetails("Task Type".tr+"\t", "Dail Task".tr):
                      titleAndDetails("Order By".tr+"\t", task.orderBy.tr),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetails("Branch".tr+"\t",task.branch),
                      titleAndDetails('Date'.tr+"\t", task.taskDate),
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
                      titleAndDetails("Market".tr+"\t", task.market),
                      (task.taskType!="New Task")?  titleAndDetails("Task Type".tr+"\t", "Dail Task".tr):
                      titleAndDetails("Order By".tr+"\t", task.orderBy.tr),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetails("Branch".tr+"\t",task.branch),
                      titleAndDetails('Date'.tr+"\t", task.taskDate),
                    ],
                  ),
                ],
              ),
            ),
          ),),
        SizedBox(height: 10.h,)
      ]
  );

  Widget buildDonePieceTask(AvailabilityTaskModel task) =>  Column
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
                  AndroidAvailabilityReport(
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
                      titleAndDetails("Market".tr+"\t", task.market),
                      (task.taskType!="New Task")?  titleAndDetails("Task Type".tr+"\t", "Dail Task".tr):
                      titleAndDetails("Order By".tr+"\t", task.orderBy.tr),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetails("Branch".tr+"\t",task.branch),
                      titleAndDetails('Date'.tr+"\t", task.taskDate),
                    ],
                  ),
                ],
              ),
            ),
          ),),
        SizedBox(height: 10.h,)
      ]
  );

  Widget buildDonePlanogramTask(AiPlanogramModel task) =>  Column
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
                  AndroidPlanogramReport(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetails("Market".tr+"\t", task.market),
                      (task.taskType!="New Task")?  titleAndDetails("Task Type".tr+"\t", "Dail Task".tr):
                      titleAndDetails("Order By".tr+"\t", task.orderBy.tr),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetails("Branch".tr+"\t",task.branch),
                      titleAndDetails('Date'.tr+"\t", task.taskDate),
                    ],
                  ),

                ],
              ),
            ),
          ),),
        SizedBox(height: 10.h,)
      ]
  );

  Widget buildDoneShareTask(AiShareModel task) =>  Column
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
                  AndroidShareOfShelvesReport(
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
              //344.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetails("Market".tr+"\t", task.market),
                      (task.taskType!="New Task")?  titleAndDetails("Task Type".tr+"\t", "Dail Task".tr):
                      titleAndDetails("Order By".tr+"\t", task.orderBy.tr),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetails("Branch".tr+"\t",task.branch),

                      titleAndDetails('Date'.tr+"\t", task.taskDate),
                    ],
                  ),

                ],
              ),
            ),
          ),),
        SizedBox(height: 10.h,)
      ]
  );

  Widget buildDonePricingTask(PricingTask task) =>  Column
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
                  AndroidPricingReport(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetails("Market".tr+"\t", task.market),
                      titleAndDetails("Merchandiser".tr+"\t", task.madeBy),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetails("Branch".tr+"\t",task.branch),
                      titleAndDetails('Date'.tr+"\t", task.taskDate),
                    ],
                  ),

                ],
              ),
            ),
          ),),
        SizedBox(height: 10.h,)
      ]
  );

  Widget buildDonePhotosTask(FullVisit task) =>  Column
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetails("Market".tr+"\t", task.market),
                      titleAndDetails("Task Type".tr+"\t", "Dail Task".tr),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetails("Branch".tr+"\t",task.branch),
                      titleAndDetails('Date'.tr+"\t", task.date),
                    ],
                  ),

                ],
              ),
            ),
          ),),
        SizedBox(height: 10.h,)
      ]
  );

  Stream<List<RTVTaskModel>> readDoneRTVTasks(String tittle,String sPlace) =>
      FirebaseFirestore.instance
          .collection("RTV Products")
      .where("place",isEqualTo: sPlace)
          .where("type", isEqualTo: tittle)
          .where("made_by", isEqualTo: widget.merchandiser)
          .where("status", isEqualTo: "done")
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => RTVTaskModel.fromMap(doc.data()))
          .toList());

  Stream<List<InventoryTask>> readDoneInventoryTasks(String sPlace) =>
      FirebaseFirestore.instance
          .collection('Inventory Tasks')
          .where("made_by", isEqualTo: widget.merchandiser)
          .where("status", isEqualTo: "Done")
         .where("place", isEqualTo: sPlace)
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => InventoryTask.fromMap(doc.data()))
          .toList());

  Stream<List<AvailabilityTaskModel>> readDoneAvailabilityTasks(String sPlace) =>
      FirebaseFirestore.instance
          .collection("Availability")
          .where("place",isEqualTo :sPlace)
          .where("made_by", isEqualTo: widget.merchandiser)
          .where("status", isEqualTo: "Done")
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => AvailabilityTaskModel.fromMap(doc.data()))
          .toList());

  Stream<List<FullVisit>> readDonePhotosTask(String sPlace
      ) =>
      FirebaseFirestore.instance
          .collection("Visits")
          .where("place",isEqualTo :sPlace)
          .where("made_by", isEqualTo: widget.merchandiser)
          .where("status", isEqualTo: "done")
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => FullVisit.fromMap(doc.data()))
          .toList());

  Stream<List<PricingTask>> readDonePricingTask(String sPlace) =>
      FirebaseFirestore.instance
          .collection("Offers")
           .where("place",isEqualTo :sPlace)
           .where("made_by", isEqualTo: widget.merchandiser)
           .where("status", isEqualTo: "done")
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => PricingTask.fromMap(doc.data()))
          .toList());

  Stream<List<AiPlanogramModel>> readDonePlanogramTasks(String sPlace) =>
      FirebaseFirestore.instance
          .collection("Planogram")
          .where("place",isEqualTo :sPlace)
          .where("made_by", isEqualTo: widget.merchandiser)
          .where("status", isEqualTo: "done")
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => AiPlanogramModel.fromJson(doc.data()))
          .toList());

  Stream<List<AiShareModel>> readDoneShareOfShellTask(String sPlace) =>
      FirebaseFirestore.instance
          .collection('Share Of Shelves')
        .where("place",isEqualTo :sPlace)
        .where("made_by", isEqualTo: widget.merchandiser)
          .where("status", isEqualTo: "Done")
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => AiShareModel.fromJson(doc.data()))
          .toList());

}
