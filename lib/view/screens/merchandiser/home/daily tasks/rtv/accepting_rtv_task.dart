

import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/rtv/rtv_screen.dart';
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
import '../../../merch_nav_bar.dart';


  class AndroidAcceptingRtv extends StatefulWidget {


  final int id, phone,managerPhone;
  final String userName, manegerName,market, branch,
  profileImage, marketImage,
  nationality;
  //marketDetails;
  final NewAllTask rtvTask;
  final List<String> conditionList;
  const AndroidAcceptingRtv(
  {super.key,
   required this.manegerName,
  required this.managerPhone,
  required this.userName,
  required this.market,
  required this.branch,
  required this.profileImage,
  required this.marketImage,
  required this.id,
  required this.phone,
  required this.nationality,
  //required this.marketDetails,
  required this.rtvTask, required this.conditionList
  });

  @override
  State<AndroidAcceptingRtv> createState() => _AndroidAcceptingRtvState();
  }

  class _AndroidAcceptingRtvState extends State<AndroidAcceptingRtv> {
  // const ({Key? key}) : super(key: key);
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
                                          style: const TextStyle(fontSize: 10,color: Colors.black87),
                                        )),
                                    DataColumn(
                                        label: Text(
                                          "",
                                          style: const TextStyle(fontSize: 10,color: Colors.black87),
                                        )),
                                  ], rows: [
                                    if(workingOnRtv.length>0)
                                      DataRow(cells: <DataCell>[
                                        DataCell(Text(
                                          'RTV Section'.tr.toUpperCase(),
                                          style: const TextStyle(fontSize: 10,color: Colors.black87),
                                        )),
                                        DataCell(Text(
                                          '${''}',
                                          style: const TextStyle(fontSize: 10,color: Colors.black87),
                                        )),
                                      ]),
                                    if(workingOnInventory.length>0)
                                      DataRow(cells: <DataCell>[
                                        DataCell(Text(
                                          'Inventory'.tr.toUpperCase(),
                                          style: const TextStyle(fontSize: 10,color: Colors.black87),
                                        )),
                                        DataCell(Text(
                                          '${''}',
                                          style: const TextStyle(fontSize: 10,color: Colors.black87),
                                        )),
                                      ]),
                                    if(workingOnAvailability.length>0)
                                      DataRow(cells: <DataCell>[
                                        DataCell(Text(
                                          'Availability'.tr.toUpperCase(),
                                          style: const TextStyle(fontSize: 10,color: Colors.black87),
                                        )),
                                        DataCell(Text(
                                          '${''}',
                                          style: const TextStyle(fontSize: 10,color: Colors.black87),
                                        )),
                                      ]),
                                    if(workingOnShare.length>0)
                                      DataRow(cells: <DataCell>[
                                        DataCell(Text(
                                          'Share Of Shelves'.tr.toUpperCase(),
                                          style: const TextStyle(fontSize: 10,color: Colors.black87),
                                        )),
                                        DataCell(Text(
                                          '${''}',
                                          style: const TextStyle(fontSize: 10,color: Colors.black87),
                                        )),
                                      ]),
                                    if(workingOnOffers.length>0)
                                      DataRow(cells: <DataCell>[
                                        DataCell(Text(
                                          'Pricing'.tr.toUpperCase(),
                                          style: const TextStyle(fontSize: 10,color: Colors.black87),
                                        )),
                                        DataCell(Text(
                                          '${''}',
                                          style: const TextStyle(fontSize: 10,color: Colors.black87),
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
                          color:Colors.white,
                          border: Border.all(
                              color: Colors.black,
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
            icon: Icon(Icons.menu,color: Colors.white,),
            onPressed: (){
              Get.defaultDialog(
                  title: "",
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
      body:
      Column(
        children: <Widget>[
      Padding(
        padding:  EdgeInsets.only(left:10.w,right: 10.w,bottom: 5.h,top: 15.h),
        child: Container(
          padding:const EdgeInsets.all(10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
              border: Border.all()
          ),
          width: 350.h,
          height: 440.w,
          child: DataTable(
            columns: [
              DataColumn(label: Text('Branch'.tr)),
              DataColumn(label: Text(widget.rtvTask.branch.tr)),
            ],
            rows: [
              DataRow(cells: <DataCell>[
                DataCell(Text('Market'.tr)),
                DataCell(Text(widget.rtvTask.market.tr)),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text('Task'.tr)),
                DataCell(Text("RTV Section".tr)),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text(
                  'Order By'.tr,
                )),
                DataCell(Text(
                  widget.rtvTask.madeBy,
                )),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text('Task Date'.tr)),
                DataCell(Text(
    DateFormat('yyyy-MM-dd')
        .format(
                    widget.rtvTask.date))),
              ]),

              // for(int i=0;i<widget.rtvTask.display.length;i++)
              DataRow(cells: <DataCell>[
                DataCell(Text('Place'.tr)),
                DataCell(
                    Text(
                        widget.rtvTask.place.tr
                    )),
              ]),

              DataRow(cells: <DataCell>[
                DataCell(Text('Details'.tr)),
                DataCell(
                    Text(
                        widget.rtvTask.details.tr
                    )),
              ]),
            ],
          ),
        ),
      ),

      //SizedBox(height: 130.h,),
      if(widget.rtvTask.status=="run")
    //  (widget.rtvTask.status=="not yet"))?
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
                (      widget.rtvTask.date
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
              if(workingOnRtv.length==0)
              {
                workingOnRtv.add("RTV");
              }
             // updateData();
             // updateMerchaData();
            });

            Get.to(() =>
                RtvSectionScreen(
                  category: "All Categories",
                  place: widget.rtvTask.place,
                  manegerName:widget.manegerName,
                  managerPhone: widget.managerPhone,
                  nationality: widget.nationality,
                  orderBy: widget.rtvTask.madeBy,
                  taskType: "New Task",
                  branch: widget.rtvTask.branch,
                  market: widget.rtvTask.market,
                  userName: widget.userName,
                  id: widget.id,
                  phone: widget.phone,
                  marketImage: widget.marketImage,
                  profileImage: widget.profileImage,
                ));

          }
        },
        child: DefualtButton(selected: false,
          text:// (widget.rtvTask.status == "not yet")?
          'New Task'.tr,
        ),
      ),
    ),
      ]),
      bottomNavigationBar:
      Padding(
          padding:  EdgeInsets.only(left:10.w,right: 10.w,bottom: 5.h),
          child:((widget.rtvTask.status=="not yet"))? InkWell(

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
                    (      widget.rtvTask.date
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
              if(workingOnRtv.length==0)
              {
                workingOnRtv.add("RTV");
              }
              updateData();
              updateMerchaData();
            });

            Get.to(() =>
                RtvSectionScreen(
                  category: "All Categories",
                  place: widget.rtvTask.place,
                  manegerName:widget.manegerName,
                  managerPhone: widget.managerPhone,
                  nationality: widget.nationality,
                  orderBy: widget.rtvTask.madeBy,
                  taskType: "New Task",
                  branch: widget.rtvTask.branch,
                  market: widget.rtvTask.market,
                  userName: widget.userName,
                  id: widget.id,
                  phone: widget.phone,
                  marketImage: widget.marketImage,
                  profileImage: widget.profileImage,
                ));

          }

        },
        child: DefualtButton(selected: true,
            text:// (widget.rtvTask.status == "not yet")?
            'Start'.tr,
                //:'Continue'.tr,

        ),
    //  )
      ):


      InkWell(
        onTap: () {
          Navigator.of(context).pop();
          // if(completeTasks.length!=0) {
          setState(() {
            completeRtvTasks.add(widget.rtvTask.place);
           // workingOnInventory = [];
            updateMerchaFinishData();
            updateDatatoFinish();
          });
          Get.offAll(() =>
              MerchNavBar(
                  tab_index: 1,
                  manegerName: widget.manegerName,
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
        child: DefualtButton( selected:  true,text: 'Confirm'.tr),
      ),
      )
    );

  }


  Future updateData() async {
  var user = await FirebaseFirestore.instance
      .collection("New Tasks")
      .where("merchandiser",isEqualTo: widget.userName)
      .where("market", isEqualTo: widget.rtvTask.market)
      .where("place", isEqualTo:widget.rtvTask.place)
      .where("made_by", isEqualTo: widget.rtvTask.madeBy)
      .where('index', isEqualTo: widget.rtvTask.taskIndex)
      .where("branch", isEqualTo: widget.rtvTask.branch)
      .where("details", isEqualTo: widget.rtvTask.details)
      .where("title",isEqualTo: widget.rtvTask.title )
      .where("status", isEqualTo: "not yet")
      .get();
  if (user.docs.isNotEmpty) {
  var doc_Id = user.docs.first.id;
  await FirebaseFirestore.instance
      .collection("New Tasks")
      .doc(doc_Id)
      .update({"status": "run"});;
  print("Updated");

  }
  }

 Future updateDatatoFinish() async {
   var user = await FirebaseFirestore.instance
       .collection("New Tasks")
       .where("merchandiser",isEqualTo: widget.userName)
       .where("market", isEqualTo: widget.rtvTask.market)
       .where("place", isEqualTo:widget.rtvTask.place)
       .where("made_by", isEqualTo: widget.rtvTask.madeBy)
       .where('index', isEqualTo: widget.rtvTask.taskIndex)
       .where("branch", isEqualTo: widget.rtvTask.branch)
       .where("details", isEqualTo: widget.rtvTask.details)
       .where("title",isEqualTo: widget.rtvTask.title )
       .where('status', isEqualTo: 'run')
       .get();
   if (user.docs.isNotEmpty) {
     var doc_Id = user.docs.first.id;
     await FirebaseFirestore.instance
         .collection("New Tasks")
         .doc(doc_Id)
         .update({"status": "done"});
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
          .update({"status": "Working On RTV"});

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
          .update({"status": "Finish RTV"});

      print("Success");
      //   print(doc_Id);
    }
  }


  }


