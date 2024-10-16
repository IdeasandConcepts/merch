
import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/invintory/inventory_screen.dart';
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


class AndroidAcceptingInventory extends StatefulWidget {
  final int id, phone,managerPhone;
  final String profileImage;
  final String marketImage, name,
      manegerName,
      nationality;
  //marketDetails;
  final String market, branch;
  final NewAllTask inventoryTask;
  //final List<String> conditionList;

  const AndroidAcceptingInventory({
    super.key,
    required this.managerPhone,
    required this.profileImage,
    required this.branch,
    required this.marketImage,
    required this.name,
    required this.manegerName,
    //required this.product,
    required this.id,
    required this.phone,
    required this.nationality,
   // required this.marketDetails,
    required this.market,
    //required this.product,
    required this.inventoryTask,
    //required this.conditionList,
  });

  @override
  State<AndroidAcceptingInventory> createState() =>
      _AndroidAcceptingPricingTaskDetailsState();
}

String statusstr = "";

class _AndroidAcceptingPricingTaskDetailsState
    extends State<AndroidAcceptingInventory> {
 // bool switchVal = true;
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
                        name: widget.name
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
                      height: 450.w,
               child: DataTable(
                 columns: [
                   DataColumn(label: Text('Branch'.tr)),
                   DataColumn(label: GestureDetector(
                     onTap: (){
                       Get.defaultDialog(
                         title: "",
                         content: Text( widget.inventoryTask.branch.tr),
                       );
                     },
                     child: Text((widget.inventoryTask.branch.length<25)?
                     widget.inventoryTask.branch.tr:widget.inventoryTask.branch.tr.substring(0,23)+"..."),
                   )),
                 ],
                 rows: [
                   DataRow(cells: <DataCell>[
                     DataCell(Text('Market'.tr)),
                     DataCell(Text(widget.inventoryTask.market.tr)),
                   ]),
                   DataRow(cells: <DataCell>[
                     DataCell(Text('Task'.tr)),
                     DataCell(Text("Inventory".tr)),
                   ]),
                   DataRow(cells: <DataCell>[
                     DataCell(Text(
                       'Order By'.tr,
                     )),
                     DataCell(Text(
                       widget.inventoryTask.madeBy,
                     )),
                   ]),
                   DataRow(cells: <DataCell>[
                     DataCell(Text('Task Date'.tr)),
                     DataCell(Text(
                         DateFormat('yyyy-MM-dd')
                             .format(
                         widget.inventoryTask.date))),
                   ]),

                   // for(int i=0;i<widget.inventoryTask.display.length;i++)
                   DataRow(cells: <DataCell>[
                     DataCell(Text('Place'.tr)),
                     DataCell(
                         Text(
                             widget.inventoryTask.place.tr
                         )),
                   ]),

                   DataRow(cells: <DataCell>[
                     DataCell(Text('Details'.tr)),
                     DataCell(
                         Text(
                             widget.inventoryTask.details.tr
                         )),
                   ]),
                 ],
               ),
                          ),

              //SizedBox(height: 50.h,),

              if((widget.inventoryTask.status=="run"))GestureDetector(

                onTap: () {
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
                        (      widget.inventoryTask.date
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
                    //  if(widget.inventoryTask.display=="On Shelve") {
                    setState(() {
                      if(workingOnInventory.length==0) {
                        workingOnInventory.add("Inventory");
                      }
                      // Inventory
                      // updateData();
                      // updateMerchaData();
                    });

                    Get.to(() =>
                        InventoryScreen(
                          category: "All Categories",
                          place: widget.inventoryTask.place,
                          orderBy: widget.inventoryTask.madeBy,
                          taskType: "New Task",
                          managerName:widget.manegerName,
                          managerPhone: widget.managerPhone,
                          nationality: widget.nationality,
                          //marketDetails: widget.marketDetails,
                          branch: widget.inventoryTask.branch,
                          market: widget.inventoryTask.market,
                          username: widget.name,
                          id: widget.id,
                          phone: widget.phone,
                          marketImage: widget.marketImage,
                          profileImage: widget.profileImage,
                        ));

                  }
                  // Save Data ....
                },
                child: DefualtButton(selected: false,
                  text:'New Task'.tr,
                ),
              )
            ],
          ),
        ),
      bottomNavigationBar: (widget.inventoryTask.status=="not yet")?Padding(
        padding:  EdgeInsets.only(left:10.w,right: 10.w,bottom: 5.h),
        child: GestureDetector(
          onTap: () {
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
                  (      widget.inventoryTask.date
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
              //  if(widget.inventoryTask.display=="On Shelve") {
              setState(() {
                if(workingOnInventory.length==0)
                {
                  workingOnInventory.add("Inventory");
                }
                // Inventory
                updateData();
                updateMerchaData();
              });
              // print(
              // widget.inventoryTask.date);
              // Get.to(() =>
              //     InventoryScreen(
              //       place: widget.inventoryTask.place,
              //       orderBy: widget.inventoryTask.madeBy,
              //       taskType: "New Task",
              //       managerName:widget.manegerName,
              //       managerPhone: widget.managerPhone,
              //       nationality: widget.nationality,
              //       //marketDetails: widget.marketDetails,
              //       branch: widget.inventoryTask.branch,
              //       market: widget.inventoryTask.market,
              //       username: widget.name,
              //       id: widget.id,
              //       phone: widget.phone,
              //       marketImage: widget.marketImage,
              //       profileImage: widget.profileImage,
              //     ));

            }
            // Save Data ....
          },
          child: DefualtButton(selected: true,
            text:'Start'.tr,
          ),
        ),
      ):


      Padding(
        padding:  EdgeInsets.only(left:10.w,right: 10.w,bottom: 5.h),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            // if(completeTasks.length!=0) {
            setState(() {
              completeInventoryTasks.add(widget.inventoryTask.place);
              workingOnInventory = [];
              updateMerchaFinishData();
              updateDatatoFinish();
            });
            Get.offAll(() =>
                MerchNavBar(
                    tab_index: 1,
                    manegerName: widget.manegerName,
                    username: widget.name,
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
      ),
    );
  }
  @override
  updateMerchaFinishData() async {
    var user = await FirebaseFirestore.instance
        .collection('Merchandisers')
    //.where('branch', isEqualTo: widget.branch)
        .where('full_name', isEqualTo: widget.name)
    //.where('market', isEqualTo: widget.market)
        .where('id', isEqualTo: widget.id)

        .get();
    if (user.docs.isNotEmpty) {
      var doc_Id = user.docs.first.id;
      await FirebaseFirestore.instance
          .collection('Merchandisers')
          .doc(doc_Id)
          .update({"status": "Finish Inventory"});

      print("Success");
      //   print(doc_Id);
    }
  }

  @override
  updateData() async {
    var user = await FirebaseFirestore.instance
        .collection("New Tasks")
        .where("merchandiser",isEqualTo: widget.name)
        .where('market', isEqualTo: widget.inventoryTask.market)
        .where('place', isEqualTo:widget.inventoryTask.place)
        .where('made_by', isEqualTo: widget.inventoryTask.madeBy)
        .where('index', isEqualTo: widget.inventoryTask.taskIndex)
        .where('branch', isEqualTo: widget.inventoryTask.branch)
        .where('details', isEqualTo: widget.inventoryTask.details)
        .where('title', isEqualTo: widget.inventoryTask.title)
        .where('status', isEqualTo: 'not yet')
        .get();
    if (user.docs.isNotEmpty) {
      var doc_Id = user.docs.first.id;
      await FirebaseFirestore.instance
          .collection("New Tasks")
          .doc(doc_Id)
          .update({"status": "run"});
      updateMerchaData();

       print("fail");
    }
  }
  updateMerchaData() async {
    var user = await FirebaseFirestore.instance
        .collection('Merchandisers')
    // .where('branch', isEqualTo: widget.branch)
        .where('full_name', isEqualTo: widget.name)
    //.where('market', isEqualTo: widget.market)
        .where('id', isEqualTo: widget.id)

        .get();
    if (user.docs.isNotEmpty) {
      var doc_Id = user.docs.first.id;
      await FirebaseFirestore.instance
          .collection('Merchandisers')
          .doc(doc_Id)
          .update({"status": "Working Inventory".tr});

      //   print(doc_Id);
    }
  }
  @override
  updateDatatoFinish() async {
    var user = await FirebaseFirestore.instance
        .collection("New Tasks")
        .where("merchandiser",isEqualTo: widget.name)
        .where('market', isEqualTo: widget.inventoryTask.market)
        .where('place', isEqualTo:widget.inventoryTask.place)
        .where('made_by', isEqualTo: widget.inventoryTask.madeBy)
        .where('index', isEqualTo: widget.inventoryTask.taskIndex)
        .where('branch', isEqualTo: widget.inventoryTask.branch)
        .where('details', isEqualTo: widget.inventoryTask.details)
        .where('title', isEqualTo: widget.inventoryTask.title)
        .where('status', isEqualTo: 'run')
        .get();
    if (user.docs.isNotEmpty) {
      var doc_Id = user.docs.first.id;
      await FirebaseFirestore.instance
          .collection("New Tasks")
          .doc(doc_Id)
          .update({"status": "done"});

      //statusstr = "done";
      print(doc_Id);
    }
    updateMerchaDataToDone('Inventory');

  }

  updateMerchaDataToDone(String task) async {
    var user = await FirebaseFirestore.instance
        .collection('Merchandisers')
    // .where('branch', isEqualTo: widget.branch)
        .where('full_name', isEqualTo: widget.name)
    //.where('market', isEqualTo: widget.market)
        .where('id', isEqualTo: widget.id)

        .get();
    if (user.docs.isNotEmpty) {
      var doc_Id = user.docs.first.id;
      await FirebaseFirestore.instance
          .collection('Merchandisers')
          .doc(doc_Id)
          .update({"status": "finished Inventory Task"});

      //   print(doc_Id);
    }
  }
}
