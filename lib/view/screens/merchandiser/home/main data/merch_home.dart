// import 'dart:convert';
// import 'dart:io';
//
// import 'package:arrow_merchandising/const.dart';
// import 'package:arrow_merchandising/models/availability_products.dart';
// import 'package:arrow_merchandising/models/inventory_products.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../splash/auth_page.dart';
// import '../../profile/merchandiser_container.dart';
// import '../task history/tasks_history.dart';
// import '../tasks list/tasks_list.dart';
// import 'daily_tasks.dart';
// import 'home_details.dart';
// import 'package:arrow_merchandising/models/pricing_product.dart';
// import 'package:arrow_merchandising/models/rtv_product.dart';
// import 'package:arrow_merchandising/models/share_products.dart';
// import 'package:http/http.dart' as http;
//
// class MerchandiserHome extends StatefulWidget {
//   final String username,
//       marketImage,
//       profileImage,
//       branch,
//       //city,
//       market,
//       //marketDetails,
//       nationality;
//   final int id, phone, mangerphone;
//   const MerchandiserHome(
//       {super.key,
//       required this.username,
//       required this.marketImage,
//       required this.profileImage,
//       required this.branch,
//       required this.market,
//       required this.id,
//       required this.phone,
//       //required this.marketDetails,
//       required this.nationality,
//       // required this.city,
//       required this.mangerphone});
//
//   @override
//   State<MerchandiserHome> createState() => _MerchandiserHomeState();
// }
//
// class _MerchandiserHomeState extends State<MerchandiserHome>
//     with TickerProviderStateMixin {
//   File? selectedImage;
//   var resJson;
//   List<T> jsonToList<T>(Object? responseData) {
//     final temp = responseData as List? ?? <dynamic>[];
//     final list = <T>[];
//     for (final tmp in temp) {
//       list.add(tmp as T);
//     }
//     return list;
//   }
//
//   void initState() {
//     // notYetList=widget.restedTasks+widget.completeTasks;
//     // createDailyTask();
//
//     // TODO: implement initState
//
//     setState(() {
//       getnotYet("New Rtv Tasks", rtvNotYetList);
//       getnotYet("New Inventory Tasks", inventoryNotYetList);
//       getnotYet("New Availability Tasks", availabilityNotYetList);
//       getListNotYet("New Share Of Shelves", shareNotYetList);
//       getListNotYet("New Pricing Tasks", pricingNotYetList);
//       notYetList = rtvNotYetList.length +
//           inventoryNotYetList.length +
//           availabilityNotYetList.length +
//           shareNotYetList.length +
//           pricingNotYetList.length;
//       newTasks = notYetList;
//       setState(() {
//         doneTasks = completeInventoryTasks.length +
//             completeAvailabilityTasks.length +
//             completePricingTasks.length +
//             completeRtvTasks.length;
//         restTasks = newTasks - doneTasks;
//       });
//     });
//     super.initState();
//   }
//
//   int notYetList = 0;
//
//   int newTasks = 0, doneTasks = 0, restTasks = 0;
//
//   Future refreshFun() async {
//     getnotYet("New Rtv Tasks", rtvNotYetList);
//     getnotYet("New Inventory Tasks", inventoryNotYetList);
//     getnotYet("New Availability Tasks", availabilityNotYetList);
//     getListNotYet("New Share Of Shelves", shareNotYetList);
//     getListNotYet("New Pricing Tasks", pricingNotYetList);
//     newTasks = notYetList;
//
//     final request =
//         await http.MultipartRequest("POST", Uri.parse("${urlApi}/upload"));
//     final headers = {"Content-type": "multipart/from-data"};
//     request.files.add(http.MultipartFile("image",
//         selectedImage!.readAsBytes().asStream(), selectedImage!.lengthSync(),
//         filename: selectedImage!.path.split("/").last));
//     request.headers.addAll(headers);
//     final response = await request.send();
//     http.Response res = await http.Response.fromStream(response);
//
//     // message = resJson['message'];
//     if (response.statusCode == 200) {
//       setState(() {
//         resJson = jsonToList(jsonDecode(res.body));
//         //progress=true;
//         //getId();
//       });
//
//       // data.add(resJson);
//
//       print("class is : $resJson ");
//     } else {
//       print("Error ${response.statusCode}");
//     }
//
//     setState(() {
//       doneTasks = completeInventoryTasks.length +
//           completeAvailabilityTasks.length +
//           completePricingTasks.length +
//           completeRtvTasks.length;
//       restTasks = newTasks - doneTasks;
//     });
//   }
//
//   List<String> pricingNotYetList = [],
//       rtvNotYetList = [],
//       shareNotYetList = [],
//       inventoryNotYetList = [],
//       availabilityNotYetList = [];
//   Future getListNotYet(String collection, List<String> array) async {
//     await FirebaseFirestore.instance
//         .collection(collection)
//         .where("merchandiser", whereIn: [widget.username, "Any Merchandiser"])
//         // .where("merchandiser",isEqualTo: widget.username,)
//         //.where("status", isEqualTo: taskCase)
//         .where('status', isEqualTo: "not yet")
//         .get()
//         .then((snapshot) {
//           snapshot.docs.forEach((element) {
//             FirebaseFirestore.instance
//                 .collection(collection)
//                 .doc(element.reference.id)
//                 .get()
//                 .then((value) {
//               Map<String, dynamic> data = value.data() as Map<String, dynamic>;
//               // array=[];
//               if (!(array.contains(data['branch']))) {
//                 array.add(data['branch']);
//                 print(array.length);
//                 setState(() {
//                   if (array.length > 0)
//                     notYetList = notYetList + (array.length);
//                 });
//               }
//               //.length= pricingNotYetList.length+1;
//               // notYetList.add(data['name']);
//             });
//           });
//         });
//   }
//
// //int notYetList =0;
//   Future getnotYet(String collection, List<String> array) async {
//     await FirebaseFirestore.instance
//         .collection(collection)
//         .where("merchandiserList",
//             arrayContainsAny: [widget.username, "Any Merchandiser"])
//         .where('status', isEqualTo: "not yet")
//         .get()
//         .then((snapshot) {
//           snapshot.docs.forEach((element) {
//             FirebaseFirestore.instance
//                 .collection(collection)
//                 .doc(element.reference.id)
//                 .get()
//                 .then((value) {
//               Map<String, dynamic> data = value.data() as Map<String, dynamic>;
//               //array=[];
//               if (!(array.contains(data['branch']))) {
//                 array.add(data['branch']);
//                 print(array.length);
//                 setState(() {
//                   if (array.length > 0)
//                     notYetList = notYetList + (array.length);
//                 });
//               }
//             });
//             // print(array.length);
//           });
//         });
//   }
//
//   ScrollController _scrollController = ScrollController();
//   @override
//   Widget build(BuildContext context) {
//     //DocumentSnapshot first=
//     //var role = "user";
//
//     TabController controller = TabController(length: 4, vsync: this);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: kprimaryColor,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 10),
//               child: Column(
//                 //crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     widget.username,
//                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold
//                         //fontFamily: PdfGoogleFonts.alefBold()
//                         ),
//                   ),
//                   SizedBox(
//                     height: 8,
//                   ),
//                   Text(
//                     '${widget.phone}',
//                     style: TextStyle(
//                         fontSize: 15, color: Colors.black.withOpacity(0.7)),
//                   )
//                 ],
//               ),
//             ),
//
//             // SizedBox(
//             //     width:5
//             // ),
//             if ((workingOnAvailability.length +
//                     workingOnInventory.length +
//                     workingOnRtv.length +
//                     // workingOnShare.length+
//                     workingOnPricing.length) >
//                 0)
//               GestureDetector(
//                 onTap: () {
//                   //  if(workingOn.length>0)
//                   Get.defaultDialog(
//                     title: 'Details'.tr,
//                     content: SingleChildScrollView(
//                         child: Padding(
//                       padding: const EdgeInsets.only(
//                         right: 15,
//                         left: 15,
//                       ),
//                       child: Container(
//                           //padding: EdgeInsets.only(top: 20),
//                           decoration: BoxDecoration(
//                               color: kprimaryColor.withOpacity(0.45),
//                               borderRadius:
//                                   // border: BorderRadius.circular(15)
//                                   // border
//                                   BorderRadius.circular(15)),
//                           child: DataTable(
//                               dataTextStyle: TextStyle(fontSize: 20),
//                               //showBottomBorder: true,
//                               //border: TableBorder.all(),
//                               //columnSpacing: 12,
//                               columns: [
//                                 DataColumn(
//                                     label: Text(
//                                   'Task'.tr.toUpperCase(),
//                                   style: const TextStyle(
//                                       fontSize: 10, color: Colors.black87),
//                                 )),
//                                 DataColumn(
//                                     label: Text(
//                                   "",
//                                   style: const TextStyle(
//                                       fontSize: 10, color: Colors.black87),
//                                 )),
//                               ],
//                               rows: [
//                                 if (workingOnRtv.length > 0)
//                                   DataRow(cells: <DataCell>[
//                                     DataCell(Text(
//                                       'RTV Section'.tr.toUpperCase(),
//                                       style: const TextStyle(
//                                           fontSize: 10, color: Colors.black87),
//                                     )),
//                                     DataCell(Text(
//                                       '${''}',
//                                       style: const TextStyle(
//                                           fontSize: 10, color: Colors.black87),
//                                     )),
//                                   ]),
//                                 if (workingOnInventory.length > 0)
//                                   DataRow(cells: <DataCell>[
//                                     DataCell(Text(
//                                       'Inventory'.tr.toUpperCase(),
//                                       style: const TextStyle(
//                                           fontSize: 10, color: Colors.black87),
//                                     )),
//                                     DataCell(Text(
//                                       '${''}',
//                                       style: const TextStyle(
//                                           fontSize: 10, color: Colors.black87),
//                                     )),
//                                   ]),
//                                 if (workingOnAvailability.length > 0)
//                                   DataRow(cells: <DataCell>[
//                                     DataCell(Text(
//                                       'Availability'.tr.toUpperCase(),
//                                       style: const TextStyle(
//                                           fontSize: 10, color: Colors.black87),
//                                     )),
//                                     DataCell(Text(
//                                       '${''}',
//                                       style: const TextStyle(
//                                           fontSize: 10, color: Colors.black87),
//                                     )),
//                                   ]),
//                                 if (workingOnShare.length > 0)
//                                   DataRow(cells: <DataCell>[
//                                     DataCell(Text(
//                                       'Share Of Shelves'.tr.toUpperCase(),
//                                       style: const TextStyle(
//                                           fontSize: 10, color: Colors.black87),
//                                     )),
//                                     DataCell(Text(
//                                       '${''}',
//                                       style: const TextStyle(
//                                           fontSize: 10, color: Colors.black87),
//                                     )),
//                                   ]),
//                                 if (workingOnPricing.length > 0)
//                                   DataRow(cells: <DataCell>[
//                                     DataCell(Text(
//                                       'Pricing'.tr.toUpperCase(),
//                                       style: const TextStyle(
//                                           fontSize: 10, color: Colors.black87),
//                                     )),
//                                     DataCell(Text(
//                                       '${''}',
//                                       style: const TextStyle(
//                                           fontSize: 10, color: Colors.black87),
//                                     )),
//                                   ]),
//
//                                 // )
//                               ])),
//                     )),
//                   );
//                 },
//                 child: Padding(
//                     padding: const EdgeInsets.only(left: 5.0, right: 5.0),
//                     child: Container(
//                       margin: EdgeInsets.only(left: 35),
//                       height: 40.0,
//                       width: 40.0,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30),
//                           //  color:task.status=="run"? Colors.amber:kprimaryColor.withOpacity(0.45),
//                           //color:kprimaryColor,
//                           border: Border.all(
//                               color: Colors.black,
//                               style: BorderStyle.solid,
//                               width: 1.0)),
//                       child: Center(
//                           child: Text(
//                               '${workingOnAvailability.length + workingOnInventory.length + workingOnRtv.length + workingOnShare.length + workingOnPricing.length}')),
//                     )),
//               ),
//             SizedBox(
//               width: 5,
//             ),
//             InkWell(
//               onTap: () {
//                 refreshFun();
//                 Get.offAll(() => MerchandiserHome(
//                       username: widget.username,
//                       id: widget.id,
//                       phone: widget.phone,
//                       marketImage: widget.marketImage,
//                       profileImage: widget.profileImage,
//                       // city: city,
//                       //marketDetails: widget.marketDetails,
//                       nationality: widget.nationality,
//                       market: widget.market,
//                       // user: username,
//                       branch: "All Branches",
//                       mangerphone: widget.mangerphone,
//                     ));
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 10.0),
//                 child: Column(
//                   //crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Icon(Icons.home),
//                     // SizedBox(height: 8,),
//                     Text(
//                       "Home".tr,
//                       style: TextStyle(
//                           fontSize: 15, color: Colors.black.withOpacity(0.7)),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             GestureDetector(
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 10.0),
//                 child: Column(
//                   //crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Icon(Icons.logout_outlined),
//                     //SizedBox(height: 8,),
//                     //children: [
//                     Text(
//                       "log out".tr,
//                       style: TextStyle(
//                           fontSize: 15, color: Colors.black.withOpacity(0.7)),
//                     ),
//                   ],
//                 ),
//               ),
//               onTap: () {
//                 FirebaseAuth.instance.signOut();
//                 Get.offAll(AndroidAuthPage());
//               },
//             ),
//             SizedBox(
//               width: 10,
//             ),
//           ],
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         child: ListView(
//           controller: _scrollController,
//           shrinkWrap: true,
//           children: <Widget>[
//             Column(
//               children: <Widget>[
//                 AndroidMerchandiserContainer(
//                     managerPhone: widget.mangerphone,
//                     branch: widget.branch,
//                     nationality: widget.nationality,
//                     // marketDetails: widget.marketDetails,
//                     id: widget.id,
//                     phone: widget.phone,
//                     market: widget.market,
//                     username: widget.username,
//                     marketImage: widget.marketImage,
//                     profileImage: widget.profileImage),
//                 Column(
//                   children: [
//                     //customSwith(status, switchVal, OnChangFun),
//                     Container(
//                       decoration: BoxDecoration(color: kBackgroundColor),
//                       child: TabBar(
//                           controller: controller,
//                           indicatorColor: Colors.transparent,
//                           labelColor: Colors.black,
//                           unselectedLabelColor: Colors.grey.withOpacity(0.6),
//                           isScrollable: true,
//                           tabs: [
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.home,
//                                   size: 40,
//                                   color: kprimaryColor,
//                                 ),
//                                 Text(
//                                   'Home'.tr,
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               children: [
//                                 Icon(
//                                   Icons.alarm,
//                                   size: 40,
//                                   color: kprimaryColor,
//                                 ),
//                                 Text(
//                                   'New Tasks'.tr,
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               children: [
//                                 Icon(
//                                   Icons.history,
//                                   size: 40,
//                                   color: kprimaryColor,
//                                 ),
//                                 Text('Daily Tasks'.tr,
//                                     style: TextStyle(
//                                         fontSize: 12,
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold))
//                               ],
//                             ),
//                             Column(
//                               children: [
//                                 Icon(
//                                   Icons.task_sharp,
//                                   size: 40,
//                                   color: kprimaryColor,
//                                 ),
//                                 Text(
//                                   'History'.tr,
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                           ]),
//                     ),
//                     SingleChildScrollView(
//                       physics: BouncingScrollPhysics(),
//                       child: Container(
//                         padding: const EdgeInsets.all(8),
//                         // height: double.maxFinite,
//                         height: 500,
//
//                         //color: kprimaryColor,
//                         width: double.maxFinite - 40,
//                         child: TabBarView(controller: controller, children: [
//                           HomeDetails(
//                             merchPhone: widget.phone,
//                             id: widget.id,
//                             nationality: widget.nationality,
//                             branch: widget.branch,
//                             rtvNotYetList: rtvNotYetList,
//                             inventoryNotYetList: inventoryNotYetList,
//                             availabilityNotYetList: availabilityNotYetList,
//                             shareNotYetList: shareNotYetList,
//                             pricingNotYetList: pricingNotYetList,
//                             completeTasks: doneTasks,
//                             restedTasks: notYetList - doneTasks,
//                             notYetList: notYetList,
//                             userName: widget.username,
//                             // todaysTasks: notYetList,
//                             market: widget.market,
//                             userImage: widget.profileImage,
//                             mangerPhone: widget.mangerphone,
//                             marketImage: widget.marketImage,
//                           ),
//                           // ClientList(
//                           //   market: 'Albaik',
//                           // ),
//
//                           NewTaskList(
//                             conditionList: [
//                               widget.username,
//                               "Any Merchandiser"
//                             ],
//                             managerPhone: widget.mangerphone,
//                             // myCollection: [],
//                             nationality: widget.nationality,
//                             //marketDetails: widget.marketDetails,
//                             id: widget.id,
//                             phone: widget.phone,
//                             marketImage: widget.marketImage,
//                             profileImage: widget.profileImage,
//                             username: widget.username,
//                             branch: widget.branch,
//                             market: widget.market,
//                             //city: widget.city,
//                           ),
//                           DailyTasks(
//                             adminPhone: widget.mangerphone,
//                             // city: widget.city,
//                             nationality: widget.nationality,
//                             //marketDetails: widget.marketDetails,
//                             id: widget.id,
//                             phone: widget.phone,
//                             // merchendisers: widget.merchendisers,
//                             marketImage: widget.marketImage,
//                             profileImage: widget.profileImage,
//                             username: widget.username,
//                             branch: widget.branch,
//                             market: widget.market,
//                           ),
//
//                           // History :
//                           MyTasksHistory(
//                             managerPhone: widget.mangerphone,
//                             nationality: widget.nationality,
//                             //marketDetails: widget.marketDetails,
//                             id: widget.id,
//                             phone: widget.phone,
//                             marketImage: widget.marketImage,
//                             profileImage: widget.profileImage,
//                             username: widget.username,
//                             branch: widget.branch,
//                             market: widget.market,
//                           ),
//                           // ClientList(
//                           //   market: widget.market,
//                           // ),
//                         ]),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//       // end of body
//       // bottomNavigationBar:
//       //     Material(
//       //   color: kprimaryColor.withOpacity(0.8),
//       //   child: Tab(
//       //       icon: Icon(
//       //     Icons.event_seat,
//       //   )),
//       // ),
//     );
//   }
//
//   Widget customSwith(String text, bool myValue, Function onchange) {
//     return Padding(
//       padding: EdgeInsets.only(top: 20, left: 20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           Text(
//             text,
//             style: TextStyle(
//                 fontSize: 20.0,
//                 fontWeight: FontWeight.w800,
//                 fontFamily: 'Roboto',
//                 color: Colors.black),
//           ),
//           // Spacer(),
//           CupertinoSwitch(
//               trackColor: Colors.red,
//               activeColor: Colors.green,
//               value: myValue,
//               onChanged: (newValue) {
//                 OnChangFun(newValue);
//                 //  onchange();
//                 //switchVal = !switchVal;
//               })
//         ],
//       ),
//     );
//   }
//
//   Future OnChangFun(bool val) async {
//     setState(() {
//       switchVal = val;
//       // getnotYet();
//
//       if (switchVal == false)
//         setState(() {
//           status = "Pause";
//           updateCase("Pause App");
//         });
//       else
//         setState(() {
//           status = "Doing Task";
//           updateCase("Doing Task");
//         });
//     });
//   }
//
//   bool switchVal = false;
//   String status = "Start App...";
//   //
//   Future updateCase(String newStatus) async {
//     var user = await FirebaseFirestore.instance
//         .collection('Merchandisers')
//         // .where('madeBy', isEqualTo:widget.name)
//         .where('national_id', isEqualTo: widget.id)
//         //.where('market', arrayContains: ['All Markets',widget.market])
//         .get();
//     if (user.docs.isNotEmpty) {
//       var doc_Id = user.docs.first.id;
//       await FirebaseFirestore.instance
//           .collection('Merchandisers')
//           .doc(doc_Id)
//           .update({"status": newStatus});
//
//       print(newStatus);
//     }
//   }
// }
