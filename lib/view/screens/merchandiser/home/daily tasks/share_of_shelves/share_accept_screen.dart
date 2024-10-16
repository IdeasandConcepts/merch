
import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/share_of_shelves/share_screen.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/profile/profile_screen.dart';
import 'package:arrow_merchandising/models/ai_planogram_model.dart';
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


class AcceptingShareOfShelfScreen extends StatefulWidget {
  final int id, phone,managerPhone;
  final String profileImage;
  final String marketImage, name,
      managerName,
      nationality;
  //marketDetails;
  //product;
  final String market, title, branch;
  final NewAllTask merchShareOfShellTask;
  final List<String> conditionList;

  const AcceptingShareOfShelfScreen(
      {super.key,
        required this.id,
        required this.phone,
        required this.profileImage,
        required this.marketImage,
        required this.name,
        required this.managerPhone,
        required this.nationality,
        required this.managerName,
        required this.market,
        required this.title,
        required this.branch,
        required this.merchShareOfShellTask,
        required this.conditionList});

  @override
  State<AcceptingShareOfShelfScreen> createState() =>
      _AcceptingShareOfShelfScreenState();
}

class _AcceptingShareOfShelfScreenState
    extends State<AcceptingShareOfShelfScreen> {
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
                ||
                workingOnPlanogramTasks.length>0
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
              //padding: EdgeInsets.all(10.h),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                  border: Border.all()
              ),
              width: 350.h,
              height: 440.w,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Branch'.tr)),
                  DataColumn(label: Text(widget.merchShareOfShellTask.branch.tr)),
                ],
                rows: [
                  DataRow(cells: <DataCell>[
                    DataCell(Text('Market'.tr)),
                    DataCell(Text(widget.merchShareOfShellTask.market.tr)),
                  ]),
                  DataRow(cells: <DataCell>[
                    DataCell(Text('Task'.tr)),
                    DataCell(Text("Shelf Share".tr)),
                  ]),
                  DataRow(cells: <DataCell>[
                    DataCell(Text(
                      'Order By'.tr,
                    )),
                    DataCell(Text(
                      widget.merchShareOfShellTask.madeBy,
                    )),
                  ]),
                  DataRow(cells: <DataCell>[
                    DataCell(Text('Task Date'.tr)),
                    DataCell(Text(
                        DateFormat('yyyy-MM-dd')
                            .format(
                        widget.merchShareOfShellTask.date))),
                  ]),

                  // for(int i=0;i<widget.merchShareOfShellTask.display.length;i++)
                  DataRow(cells: <DataCell>[
                    DataCell(Text('Place'.tr)),
                    DataCell(
                        Text(
                            widget.merchShareOfShellTask.place.tr
                        )),
                  ]),

                  DataRow(cells: <DataCell>[
                    DataCell(Text('Details'.tr)),
                    DataCell(
                        Text(
                            widget.merchShareOfShellTask.details.tr
                        )),
                  ]),
                ],
              ),
            ),
            if(widget.merchShareOfShellTask.status=="run")
              InkWell(
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
                        (      widget.merchShareOfShellTask.date
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
                    //  if(widget.merchShareOfShellTask.display=="On Shelve") {
                    setState(() {
                      if(workingOnShare.length==0) {
                        workingOnShare.add(widget.merchShareOfShellTask.place);
                      }
                      // Inventory
                      updateData();
                      updateMerchaData();
                    });

                    Get.to(() =>
                        ShareOfShelfScreen(
                          taskType: "Daily Task",
                          place: widget.merchShareOfShellTask.place,
                          managerName:widget.managerName,
                          adminPhone: widget.managerPhone,
                          nationality: widget.nationality,
                          orderBy: widget.merchShareOfShellTask.madeBy,
                          branch: widget.merchShareOfShellTask.branch,
                          market: widget.merchShareOfShellTask.market,
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
      bottomNavigationBar: ((widget.merchShareOfShellTask.status=="not yet"))?
        Padding(
          padding:  EdgeInsets.only(left:10.w,right: 10.w,bottom: 5.h),
          child: InkWell(
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
                    (      widget.merchShareOfShellTask.date
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
                //  if(widget.merchShareOfShellTask.display=="On Shelve") {
                setState(() {
                  if(workingOnShare.length==0) {
                    workingOnShare.add(widget.merchShareOfShellTask.place);
                  }
                  // Inventory
                  updateData();
                  updateMerchaData();
                });

                Get.to(() =>
                    ShareOfShelfScreen(
                      taskType: "Daily Task",
                      place: widget.merchShareOfShellTask.place,
                      managerName:widget.managerName,
                      adminPhone: widget.managerPhone,
                      nationality: widget.nationality,
                      orderBy: widget.merchShareOfShellTask.madeBy,
                      branch: widget.merchShareOfShellTask.branch,
                      market: widget.merchShareOfShellTask.market,
                      username: widget.name,
                      id: widget.id,
                      phone: widget.phone,
                      marketImage: widget.marketImage,
                      profileImage: widget.profileImage,
                    ));

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
        child: InkWell(
          onTap: () {
            Navigator.of(context).pop();
            // if(completeTasks.length!=0) {
            setState(() {
              completeShareTasks.add(widget.merchShareOfShellTask.place);
              workingOnShare = [];

              updateDatatoFinish();
            });
            Get.offAll(() =>
                MerchNavBar(
                    tab_index: 1,
                    manegerName: widget.managerName,
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
  updateData() async {
    var user = await FirebaseFirestore.instance
        .collection('New Tasks')
        .where("merchandiser",isEqualTo: widget.name,)
        .where('market', isEqualTo: widget.merchShareOfShellTask.market)
        .where('place', isEqualTo:widget.merchShareOfShellTask.place)
        .where('made_by', isEqualTo: widget.merchShareOfShellTask.madeBy)
        .where('index', isEqualTo: widget.merchShareOfShellTask.taskIndex)
        .where('branch', isEqualTo: widget.merchShareOfShellTask.branch)
        .where('details', isEqualTo: widget.merchShareOfShellTask.details)
        .where('title', isEqualTo: widget.merchShareOfShellTask.title)

        .where('status', isEqualTo: 'not yet')
        .get();
    if (user.docs.isNotEmpty) {
      var doc_Id = user.docs.first.id;
      await FirebaseFirestore.instance
          .collection('New Tasks')
          .doc(doc_Id)
          .update({"status": "run"});

      //   print(doc_Id);
    }
  }
  //
  //
  @override
  updateDatatoFinish() async {
    var user = await FirebaseFirestore.instance
        .collection('New Tasks')
        .where("merchandiser",isEqualTo :widget.name)
        .where('market', isEqualTo: widget.merchShareOfShellTask.market)
        .where('place', isEqualTo:widget.merchShareOfShellTask.place)
        .where('made_by', isEqualTo: widget.merchShareOfShellTask.madeBy)
        .where('index', isEqualTo: widget.merchShareOfShellTask.taskIndex)
        .where('branch', isEqualTo: widget.merchShareOfShellTask.branch)
        .where('details', isEqualTo: widget.merchShareOfShellTask.details)
        .where('title', isEqualTo: widget.merchShareOfShellTask.title)
        .where('status', isEqualTo: 'run')
        .get();
    if (user.docs.isNotEmpty) {
      var doc_Id = user.docs.first.id;
      await FirebaseFirestore.instance
          .collection('New Tasks')
          .doc(doc_Id)
          .update({"status": "done"});

      print(doc_Id);
    }
  }

  @override
  updateMerchaData() async {
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
          .update({"status": "Working On Share Of Shelves"});

      print("Success");
      //   print(doc_Id);
    }
  }

  @override
  updateMerchaFininshData() async {
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
          .update({"status": "Complete Share Of Shelves"});

      print("Success");
      //   print(doc_Id);
    }
  }

}
