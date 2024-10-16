
import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/planogram/planogram_screen.dart';
import 'package:arrow_merchandising/models/ai_planogram_model.dart';
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

class AndroidAcceptingPlonogramTaskDetails extends StatefulWidget {

final NewAllTask merchPlanogramModel;
  final int id, phone,managerPhone;
  final String profileImage;
  final String marketImage,
      userName,
      manegerName,
      nationality,
      //marketDetails,
      branch,
      market;

  const AndroidAcceptingPlonogramTaskDetails({
    super.key,
    required this.managerPhone,
    required this.branch,
    required this.profileImage,
    required this.marketImage,
    required this.userName,
    required this.id,
    required this.phone,
    required this.nationality,
    required this.manegerName,
    required this.market,
    required this.merchPlanogramModel,

  });

  @override
  State<AndroidAcceptingPlonogramTaskDetails> createState() =>
      _AndroidAcceptingPlonogramTaskDetailsState();
}

class _AndroidAcceptingPlonogramTaskDetailsState
    extends State<AndroidAcceptingPlonogramTaskDetails> {
  // String secondImage='';
  //
  // File? imagepath;
  //
  // final imagePicker = ImagePicker();
  //
  // Future getimage() async {
  //   final image = await imagePicker.pickImage(source: ImageSource.camera);
  //   // await ImagePicker.getImage(
  //   //   source: ImageSource.camera);
  //   setState(() {
  //     imagepath = File(image!.path);
  //     FirebaseStorage.instance
  //         .ref()
  //         .child('planogram/secondImage'+DateTime.now().toString()+'.png')
  //         .putFile(imagepath!)
  //         .then((TaskSnapshot taskSnapshot) {
  //       if (taskSnapshot.state == TaskState.success) {
  //         print("Image uploaded Successful");
  //         // Get Image URL Now
  //         taskSnapshot.ref.getDownloadURL().then((imageURL) {
  //           setState(() {
  //             secondImage = imageURL.toString();
  //           });
  //           // firstphotopath = imageURL.toString();
  //           print("Image Download URL is $secondImage");
  //           //return pathString;
  //         });
  //       } else if (taskSnapshot.state == TaskState.running) {
  //         // Show Prgress indicator
  //       } else if (taskSnapshot.state == TaskState.error) {
  //         // Handle Error Here
  //         // print("Error in $TaskState.error");
  //       }
  //     });
  //
  //   });
  // }
  // double matchdegree=0.0 ,defrencedegree=0.0;
  //
  // PlatformFile? pickedFile;
  //
  // Future selectFile() async {
  //   final photo = await FilePicker.platform.pickFiles();
  //   if (photo == null) return;
  //   setState(() {
  //     pickedFile = photo.files.first;
  //     FirebaseStorage.instance
  //         .ref()
  //         .child('planogram/secondImage'+DateTime.now().toString()+'.png')
  //         .putFile(imagepath!)
  //         .then((TaskSnapshot taskSnapshot) {
  //       if (taskSnapshot.state == TaskState.success) {
  //         print("Image uploaded Successful");
  //         // Get Image URL Now
  //         taskSnapshot.ref.getDownloadURL().then((imageURL) {
  //           setState(() {
  //             secondImage = imageURL.toString();
  //           });
  //           // firstphotopath = imageURL.toString();
  //           print("Image Download URL is $secondImage");
  //           //return pathString;
  //         });
  //       } else if (taskSnapshot.state == TaskState.running) {
  //         // Show Prgress indicator
  //       } else if (taskSnapshot.state == TaskState.error) {
  //         // Handle Error Here
  //         // print("Error in $TaskState.error");
  //       }
  //     });
  //
  //     //imagepath = photo.files.first as File?;
  //   });
  // }
  //
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
                      name: widget.userName
                  ));
            },
          )
      ),

      //appBar: AppBar(),
      body: Padding(
        padding:  EdgeInsets.only(left:10.w,right: 10.w,bottom: 5.h,top: 10.h),
        child: Column(
          children: [
            Container(
              //padding:const EdgeInsets.all(10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                  border: Border.all()
              ),
              width: 350.h,
              height: 440.w,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Branch'.tr)),
                  DataColumn(label: Text(widget.merchPlanogramModel.branch.tr)),
                ],
                rows: [
                  DataRow(cells: <DataCell>[
                    DataCell(Text('Market'.tr)),
                    DataCell(Text(widget.merchPlanogramModel.market.tr)),
                  ]),
                  DataRow(cells: <DataCell>[
                    DataCell(Text('Task'.tr)),
                    DataCell(Text("Planogram".tr)),
                  ]),
                  DataRow(cells: <DataCell>[
                    DataCell(Text(
                      'Order By'.tr,
                    )),
                    DataCell(Text(
                      widget.merchPlanogramModel.madeBy,
                    )),
                  ]),
                  DataRow(cells: <DataCell>[
                    DataCell(Text('Task Date'.tr)),
                    DataCell(Text(

                        DateFormat('yyyy-MM-dd')
                            .format(
                            widget.merchPlanogramModel.date))),
                  ]),

                  // for(int i=0;i<widget.merchPlanogramModel.display.length;i++)
                  DataRow(cells: <DataCell>[
                    DataCell(Text('Place'.tr)),
                    DataCell(
                        Text(
                            widget.merchPlanogramModel.place.tr
                        )),
                  ]),

                  DataRow(cells: <DataCell>[
                    DataCell(Text('Details'.tr)),
                    DataCell(
                        Text(
                            widget.merchPlanogramModel.details.tr
                        )),
                  ]),
                ],
              ),
            ),
            if(widget.merchPlanogramModel.status=="run")InkWell(

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
              (      widget.merchPlanogramModel.date
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
          //  if(widget.merchPlanogramModel.display=="On Shelve") {
          setState(() {
            if(workingOnPlanogramTasks.length==0) {
              workingOnPlanogramTasks.add(widget.merchPlanogramModel.status);
            }
            // Inventory
            updateData();
            // updateMerchaData();
          });

          Get.to(() =>
              PlanogramAI(
                taskType: "New Task",
                place: widget.merchPlanogramModel.place,
                orderBy: widget.merchPlanogramModel.madeBy,
                managerName:widget.manegerName,
                adminPhone: widget.managerPhone,
                nationality: widget.nationality,
                //marketDetails: widget.marketDetails,
                branch: widget.merchPlanogramModel.branch,
                market: widget.merchPlanogramModel.market,
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
        text:'NewTask'.tr,
      ),
    ),
          ],
        ),
      ),
      bottomNavigationBar:  Padding(
          padding:  EdgeInsets.only(left:10.w,right: 10.w,bottom: 5.h),
        child: (widget.merchPlanogramModel.status=="not yet")?InkWell(

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
                  (      widget.merchPlanogramModel.date
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
              //  if(widget.merchPlanogramModel.display=="On Shelve") {
              setState(() {
                if(workingOnPlanogramTasks.length==0) {
                  workingOnPlanogramTasks.add(widget.merchPlanogramModel.place);
                }
                // Inventory
                updateData();
                updateDataToFinish();
              });

              Get.to(() =>
                  PlanogramAI(
                    taskType: "New Task",
                    place: widget.merchPlanogramModel.place,
                    managerName:widget.manegerName,
                    adminPhone: widget.managerPhone,
                    nationality: widget.nationality,
                    orderBy: widget.merchPlanogramModel.madeBy,
                    branch: widget.merchPlanogramModel.branch,
                    market: widget.merchPlanogramModel.market,
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
            text: 'start'.tr,
          ),
       // ),
      ):


      InkWell(
        onTap: () {
          Navigator.of(context).pop();
          // if(completeTasks.length!=0) {
          setState(() {
            // completemerchPlanogramModels.add(widget.merchPlanogramModel.display);
            // wor = [];
            // updateMerchaFinishData();

          //  if(completeOffersTasks.length>0) {

              workingOnPlanogramTasks=[];
              updateDataToFinish();
              updateMerchaFinishData();
           // }
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
      )  ),
    );
  }



  @override
  Future updateData() async {
    var user = await FirebaseFirestore.instance
        .collection('New Tasks')
        .where("merchandiser",isEqualTo: widget.userName)
        .where('market', isEqualTo: widget.merchPlanogramModel.market)
        .where('place', isEqualTo:widget.merchPlanogramModel.place)
        .where('made_by', isEqualTo: widget.merchPlanogramModel.madeBy)
        .where('index', isEqualTo: widget.merchPlanogramModel.taskIndex)
        .where('branch', isEqualTo: widget.merchPlanogramModel.branch)
        .where('details', isEqualTo: widget.merchPlanogramModel.details)
        .where('title', isEqualTo: widget.merchPlanogramModel.title)
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

  }  @override
  Future updateDataToFinish() async {
    var user = await FirebaseFirestore.instance
        .collection('New Tasks')
        .where("merchandiser",isEqualTo: widget.userName)
        .where('market', isEqualTo: widget.merchPlanogramModel.market)
        .where('place', isEqualTo:widget.merchPlanogramModel.place)
        .where('made_by', isEqualTo: widget.merchPlanogramModel.madeBy)
        .where('index', isEqualTo: widget.merchPlanogramModel.taskIndex)
        .where('branch', isEqualTo: widget.merchPlanogramModel.branch)
        .where('details', isEqualTo: widget.merchPlanogramModel.details)
        .where('title', isEqualTo: widget.merchPlanogramModel.title)
        .where('status', isEqualTo: 'run')
        .get();
    if (user.docs.isNotEmpty) {
      var doc_Id = user.docs.first.id;
      await FirebaseFirestore.instance
          .collection('New Tasks')
          .doc(doc_Id)
          .update({"status": "done"});

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
          .update({"status": "Working On Planogram"});

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
          .update({"status": "Finish Planogram Task"});

      print("Success");
      //   print(doc_Id);
    }
  }
}
