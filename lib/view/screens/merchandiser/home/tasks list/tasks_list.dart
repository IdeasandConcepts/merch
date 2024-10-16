


import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/availability/accepting_availbility.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/invintory/accepting_inventory.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/planogram/planogram_accepting_screen.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/pricing/accepting_pricing.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/rtv/accepting_rtv_task.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/share_of_shelves/share_accept_screen.dart';
import 'package:arrow_merchandising/models/new_task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import 'package:arrow_merchandising/const.dart';
import 'package:intl/intl.dart';

class NewTaskList extends StatefulWidget {
  final int id, phone,managerPhone;
  final String username,
      marketImage,
      profileImage,
      branch,
      manegerName,
      market,
      nationality;
     // marketDetails;
  final List<String> conditionList;
  const NewTaskList(
      {super.key,
        required this.username,
        required this.marketImage,
        required this.profileImage,
        required this.branch,
        required this.market,
        required this.id,
        required this.phone,
        required this.nationality,
        required this.manegerName,
        required this.managerPhone, required this.conditionList

      });

  @override
  State<NewTaskList> createState() => _TaskListState();
}

class _TaskListState extends State<NewTaskList> {


  // IconData pricing_icon=Icons.arrow_drop_down;
  // IconData inventory_icon=Icons.arrow_drop_down;
  // IconData availability_icon=Icons.arrow_drop_down;
  // IconData share_icon=Icons.arrow_drop_down;
  // IconData rtv_icon=Icons.arrow_drop_down;
  // IconData planogram_icon=Icons.arrow_drop_down;
  // IconData category_icon=Icons.arrow_drop_down;
  // IconData category_icon=Icons.arrow_drop_down;

  // bool
  // //open_pricing=false,
  // open_planogram=false,
  //     open_share_of_shalfes=false,
  //     open_inventory=false,
  //     open_availability=false,
  //     open_rtv=false;
  //List <String> conditionList=[];
  double screenHeight=0.0;
  double screenWidth=0.0;
  bool startAnimation=false;

