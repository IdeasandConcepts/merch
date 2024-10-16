
import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/pricing/offers.dart';
import 'package:arrow_merchandising/models/inventory_products.dart';
import 'package:arrow_merchandising/models/new_task.dart';
import 'package:arrow_merchandising/models/pricing_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:arrow_merchandising/const.dart';
import '../../../merch_nav_bar.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/profile/profile_screen.dart';
import 'package:arrow_merchandising/models/availability_products.dart';
import 'package:arrow_merchandising/models/rtv_product.dart';
import 'package:arrow_merchandising/models/share_products.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AndroidAcceptingOffers extends StatefulWidget {

  final int id, phone,managerPhone;
  final String merchandiserName,manegerName, market, branch,
      profileImage, marketImage,
      nationality;
  final NewAllTask offersTaskModel;
  final List<String> conditionList;
  const AndroidAcceptingOffers(
      {super.key,
        // required this.product,
        required this.managerPhone,
        required this.merchandiserName,
        required this.market,
        required this.branch,
        required this.profileImage,
        required this.marketImage,
        required this.id,
        required this.phone,
        required this.nationality,
        required this.manegerName,
        required this.offersTaskModel,
        required this.conditionList
      });

  @override
  State<AndroidAcceptingOffers> createState() => _AndroidAcceptingOffersState();
}

