

import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/availability/availability.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/merch_nav_bar.dart';

import 'package:arrow_merchandising/view/screens/merchandiser/profile/profile_screen.dart';
import 'package:arrow_merchandising/models/availability_products.dart';
import 'package:arrow_merchandising/models/inventory_products.dart';
import 'package:arrow_merchandising/models/new_task.dart';
import 'package:arrow_merchandising/models/pricing_product.dart';
import 'package:arrow_merchandising/models/rtv_product.dart';
import 'package:arrow_merchandising/models/share_products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:arrow_merchandising/const.dart';

class AndroidAcceptingAvailabilityTask extends StatefulWidget {
  final int id, phone,managerPhone;
  final String profileImage;
  final String marketImage, userName,
      managerName,
      nationality;
  //marketDetails;
  final String market, branch;
  final List<String> conditionList;
  final NewAllTask availabilityModel;

  const AndroidAcceptingAvailabilityTask({
    super.key,
    required this.managerPhone,
    required this.profileImage,
    required this.branch,
    required this.marketImage,
    required this.userName,
    //required this.title,
   // required this.product,
    required this.id,
    required this.phone,
    required this.nationality,
    required this.managerName,
    required this.market,
    //required this.product,
    required this.availabilityModel, required this.conditionList,
  });

  @override
  State<AndroidAcceptingAvailabilityTask> createState() =>
      _AndroidAcceptingAvailabilityTask();
}
class _AndroidAcceptingAvailabilityTask
    extends State<AndroidAcceptingAvailabilityTask> {
  bool switchVal = true;
  double distance=0.0;
  double lat=0.0,lang=0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          actions: [
            if(
            workingOnInventory.length>0
                ||
                workingOnAvailability.length>0
                ||
                workingOnShare.length>0
                ||
                workingOnOffers.length>0
                ||
                workingOnRtv.length>0
            )
              GestureDetector(
                onTap:(){
                  // if(
                  // workingOnPricing.length>0)
                  //  if(
                  // // workingOn.length>0
                  //  )
                  Get.defaultDialog(
                    title:  'Details'.tr,
                    content: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 15,
                            left: 15,
                          ),
                          child: Container(
                            //padding: EdgeInsets.only(top: 20),
                              decoration: BoxDecoration(
                                  color: kprimaryColor.withOpacity(0.45),
                                  borderRadius:
                                  // border: BorderRadius.circular(15)
                                  // border
                                  BorderRadius.circular(15)),

                              child: DataTable(dataTextStyle: TextStyle(fontSize: 20),
                                  //showBottomBorder: true,
                                  //border: TableBorder.all(),
                                  //columnSpacing: 12,
                                  columns: [
                                    DataColumn(
                                        label: Text(
                                          'Task'.tr.toUpperCase(),
                                          style:  TextStyle(fontSize: 10,color: blackColor),
                                        )),
                                    DataColumn(
                                        label: Text(
                                          "",
                                          style: const TextStyle(fontSize: 10,color: blackColor),
                                        )),
                                  ], rows: [
                                    if(workingOnRtv.length>0)
                                      DataRow(cells: <DataCell>[
                                        DataCell(Text(
                                          'RTV Section'.tr.toUpperCase(),
                                          style: const TextStyle(fontSize: 10,color: blackColor),
                                        )),
                                        DataCell(Text(
                                          '${''}',
                                          style: const TextStyle(fontSize: 10,color: blackColor),
                                        )),
                                      ]),
                                    if(workingOnInventory.length>0)
                                      DataRow(cells: <DataCell>[
                                        DataCell(Text(
                                          'Inventory'.tr.toUpperCase(),
                                          style: const TextStyle(fontSize: 10,color: blackColor),
                                        )),
                                        DataCell(Text(
                                          '${''}',
                                          style: const TextStyle(fontSize: 10,color: blackColor),
                                        )),
                                      ]),
                                    if(workingOnAvailability.length>0)
                                      DataRow(cells: <DataCell>[
                                        DataCell(Text(
                                          'Availability'.tr.toUpperCase(),
                                          style: const TextStyle(fontSize: 10,color: blackColor),
                                        )),
                                        DataCell(Text(
                                          '${''}',
                                          style: const TextStyle(fontSize: 10,color: blackColor),
                                        )),
                                      ]),
                                    if(workingOnShare.length>0)
                                      DataRow(cells: <DataCell>[
                                        DataCell(Text(
                                          'Share Of Shelves'.tr.toUpperCase(),
                                          style: const TextStyle(fontSize: 10,color: blackColor),
                                        )),
                                        DataCell(Text(
                                          '${''}',
                                          style: const TextStyle(fontSize: 10,color: blackColor),
                                        )),
                                      ]),
                                    if(workingOnOffers.length>0)
                                      DataRow(cells: <DataCell>[
                                        DataCell(Text(
                                          'Pricing'.tr.toUpperCase(),
                                          style: const TextStyle(fontSize: 10,color: blackColor),
                                        )),
                                        DataCell(Text(
                                          '${''}',
                                          style: const TextStyle(fontSize: 10,color: blackColor),
                                        )),
                                      ]),

                                    // )
                                  ]
                              )
                          ),

                        )
                    ),
                  );
                },
                child: Padding(
                    padding: const EdgeInsets.only(left:15.0,right: 15.0),
                    child:   Container(
                      margin: EdgeInsets.only(left: 35),
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                          //  color:task.status=="run"? Colors.amber:kprimaryColor.withOpacity(0.45),
                          color:whiteColor,
                          border: Border.all(
                              color: blackColor,
                              style: BorderStyle.solid,
                              width: 1.0
                          )

                      ),
                      child: Center(child: Text(
                          style: TextStyle(fontSize: 20),
                          '${
                              workingOnAvailability.length+
                                  workingOnInventory.length+
                                  workingOnRtv.length+
                                  workingOnShare.length+
                                  workingOnOffers.length

                          }')),
                    )
                ),
              ),
          ],
          backgroundColor: kprimaryColor,
          automaticallyImplyLeading: false,
          //preferredSize: const Size.fromHeight(60),
          title:IconButton(
            icon: Icon(Icons.menu,color: whiteColor,),
            onPressed: (){
              Get.defaultDialog(
                  title: "Task Details",
                  content:

                  MerchDrawerItems(
                      market: widget.market,
                      branch: widget.branch,
                      phone: widget.phone,
                      profileImage: widget.profileImage,
                      name: widget.userName
                  ));
            },
          )
      ),

      //appBar: AppBar(),
      body: Padding(
        padding:  EdgeInsets.only(left:20.w ,right: 20.w,top: 10.h),
        child: Column(
          children: [
            Container(
             // padding:const EdgeInsets.all(10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                  border: Border.all()
              ),
              width: 350.h,
              height: 440.w,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Branch'.tr)),
                  DataColumn(label: Text(widget.availabilityModel.branch.tr)),
                ],
                rows: [
                  DataRow(cells: <DataCell>[
                    DataCell(Text('Market'.tr)),
                    DataCell(Text(widget.availabilityModel.market.tr)),
                  ]),
                  DataRow(cells: <DataCell>[
                    DataCell(Text('Task'.tr)),
                    DataCell(Text("Availability".tr)),
                  ]),
                  DataRow(cells: <DataCell>[
                    DataCell(Text(
                      'Order By'.tr,
                    )),
                    DataCell(Text(
                      widget.availabilityModel.madeBy,
                    )),
                  ]),
                  DataRow(cells: <DataCell>[
                    DataCell(Text('Task Date'.tr)),
                    DataCell(Text(
                      DateFormat('yyyy-MM-dd')
                          .format(
                        widget.availabilityModel.date))),
                  ]),

                  // for(int i=0;i<widget.availabilityModel.display.length;i++)
                  DataRow(cells: <DataCell>[
                    DataCell(Text('Place'.tr)),
                    DataCell(
                        Text(
                            widget.availabilityModel.place.tr
                        )),
                  ]),

                  DataRow(cells: <DataCell>[
                    DataCell(Text('Details'.tr)),
                    DataCell(
                        Text(
                            widget.availabilityModel.details.tr
                        )),
                  ]),
                ],
              ),
            ),