  ScrollController _scrollController =ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation=true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // List <String> conditionList=[widget.username,"Any Merchandiser"];
    return   SafeArea(
      // width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height-90,
            child: ListView(
                controller: _scrollController,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left:25.w,right:25.w,top:15.h),
                    child: Container(
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(20),
                      //   color: Colors.grey.withOpacity(0.3),
                      // ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            // Padding(
                            //   padding:  EdgeInsets.only(left:3.h,right:3.h),
                            //   child: Column(
                            //     mainAxisAlignment: MainAxisAlignment.start,
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [

                        Padding(
                        padding:  EdgeInsets.only(right:5.w,left: 5.w),
                        child: Container(
                         // padding:  EdgeInsets.only(right:10.w,left: 10.w),
                            width:MediaQuery.of(context).size.width / 5.9,
                            // decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(20),
                            //   color: kprimaryColor,
                            // ),
                                    child: Text('Date'.tr,style: TextStyle(
                                        fontSize: 15.sp,fontWeight: FontWeight.bold,
                                      //  color: whiteColor
                                    ),)),
                        ),
                            Padding(
                              padding:  EdgeInsets.only(right:15.w,left:15.w),
                              child: Container(
                                  padding:  EdgeInsets.only(right:8.w,left: 8.w),
                                  width:MediaQuery.of(context).size.width / 4.9,
                                  // decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.circular(20),
                                  //   color: kprimaryColor,
                                  // ),
                                    child: Text('Display'.tr,
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: blackColor
                                      ),)),
            ),
                            Padding(
                              padding:  EdgeInsets.only(right:15.w,left:15.w),
                              child: Container(
                                 // padding:  EdgeInsets.only(right:10.w,left: 10.w),
                                  width:MediaQuery.of(context).size.width / 5,
                                  // decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.circular(20),
                                  //   color: kprimaryColor,
                                  // ),
                                      child: Text('Task'.tr,style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                        color: blackColor
                                      ),)),
                      ),
                      Text('Status'.tr,
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          color: blackColor
                      ),),

                           ],
                         ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left:25,right:25,top: 5),
                    child: Divider(),
                  ),

                  //New Rtv
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: StreamBuilder<List<NewAllTask>>(
                        stream: readNewOrRunTask("not yet","RTV Section"),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text(' Error ya Hantop :: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            final task = snapshot.data!;
                            return ListView(
                              controller: _scrollController,
                              shrinkWrap: true,
                              children: task.map(buildRTVTask).toList(),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ),
                  //Divider(),
                  //RunRtv
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: StreamBuilder<List<NewAllTask>>(
                        stream: readNewOrRunTask("run","RTV Section"),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text(' Error ya Hantop :: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            final task = snapshot.data!;
                            return ListView(
                              controller: _scrollController,
                              shrinkWrap: true,
                              children: task.map(buildRTVTask).toList(),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ),
                  // Divider(),

                  //New inventory
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        // color: kprimaryColor.withOpacity(0.5),
                        // borderRadius: BorderRadius.circular(25)
                      ),
                      child: StreamBuilder<List<NewAllTask>>(
                          stream: readNewOrRunTask("not yet","Inventory"),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text(' Error ya Hantop :: ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              final task = snapshot.data!;
                              return ListView(
                                controller: _scrollController,
                                shrinkWrap: true,
                                children: task.map(buildInventoryTask).toList(),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    ),
                  ),
                  //Divider(),
//Run inventory
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        // color: kprimaryColor.withOpacity(0.5),
                        // borderRadius: BorderRadius.circular(25)
                      ),
                      child: StreamBuilder<List<NewAllTask>>(
                          stream: readNewOrRunTask("run","Inventory"),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text(' Error ya Hantop :: ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              final task = snapshot.data!;
                              return ListView(
                                controller: _scrollController,
                                shrinkWrap: true,
                                children: task.map(buildInventoryTask).toList(),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    ),
                  ),
                  //Divider(),

                  //New Availability
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      decoration: BoxDecoration(
                        // color: kprimaryColor.withOpacity(0.5),
                        // borderRadius: BorderRadius.circular(25)
                      ),
                      child: StreamBuilder<List<NewAllTask>>(
                          stream: readNewOrRunTask("not yet","Availability"),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text(' Error ya Hantop :: ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              final task = snapshot.data!;
                              return ListView(
                                controller: _scrollController,
                                shrinkWrap: true,
                                children: task.map(buildAvailabilityTask).toList(),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    ),
                  ),
                  //Divider(),
//Run Availability
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      decoration: BoxDecoration(
                        // color: kprimaryColor.withOpacity(0.5),
                        // borderRadius: BorderRadius.circular(25)
                      ),
                      child: StreamBuilder<List<NewAllTask>>(
                          stream: readNewOrRunTask("run","Availability"),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text(' Error ya Hantop :: ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              final task = snapshot.data!;
                              return ListView(
                                controller: _scrollController,
                                shrinkWrap: true,
                                children: task.map(buildAvailabilityTask).toList(),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    ),
                  ),
                  //Divider(),

                  // New ShareOfShellTask
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      decoration: BoxDecoration(
                        //  color: kprimaryColor.withOpacity(0.5),
                        // borderRadius: BorderRadius.circular(25)
                      ),
                      child: StreamBuilder<List<NewAllTask>>(
                          stream: readNewOrRunTask("not yet","Share of shelves"),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text(' Error ya Hantop :: ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              final task = snapshot.data!;
                              return ListView(
                                controller: _scrollController,
                                shrinkWrap: true,
                                children: task.map(buildShareTask).toList(),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    ),
                  ),
                  //Divider(),
                  // Run ShareOfShellTask
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      decoration: BoxDecoration(
                        //  color: kprimaryColor.withOpacity(0.5),
                        // borderRadius: BorderRadius.circular(25)
                      ),
                      child: StreamBuilder<List<NewAllTask>>(
                          stream: readNewOrRunTask("run","Share of shelves"),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text(' Error ya Hantop :: ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              final task = snapshot.data!;
                              return ListView(
                                controller: _scrollController,
                                shrinkWrap: true,
                                children: task.map(buildShareTask).toList(),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    ),
                  ),
                  //Divider(),

                  //New Pricing
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      decoration: BoxDecoration(
                        // color: kprimaryColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(25)),
                      child: StreamBuilder<List<NewAllTask>>(
                          stream: readNewOrRunTask("not yet","Offers"),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text(' Error ya Hantop :: ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              final task = snapshot.data!;
                              return ListView(
                                controller: _scrollController,
                                shrinkWrap: true,
                                children: task.map(buildPricing).toList(),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    ),
                  ),
                  //Divider(),
                  //Run Pricing
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      decoration: BoxDecoration(
                        // color: kprimaryColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(25)),
                      child: StreamBuilder<List<NewAllTask>>(
                          stream: readNewOrRunTask("run","Offers"),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text(' Error ya Hantop :: ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              final task = snapshot.data!;
                              return ListView(
                                controller: _scrollController,
                                shrinkWrap: true,
                                children: task.map(buildPricing).toList(),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    ),
                  ),
                  //New inventory
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        // color: kprimaryColor.withOpacity(0.5),
                        // borderRadius: BorderRadius.circular(25)
                      ),
                        child: StreamBuilder<List<NewAllTask>>(
                            stream: readNewOrRunTask("not yet","Planogram"),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text(' Error ya Hantop :: ${snapshot.error}');
                              } else if (snapshot.hasData) {
                                final task = snapshot.data!;
                                return ListView(
                                  controller: _scrollController,
                                  shrinkWrap: true,
                                  children: task.map(buildPlanogram).toList(),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    ),
                  ),
                  //Divider(),
//Run inventory
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        // color: kprimaryColor.withOpacity(0.5),
                        // borderRadius: BorderRadius.circular(25)
                      ),
                      child: StreamBuilder<List<NewAllTask>>(
                          stream: readNewOrRunTask("run","Planogram"),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text(' Error ya Hantop :: ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              final task = snapshot.data!;
                              return ListView(
                                controller: _scrollController,
                                shrinkWrap: true,
                                children: task.map(buildPlanogram).toList(),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }),
                    ),
                  ),
                  //Divider(),

                  //Divider(),
                  Padding(padding: EdgeInsets.only(bottom:30)),
                ]
            ),
          )
      ),
    );
  }


  Widget buildRTVTask(NewAllTask task) => InkWell(
    onTap: (){
      Get.to(() =>AndroidAcceptingRtv(
        manegerName: widget.manegerName,
      conditionList:widget.conditionList,
        managerPhone: widget.managerPhone,
        nationality: widget.nationality,
        id: widget.id,
        phone: widget.phone,
        userName: widget.username,
        market: widget.market,
        branch: widget.branch,
        profileImage: widget.profileImage,
        marketImage: widget.marketImage,
        rtvTask: task,
      ));
    },
    child: Column(
    children: [
        Padding(
          padding:  EdgeInsets.only(left:15.h,right:15.h,top:15.h),
          child: Container(

            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              Padding(
              padding:  EdgeInsets.only(right:5.w,left: 5.w),
              child: Container(
                width:MediaQuery.of(context).size.width / 5,
                          child: Text(    DateFormat('yyyy-MM-dd')
                              .format(task.date),style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),

                   ),
            ),

            Padding(
              padding:  EdgeInsets.only(right:5.w,left: 5.w),
              child: Container(
                width:MediaQuery.of(context).size.width / 5,
                          child: Text(task.place.tr,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                    //     ),
                    //   ],
                    // ),
                  ),
            ),

            Padding(
              padding:  EdgeInsets.only(right:5.w,left: 5.w),
              child: Container(
                width:MediaQuery.of(context).size.width / 5,
                            child: Text("RTV Section".tr,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold
                            ),),
                  ),
            ),

                  Padding(
                      padding:  EdgeInsets.only(right:5.w,left: 5.w),
                      child: Container(
                              margin: EdgeInsets.only(left: 10.h,right: 10.h),
                              height: 15.h,
                             width: 15.h,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                                  color:task.status=="run"? kprimaryColor:Colors.white,
                                  // color:kprimaryColor,
                                  border: Border.all(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 1.0
                                  )
                              ),
                            )
                  ),
                ],
              ),
            ),
          ),
        ),


        Padding(padding: EdgeInsets.only(left:25,right:25,top: 5),
          child: Divider(),
        ),
      ],
    ),
  );

  Widget buildPricing(NewAllTask task) =>InkWell(
    onTap: (){
      Get.to(()=>AndroidAcceptingOffers(

        conditionList:widget.conditionList,
        managerPhone: widget.managerPhone,
        nationality: widget.nationality,
        manegerName: widget.manegerName,
        id: widget.id,
        phone: widget.phone,
        merchandiserName: widget.username,
        market: widget.market,
        branch: widget.branch,
        profileImage: widget.profileImage,
        marketImage: widget.marketImage,
        offersTaskModel: task,
      ));
    },
    child: Column(
      children: [
        Padding(
          padding:  EdgeInsets.only(left:15.h,right:15.h,top:15.h),
          child: Container(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.only(right:5.w,left: 5.w),
                    child: Container(
                      width:MediaQuery.of(context).size.width / 5,

                      child: Text(    DateFormat('yyyy-MM-dd')
                          .format(task.date),style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                        ),
                    //   ],
                    // ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(right:5.w,left: 5.w),
                    child: Container(
                      width:MediaQuery.of(context).size.width / 5,

                      child: Text(task.place.tr,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                        ),
                    //   ],
                    // ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(right:5.w,left: 5.w),
                    child: Container(
                      width:MediaQuery.of(context).size.width / 5,

                      child: Text("Offers".tr,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold
                          ),),
                        ),
                    //   ],
                    // ),
                  ),
                        Padding(
                            padding:  EdgeInsets.only(left:3.h,right:3.h),
                            child:   Container(
                              margin: EdgeInsets.only(left: 10.h,right: 10.h),
                              height: 15.h,
                              width: 15.h,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                                  color:task.status=="run"? kprimaryColor:Colors.white,
                                  border: Border.all(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 1.0
                                  )

                              ),
                            )
                        ),
                      ],
                    ),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(left:25,right:25,top: 5),
          child: Divider(),
        ),
      ],
    ),
  );


  Widget buildPlanogram(NewAllTask task) =>InkWell(
    onTap: (){
      Get.to(()=>AndroidAcceptingPlonogramTaskDetails(
        managerPhone: widget.managerPhone,
        nationality: widget.nationality,
        manegerName: widget.manegerName,
        id: widget.id,
        phone: widget.phone,
        userName: widget.username,
        market: widget.market,
        branch: widget.branch,
        profileImage: widget.profileImage,
        marketImage: widget.marketImage,
        merchPlanogramModel: task,
      ));
    },
    child: Column(
      children: [
        Padding(
          padding:  EdgeInsets.only(left:15.h,right:15.h,top:15.h),
          child: Container(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.only(right:5.w,left: 5.w),
                    child: Container(
                      width:MediaQuery.of(context).size.width / 5,

                      child: Text(    DateFormat('yyyy-MM-dd')
                          .format(task.date),style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                        ),

                  ),
                  Padding(
                    padding:  EdgeInsets.only(right:5.w,left: 5.w),
                    child: Container(
                      width:MediaQuery.of(context).size.width / 5,

                      child: Text(task.place.tr,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                        ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(right:5.w,left: 5.w),
                    child: Container(
                      width:MediaQuery.of(context).size.width / 5,
                      child: Text("Planogram".tr,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold
                          ),),

                    ),
                  ),

                        Padding(
                            padding:  EdgeInsets.only(left:3.h,right:3.h),
                            child:   Container(
                              margin: EdgeInsets.only(left: 10.h,right: 10.h),
                              height: 15.h,
                              width: 15.h,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                                  color:task.status=="run"? kprimaryColor:Colors.white,
                                  border: Border.all(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 1.0
                                  )
                              ),
                            )
                        ),
                ],
              ),
            ),
          ),
        ),

        Padding(padding: EdgeInsets.only(left:25,right:25,top: 5),
          child: Divider(),
        ),
      ],
    ),
  );

  Widget buildInventoryTask(NewAllTask task) => InkWell(
    onTap: () {
      Get.to(() => AndroidAcceptingInventory(

        //:widget.conditionList,
        manegerName: widget.manegerName,
        inventoryTask: task,
        managerPhone:widget.managerPhone,
        branch: widget.branch,
        nationality: widget.nationality,
        //marketDetails: widget.marketDetails,
        id: widget.id,
        phone: widget.phone,
        market: widget.market,
        name: widget.username,
        marketImage: widget.marketImage,
        profileImage: widget.profileImage,
      ));

    },
    child: Column(
      children: [

        Padding(
          padding:  EdgeInsets.only(left:15.h,right:15.h,top:15.h),
          child: Container(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  Padding(
                    padding:  EdgeInsets.only(right:5.w,left: 5.w),
                    child: Container(
                      width:MediaQuery.of(context).size.width / 5,

                            child: Text(    DateFormat('yyyy-MM-dd')
                                .format(task.date),style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                          ),
                        ),
                  Padding(
                    padding:  EdgeInsets.only(right:5.w,left: 5.w),
                    child: Container(
                      width:MediaQuery.of(context).size.width / 5,
                            child: Text(task.place.tr,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                    ),
                  ),
            Padding(
              padding:  EdgeInsets.only(right:5.w,left: 5.w),
              child: Container(
                width:MediaQuery.of(context).size.width / 5,

                child: Text("Inventory".tr,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold
                          ),),
                        ),
                  ),
                        Padding(
                            padding:  EdgeInsets.only(left:3.w,right:3.w),
                            child:   Container(
                              margin: EdgeInsets.only(left: 10.w,right: 10.w),
                              height: 15.h,
                              width: 15.w,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                                  color:task.status=="run"? kprimaryColor:Colors.white,
                                  // color:kprimaryColor,
                                  border: Border.all(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 1.0
                                  )

                              ),
                            )
                        ),
                      ],
                    ),
            ),
          ),
        ),

        Padding(padding: EdgeInsets.only(left:25,right:25,top: 5),
          child: Divider(),
        ),
      ],
    ),
  );
  Widget buildAvailabilityTask(NewAllTask task) => InkWell(
    onTap: (){
      Get.to(()=>
          AndroidAcceptingAvailabilityTask(
            managerName:widget.manegerName,
            conditionList:widget.conditionList,
            managerPhone:widget.managerPhone,
            branch: widget.branch,
            nationality: widget.nationality,
            id: widget.id,
            phone: widget.phone,
            market: widget.market,
            userName: widget.username,
            marketImage: widget.marketImage,
            profileImage: widget.profileImage,
            availabilityModel: task,
          )
      );
    },
    child:Column(
      //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Padding(
          padding:  EdgeInsets.only(left:15.w,right:15.w,top:15.h),
          child: Container(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.only(right:5.w,left: 5.w),
                    child: Container(
                      width:MediaQuery.of(context).size.width / 5,
                      child: Text(
                        DateFormat('yyyy-MM-dd')
                            .format(
                        task.date),style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                        ),
                  ),

            Padding(
              padding:  EdgeInsets.only(right:5.w,left: 5.w),
              child: Container(
                width:MediaQuery.of(context).size.width / 5,
                child: Text(task.place.tr,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                    ),
                  ),
            Padding(
              padding:  EdgeInsets.only(right:5.w,left: 5.w),
              child: Container(
                width:MediaQuery.of(context).size.width / 5,
                child: Text("Availability".tr,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold
                          ),),
                        ),
                  ),
                        Padding(
                            padding:  EdgeInsets.only(left:3.w,right:3.w),
                            child:   Container(
                              margin: EdgeInsets.only(left: 10.h,right: 10.w),
                              height: 15.h,
                              width: 15.w,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                                  color:task.status=="run"? kprimaryColor:Colors.white,
                                  // color:kprimaryColor,
                                  border: Border.all(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 1.0
                                  )
                              ),
                            )
                        ),
                      ],
                    ),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(left:25,right:25,top: 5),
          child: Divider(),
        ),
      ],
    ),
  );
  Widget buildShareTask(NewAllTask task) => InkWell(
    onTap: () {
      Get.to(() => AcceptingShareOfShelfScreen(
        conditionList:widget.conditionList,
        managerPhone: widget.managerPhone,
        merchShareOfShellTask: task,
        branch: widget.branch,
        nationality: widget.nationality,
        managerName: widget.manegerName,
        id: widget.id,
        phone: widget.phone,
        market: widget.market,
        name: widget.username,
        marketImage: widget.marketImage,
        profileImage: widget.profileImage,
        title: 'Share of Shelves',
      ));
    },
    child: Column(
      children: [
        Padding(
          padding:  EdgeInsets.only(left:15.w,right:15.w,top:15.h),
          child: Container(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
            Padding(
              padding:  EdgeInsets.only(right:5.w,left: 5.w),
              child: Container(
                width:MediaQuery.of(context).size.width / 5,
                          child: Text(    DateFormat('yyyy-MM-dd')
                              .format(task.date),style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                        ),
                  ),
            Padding(
              padding:  EdgeInsets.only(right:5.w,left: 5.w),
              child: Container(
                width:MediaQuery.of(context).size.width / 5,
                child: Text(task.branch.tr,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                        ),
                  ),
                        Padding(
                          padding:  EdgeInsets.only(right:5.w,left: 5.w),
                          child: Container(
                            width:MediaQuery.of(context).size.width / 5,
                            child: Text('Share of Shelf'.tr,style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.bold),),
                          ),
                  ),

                        Padding(
                            padding:  EdgeInsets.only(left:3.w,right:3.w),
                            child:   Container(
                              margin: EdgeInsets.only(left: 10.w,right: 10.w),
                              height: 15.h,
                              width: 15.w,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                                  color:task.status=="run"? kprimaryColor:Colors.white,
                                  // color:kprimaryColor,
                                  border: Border.all(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 1.0
                                  )

                              ),
                            )
                        ),
                      ],
                    ),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(left:25.w,right:25.w,top: 5.h),
          child: Divider(),
        ),
      ],
    ),
  );

  Stream<List<NewAllTask>> readNewOrRunTask(String taskCase,String title) =>
      FirebaseFirestore.instance
          .collection("New Tasks")
          .where("merchandiser",isEqualTo: widget.username)
          .where("status", isEqualTo: taskCase)
      .where('title',isEqualTo: title)
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => NewAllTask.fromJson(doc.data()))
          .toList());

}