class _AndroidAcceptingOffersState extends State<AndroidAcceptingOffers> {
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
                      name: widget.merchandiserName
                  ));
            },
          )
      ),

      //appBar: AppBar(),
      body: Padding(
        padding:  EdgeInsets.all(20.h ),
        child:
        Column(
    children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.h),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
              border: Border.all()
          ),
          width: 350.h,
          height: 440.w,
          child: DataTable(
            columns: [
              DataColumn(label: Text('Branch'.tr)),
              DataColumn(label: Text(widget.offersTaskModel.branch.tr)),
            ],
            rows: [
              DataRow(cells: <DataCell>[
                DataCell(Text('Market'.tr)),
                DataCell(Text(widget.offersTaskModel.market.tr)),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text('Task'.tr)),
                DataCell(Text("Offers".tr)),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text(
                  'Order By'.tr,
                )),
                DataCell(Text(
                  widget.offersTaskModel.madeBy,
                )),
              ]),
              DataRow(cells: <DataCell>[
                DataCell(Text('Task Date'.tr)),
                DataCell(Text(
                    DateFormat('yyyy-MM-dd')
                        .format(
                    widget.offersTaskModel.date))),
              ]),

              // for(int i=0;i<widget.pricingTaskModel.display.length;i++)
              DataRow(cells: <DataCell>[
                DataCell(Text('Place'.tr)),
                DataCell(
                    Text(
                        widget.offersTaskModel.place.tr
                    )),
              ]),

              DataRow(cells: <DataCell>[
                DataCell(Text('Details'.tr)),
                DataCell(
                    Text(
                        widget.offersTaskModel.details.tr
                    )),
              ]),
            ],
          ),
        ),
      if((widget.offersTaskModel.status=="run"))InkWell(

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
                (      widget.offersTaskModel.date
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
              if(workingOnOffers.length==0) {
                workingOnOffers.add("Offers");
              }
              // Inventory
              updateData();
              updateMerchaData();
            });

            Get.to(() =>
                Offers(
                  taskType: "New Task",
                  place: widget.offersTaskModel.place,
                  managerName:widget.manegerName,
                  adminPhone: widget.managerPhone,
                  nationality: widget.nationality,
                  orderBy: widget.offersTaskModel.madeBy,
                  branch: widget.offersTaskModel.branch,
                  market: widget.offersTaskModel.market,
                  username: widget.merchandiserName,
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
    //  ]
      //  )
    //  ),
      bottomNavigationBar:Padding(
        padding:  EdgeInsets.only(left:10.w,right: 10.w,bottom: 5.h),
        child:
        ((widget.offersTaskModel.status=="not yet"))? InkWell(
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
                  (      widget.offersTaskModel.date
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
            //  if(widget.pricingTaskModel.display=="On Shelve") {
            setState(() {
              if(workingOnOffers.length==0) {
                workingOnOffers.add("Offers");
              }
              // Inventory
              updateData();
              updateMerchaData();
            });

            Get.to(() =>
                Offers(
                  taskType: "New Task",
                  place: widget.offersTaskModel.place,
                  managerName:widget.manegerName,
                  adminPhone: widget.managerPhone,
                  nationality: widget.nationality,
                 orderBy: widget.offersTaskModel.madeBy,
                  branch: widget.offersTaskModel.branch,
                  market: widget.offersTaskModel.market,
                  username: widget.merchandiserName,
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
      ):


      InkWell(
        onTap: () {
          Navigator.of(context).pop();
          // if(completeTasks.length!=0) {
          setState(() {
            completeOffersTasks.add(widget.offersTaskModel.place);
            workingOnOffers = [];
            //updateMerchaFinishData();
            updateDatatoFinish();
          });
          Get.offAll(() =>
              MerchNavBar(
                  tab_index: 1,
                  manegerName: widget.manegerName,
                  username: widget.merchandiserName,
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
      )  ),
    );

  }

  Future updateData() async {
    var user = await FirebaseFirestore.instance
        .collection("New Tasks")
        .where("merchandiser",isEqualTo: widget.merchandiserName)
        .where('market', isEqualTo: widget.offersTaskModel.market)
        .where('place', isEqualTo:widget.offersTaskModel.place)
        .where('made_by', isEqualTo: widget.offersTaskModel.madeBy)
        .where('index', isEqualTo: widget.offersTaskModel.taskIndex)
        .where('branch', isEqualTo: widget.offersTaskModel.branch)
        .where('details', isEqualTo: widget.offersTaskModel.details)
        .where('title', isEqualTo: widget.offersTaskModel.title)
        .where('status', isEqualTo: 'not yet')
        .get();
    if (user.docs.isNotEmpty) {
      var doc_Id = user.docs.first.id;
      await FirebaseFirestore.instance
          .collection("New Tasks")
          .doc(doc_Id)
          .update({"status": "run"});

      //   print(doc_Id);
    }

  }

  updateDatatoFinish() async {
    var user = await FirebaseFirestore.instance
        .collection("New Tasks")
        .where("merchandiser",isEqualTo: widget.merchandiserName)
        .where('market', isEqualTo: widget.offersTaskModel.market)
        .where('place', isEqualTo:widget.offersTaskModel.place)
        .where('made_by', isEqualTo: widget.offersTaskModel.madeBy)
        .where('index', isEqualTo: widget.offersTaskModel.taskIndex)
        .where('branch', isEqualTo: widget.offersTaskModel.branch)
        .where('details', isEqualTo: widget.offersTaskModel.details)
        .where('title', isEqualTo: widget.offersTaskModel.title)
        .where('status', isEqualTo: 'run')
        .get();
    if (user.docs.isNotEmpty) {
      var doc_Id = user.docs.first.id;
      await FirebaseFirestore.instance
          .collection("New Tasks")
          .doc(doc_Id)
          .update({"status": "done"});

      // statusstr = "done";
      print(doc_Id);
    }
  }





  @override
  updateMerchaData() async {
    var user = await FirebaseFirestore.instance
        .collection('Merchandisers')
    //.where('branch', isEqualTo: widget.branch)
        .where('full_name', isEqualTo: widget.merchandiserName)
    //.where('market', isEqualTo: widget.market)
        .where('id', isEqualTo: widget.id)

        .get();
    if (user.docs.isNotEmpty) {
      var doc_Id = user.docs.first.id;
      await FirebaseFirestore.instance
          .collection('Merchandisers')
          .doc(doc_Id)
          .update({"status": "Working On Offers"});

      print("Success");
      //   print(doc_Id);
    }
  }

  @override
  updateMerchaFininshData() async {
    var user = await FirebaseFirestore.instance
        .collection('Merchandisers')
    //.where('branch', isEqualTo: widget.branch)
        .where('full_name', isEqualTo: widget.merchandiserName)
    //.where('market', isEqualTo: widget.market)
        .where('id', isEqualTo: widget.id)

        .get();
    if (user.docs.isNotEmpty) {
      var doc_Id = user.docs.first.id;
      await FirebaseFirestore.instance
          .collection('Merchandisers')
          .doc(doc_Id)
          .update({"status": "Complete Offers"});

      print("Success");
      //   print(doc_Id);
    }
  }

}