if(widget.availabilityModel.status=="run")
        InkWell(

          onTap: () async{
            DateTime dt2 =
            DateTime.parse((
                DateFormat('yyyy-MM-dd')
                    .format
                  (DateTime.now()
                ))
            );
            DateTime dt1 =
            DateTime.parse((
                DateFormat('yyyy-MM-dd')
                    .format
                  (      widget.availabilityModel.date
                ))

            );
            if(dt1.isAfter(dt2)){
              print(dt1);
              print(">>>>>>>>");
              print(dt2);

              Fluttertoast.showToast(
                  msg: "Can't Start Today".tr,
                  backgroundColor: greyColor,
                  toastLength: Toast.LENGTH_LONG,
                  fontSize: 20,
                  gravity:ToastGravity.CENTER
              );
              // print("DT1 is after DT2");
            }
            else  if(dt2.isAfter(dt1)){
              print(dt1);
              print(">>>>>>>>");
              print(dt2);

              Fluttertoast.showToast(
                  msg: "It has been Expired".tr,
                  backgroundColor: greyColor,
                  toastLength: Toast.LENGTH_LONG,
                  fontSize: 20,
                  gravity:ToastGravity.CENTER
              );
              // print("DT1 is after DT2");
            }
            else{
              setState(() {
                if(workingOnAvailability.length==0) {
                  workingOnAvailability.add("Availability");
                }
              });

              Get.to(() =>
                  Availability(
                    category: "All Categories",
                    taskType: "New Task",
                    orderBy: widget.availabilityModel.madeBy,
                    manegerName:widget.managerName,
                    managerPhone: widget.managerPhone,
                    nationality: widget.nationality,
                    place: widget.availabilityModel.place,
                    branch: widget.availabilityModel.branch,
                    market: widget.availabilityModel.market,
                    username: widget.userName,
                    id: widget.id,
                    phone: widget.phone,
                    marketImage: widget.marketImage,
                    profileImage: widget.profileImage,
                  ));

            }
            // Save Data ....
          },
          child: DefualtButton(selected: false,
            text: 'New Task'.tr,
          ),
        ),
          ],
        ),
      ),
      bottomNavigationBar: ((widget.availabilityModel.status=="not yet"))?
      Padding(
        padding:  EdgeInsets.only(left:10.w,right: 10.w,bottom: 5.h),
        child: InkWell(

          onTap: () async{
            DateTime dt2 =
            DateTime.parse((
                DateFormat('yyyy-MM-dd')
                    .format
                  (DateTime.now()
                ))
            );
            DateTime dt1 =
            DateTime.parse((
                DateFormat('yyyy-MM-dd')
                    .format
                  (      widget.availabilityModel.date
                ))

            );
            if(dt1.isAfter(dt2)){
              print(dt1);
              print(">>>>>>>>");
              print(dt2);

              Fluttertoast.showToast(
                  msg: "Can't Start Today".tr,
                  backgroundColor: greyColor,
                  toastLength: Toast.LENGTH_LONG,
                  fontSize: 20,
                  gravity:ToastGravity.CENTER
              );
              // print("DT1 is after DT2");
            }
            else  if(dt2.isAfter(dt1)){
              print(dt1);
              print(">>>>>>>>");
              print(dt2);

              Fluttertoast.showToast(
                  msg: "It has been Expired".tr,
                  backgroundColor: greyColor,
                  toastLength: Toast.LENGTH_LONG,
                  fontSize: 20,
                  gravity:ToastGravity.CENTER
              );
              // print("DT1 is after DT2");
            }
            else{
              print(dt1);
              print(">>>>>>>>");
              print(dt2);
              setState(() {
                if(workingOnAvailability.length==0) {
                  workingOnAvailability.add("Availability");
                }
                // Inventory
                updateData();
                updateMerchaData();
              });

              Get.to(() =>
                  Availability(
                    category: "All Categories",
                    taskType: "New Task",
                    orderBy: widget.availabilityModel.madeBy,
                    manegerName:widget.managerName,
                    managerPhone: widget.managerPhone,
                    nationality: widget.nationality,
                    place: widget.availabilityModel.place,
                    branch: widget.availabilityModel.branch,
                    market: widget.availabilityModel.market,
                    username: widget.userName,
                    id: widget.id,
                    phone: widget.phone,
                    marketImage: widget.marketImage,
                    profileImage: widget.profileImage,
                  ));

            }
            // Save Data ....
          },
          child: DefualtButton(selected: true,
            text: 'Start'.tr,
          ),
        ),
      ):
      Padding(
        padding:  EdgeInsets.only(left:10.w,right: 10.w,bottom: 5.h),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pop();
            // if(completeTasks.length!=0) {
            setState(() {
              completeAvailabilityTasks.add(widget.availabilityModel.place);
              workingOnAvailability = [];
              updateMerchaFinishData();
              updateDatatoFinish();
            });
            Get.offAll(() =>
                MerchNavBar(
                    tab_index: 1,
                    manegerName: widget.managerName,
                    username: widget.userName,
                    marketImage: widget.marketImage,
                    profileImage: widget.profileImage,
                    branch: widget.branch,
                    market: widget.market,
                    id: widget.id,
                    phone: widget.phone,
                    nationality: widget.nationality,
                    mangerphone: widget.managerPhone));

          },
          child: DefualtButton( selected:  true,text: 'Finish'.tr),
        ),
      )

    );
  }

  @override
  updateData() async {
    var user = await FirebaseFirestore.instance
        .collection("New Tasks")
        .where("merchandiser",isEqualTo: widget.userName)
        .where("market", isEqualTo: widget.availabilityModel.market)
        .where("place", isEqualTo:widget.availabilityModel.place)
        .where("made_by", isEqualTo: widget.availabilityModel.madeBy)
        .where('index', isEqualTo: widget.availabilityModel.taskIndex)
        .where("branch", isEqualTo: widget.availabilityModel.branch)
        .where("details", isEqualTo: widget.availabilityModel.details)
        .where("title",isEqualTo: widget.availabilityModel.title )
        .where("status", isEqualTo: "not yet")

        .get();
    if (user.docs.isNotEmpty) {
      var doc_Id = user.docs.first.id;
      await FirebaseFirestore.instance
          .collection("New Tasks")
          .doc(doc_Id)
          .update({"status": "run",
       // "merchandiser":widget.userName
      });

      //   print(doc_Id);
    }
  }

  @override
  updateMerchaData() async {
    var user = await FirebaseFirestore.instance
        .collection('Merchandisers')
    //.where('branch', isEqualTo: widget.branch)
        .where('full_name', isEqualTo: widget.userName)
    //.where('market', isEqualTo: widget.market)
        .where('id', isEqualTo: widget.id)

        .get();
    if (user.docs.isNotEmpty) {
      var doc_Id = user.docs.first.id;
      await FirebaseFirestore.instance
          .collection('Merchandisers')
          .doc(doc_Id)
          .update({"status": "Working On Availability"});

      print("Success");
      //   print(doc_Id);
    }
  }

  @override
  updateMerchaFinishData() async {
    var user = await FirebaseFirestore.instance
        .collection('Merchandisers')
    //.where('branch', isEqualTo: widget.branch)
        .where('full_name', isEqualTo: widget.userName)
    //.where('market', isEqualTo: widget.market)
        .where('id', isEqualTo: widget.id)

        .get();
    if (user.docs.isNotEmpty) {
      var doc_Id = user.docs.first.id;
      await FirebaseFirestore.instance
          .collection('Merchandisers')
          .doc(doc_Id)
          .update({"status": "Finish Availability Task"});

      print("Success");
      //   print(doc_Id);
    }
  }
  @override
  updateDatatoFinish() async {
    var user = await FirebaseFirestore.instance
        .collection("New Tasks")
        .where("merchandiser",isEqualTo: widget.userName)
        .where('market', isEqualTo: widget.availabilityModel.market)
        .where('place', isEqualTo:widget.availabilityModel.place)
        .where('made_by', isEqualTo: widget.availabilityModel.madeBy)
        .where('index', isEqualTo: widget.availabilityModel.taskIndex)
        .where('branch', isEqualTo: widget.availabilityModel.branch)
        .where('details', isEqualTo: widget.availabilityModel.details)
        .where('title', isEqualTo: widget.availabilityModel.title)
        .where('status', isEqualTo: 'run')
        .get();
    if (user.docs.isNotEmpty) {
      var doc_Id = user.docs.first.id;
      await FirebaseFirestore.instance
          .collection("New Tasks")
          .doc(doc_Id)
          .update({"status": "done"});

    //  statusstr = "done";
      print(doc_Id);
    }
  }

  // static void navigateTo(double lat, double lng) async {
  //   try{
  //     var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
  //     //  if (await canLaunch(uri.toString())) {
  //     await launch(uri.toString());
  //     // } else {
  //     // throw 'Could not launch ${uri.toString()}';
  //     // }
  //   }catch(e){
  //     throw "Could not launch "+e.toString();
  //   }
  //   // try(){}catch(e){
  //   //
  //   // }
  //
  // }
  //
  // Future<Position> _handleLocationPermission() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     await Geolocator.openLocationSettings();
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text('Location services are disabled. Please enable the services')));
  //     //return false;
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Location permissions are denied')));
  //       //return false;
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text('Location permissions are permanently denied, we cannot request permissions.')));
  //     //return false;
  //   }
  //   return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  // }
  //
  // double distanceArea(double lat1,double lat2,double lang1,double lang2)
  // {
  //   double area=0.0;
  //   double earthRadius=6371.0;
  //   setState(() {
  //     area =
  //         (acos((sin(radians(lat1))
  //             * sin(radians(lat2)))
  //             + (cos(radians(lat1)) * cos(radians(lat2)))
  //                 * cos(radians(lang2) - radians(lang1)))) *  earthRadius;
  //     // print(acos(sin(lat1)*sin(lat2)));
  //     // print(cos(lat1) * cos(lat2));
  //     // print(cos(sin(lang1) - sin(lang2)) );
  //   });
  //
  //
  //   return area * 1000;
  //
  // }

}
