//
// import 'dart:io';
//
// import 'package:arrow_merchandising/android/merchandiser/home/daily%20tasks/availability/availability_chart_body.dart';
// import 'package:arrow_merchandising/android/merchandiser/home/main%20data/daily_task_screen.dart';
// import 'package:arrow_merchandising/android/merchandiser/home/main%20data/merch_home.dart';
// import 'package:arrow_merchandising/android/merchandiser/merch_nav_bar.dart';
// import 'package:arrow_merchandising/android/splash/auth_page.dart';
// import 'package:arrow_merchandising/models/availability_task.dart';
// import 'package:arrow_merchandising/models/availability_products.dart';
// import 'package:arrow_merchandising/models/inventory_products.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
//
// import '../../../../components/default_button.dart';
// import 'package:arrow_merchandising/const.dart';
//
//
//
// class AndroidAvailabilityChart extends StatefulWidget {
//   final int id, phone,managerPhone;
//   final String username,manegerName,
//       marketImage,
//       profileImage,
//       branch,
//       market,
//       nationality;
//   final String place;
//
//   //marketDetails;
//   // final List<InventoryProduct> inventoryProduct;
//   const AndroidAvailabilityChart(
//       {super.key,
//         required this.username,
//         required this.marketImage,
//         required this.profileImage,
//         required this.branch,
//         required this.market,
//         required this.id,
//         required this.phone,
//         required this.nationality,
//         required this.place,
//         required this.managerPhone,
//         required this.manegerName
//       });
//   // const MyInventoryChart({super.key});
//
//   @override
//   State<AndroidAvailabilityChart> createState() => _AndroidAvailabilityChartState();
// }
//
// class _AndroidAvailabilityChartState extends State<AndroidAvailabilityChart> {
//
//   //List<InventoryProduct> inventoryProduct=[];
//   //List<String> displayType=[];
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       // backgroundColor: kprimaryColor,
//         appBar:
//
//         AppBar(
//           backgroundColor: kprimaryColor,
//           title: Center(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Text(
//                   "Products List".tr,
//                   style: TextStyle(color: Colors.black),
//                 ),
//                 Text((availabilityTaskDetails.length==1)?
//                 "One Product".tr:
//                 "${availabilityTaskDetails.length - 1}\t"+"Product".tr,
//                     style:TextStyle(fontSize: 20,color: Colors.white)
//                   //Theme.of(context).textTheme.caption,
//
//                 )
//               ],
//             ),
//           ),
//         ),
//         body:AndroidAvailabilityTaskBody(
//           branch: widget.branch,
//           nationality: widget.nationality,
//           id: widget.id,
//           phone: widget.phone,
//           market: widget.market,
//           username: widget.username,
//           marketImage: widget.marketImage,
//           managerPhone: widget.managerPhone,
//           profileImage:widget.profileImage,
//         ),
//
//
//         bottomNavigationBar: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child:
//           (imageSrc==null&&(availabilityTaskDetails.length!=0)) ?
//           GestureDetector(
//               onTap: () async{
//                // uploadImage();
//                 await  getImage();
//
//
//               },
//               child: DefualtButton( selected: true,text:"Upload Image".tr)):
//           GestureDetector(
//               onTap: () async {
//                 setState(() {
//                   _getCurrentLocation().then((value) {
//                     lat=double.parse('${value.latitude}');
//                     long=double.parse('${value.longitude}');
//                   });
//                   currentLocation=
//                       "latitude"+":"+"\t"+"$lat"
//                           +"\n"+"langtude"+":"+"\t"+"${long}";
//                 });
//                 await uploadImage();
//
//                 if(uploadDone=true&&(lat!=0.0)&&(long!=0.0)) {
//
//                   if(AvailabilityImagePath!="") {
//                     createAvailabilityTask(
//                         AvailabilityTaskModel(
//                           lat: lat,
//                           long: long,
//                           photo: AvailabilityImagePath,
//                           type: widget.place,
//                           // photo: inventoryPhoto,
//                           market: widget.market,
//                           branch: widget.branch,
//                           availabilityProduct: availabilityTaskDetails,
//                           madeBy: widget.username,
//                           taskDate: (DateFormat('yyyy-MM-dd')
//                               .format(DateTime.now())
//                               .toString()),
//                           taskTime: (DateFormat('kk:mm')
//                               .format(DateTime.now())
//                               .toString()),
//                           status: "Done",
//
//                         )
//                     );
//                     Get.defaultDialog(
//                         title: " ",
//                         content: Column(
//                           children: [
//                             // buildProgress(),
//                             // if(uploadDone)
//                             Column(
//                                 children: [
//                                   GestureDetector(
//                                       onTap: () {
//                                         availabilityTaskDetails = [];
//                                         availabilityDisplayPhotos=[];
//                                         selectedAvailabilityProducts=[];
//                                         // availabilityPhoto=[];
//                                         completeAvailabilityTasks.add(widget.place);
//                                         Get.offAll(() =>
//                                             AndroidDailyTasksScreen(
//                                                 manegerName:widget.manegerName,
//                                                 username: widget.username,
//                                                 marketImage: widget.marketImage,
//                                                 profileImage: widget
//                                                     .profileImage,
//                                                 branch: widget.branch,
//                                                 market: widget.market,
//                                                 id: widget.id,
//                                                 phone: widget.phone,
//                                                 nationality: widget.nationality,
//                                                 adminPhone: widget.managerPhone)
//                                         );
//                                       },
//                                       child: DefualtButton( selected: true,
//                                           text: 'Daily Tasks'.tr
//                                               .toUpperCase())),
//                                   SizedBox(height: 20,),
//                                   GestureDetector(
//                                       onTap: () {
//                                         availabilityTaskDetails = [];
//                                         availabilityDisplayPhotos=[];
//                                         selectedAvailabilityProducts=[];
//                                         completeAvailabilityTasks.add(widget.place);
//                                         Get.offAll(() =>AndroidAuthPage()
//                                         // Get.offAll(() =>
//                                         //     MerchNavBar(
//                                         //         username: widget.username,
//                                         //         marketImage: widget.marketImage,
//                                         //         profileImage: widget
//                                         //             .profileImage,
//                                         //         market: "All Markets",
//                                         //         branch: "All Branches",
//                                         //         id: widget.id,
//                                         //         phone: widget.phone,
//                                         //         //marketDetails:widget. marketDetails,
//                                         //         nationality: widget.nationality,
//                                         //         mangerphone: widget.managerPhone)
//                                         );
//                                       },
//                                       child: DefualtButton( selected: true,
//
//                                           text: 'Home'.tr.toUpperCase()
//                                       )
//                                   ),
//                                   SizedBox(height: 20,),
//                                 ])
//                           ],
//                         )
//                     );
//                   }else{
//                     Fluttertoast.showToast(
//                         msg: "Error".tr,
//                         backgroundColor: kprimaryColor,
//                         toastLength: Toast.LENGTH_LONG,
//                         fontSize: 20,
//                         gravity:ToastGravity.CENTER
//
//                     );
//                   }
//                   // if ((doneTask = true) && (uploadDone == true))
//
//                 }
//                 else{
//                   buildProgress();
//                 }
//               },
//               child: (startProgress==false&&(availabilityTaskDetails.length>0))?
//               DefualtButton( selected: true,text: "Create Task".tr):
//               buildProgress()
//             //
//             // DefualtButton( selected: true,text: "Submit"),
//           ),
//         )
//
//
//     );
//   }
//
//
//
//   Future createAvailabilityTask(AvailabilityTaskModel availabilityTask) async {
//     final availabilityData = FirebaseFirestore.instance.collection(
//         'Availability').doc();
//     final json = availabilityTask.toMap();
//     await availabilityData.set(json);
//     doneTask=true;
//   }
// // bool doneTask=false;
//
//   bool doneTask=false,uploadDone=false,startProgress=false;
//   UploadTask? uploadTask;
//   String AvailabilityImagePath="";
//
//   Future uploadImage() async {
//     final file=File(imageSrc!.path!);
//     final ref=
//     FirebaseStorage.instance
//         .ref().child("Availability Pictures/"+DateTime.now().toString()+'.png');
//     setState(() {
//       startProgress=true;
//       uploadTask=ref.putFile(file);
//     });
//
//     final snapShot=await uploadTask!.whenComplete(() {
//
//       setState(() {
//         uploadDone=true;
//         startProgress=false;
//       });
//     });
//     AvailabilityImagePath= (await snapShot.ref.getDownloadURL());
//     print(AvailabilityImagePath);
//     setState(() {
//       uploadTask=ref.putFile(file);
//       uploadDone=true;
//     });
//     if(AvailabilityImagePath!="")
//       setState(() {
//         uploadDone=true;
//         startProgress=false;
//       });
//   }
//
// // List<String> strCarPhotosList=[];
//   File? imageSrc;
//
//
//   final imagePicker = ImagePicker();
//
//   Future  getImage() async {
//     final image = await imagePicker.pickImage(source: ImageSource.camera);
//     setState(() {
//       //availabilityDisplayPhotos=[];
//       imageSrc=File(image!.path);
//       availabilityDisplayPhotos.add(File(image!.path));
//       //inventoryPhoto==imagePath!.path!.toString();
//     });
//   }
//
//   Widget buildProgress() =>
//       StreamBuilder<TaskSnapshot>(
//           stream: uploadTask?.snapshotEvents,
//           builder: (context,snapshot)
//           {
//             if (snapshot.hasError) {
//               return Text(' Error ya Ahmed :: ${snapshot.error}');
//             } else if (snapshot.hasData) {
//               final task = snapshot.data!;
//               double progress=task.bytesTransferred / task.totalBytes;
//
//               return Padding(
//                 padding: const EdgeInsets.only(left:20.0,right:20,bottom: 10),
//                 child: SizedBox(
//                   height: 50,
//                   child: Stack(
//                     fit: StackFit.expand,
//                     children: [
//                       LinearProgressIndicator(
//                         value: progress,
//                         backgroundColor: kprimaryColor,
//                         color: Colors.grey,
//                       ),
//                       //  ((progress / 100 )!=1)?
//                       Center(child: Text('${(100 * progress).roundToDouble()}%'),
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             } else {
//               return Center(
//                 child:
//                 CircularProgressIndicator(),
//               );
//             }
//           }
//       );
//
//   String currentLocation="";
//   double lat=0,long=0;
//
//   Future<Position> _getCurrentLocation() async {
//     bool serviceEnabled= await Geolocator.isLocationServiceEnabled();
//     if(!serviceEnabled){
//       return Future.error("Location Services are disEnabled.");
//     }
//
//     LocationPermission permission = await Geolocator.checkPermission();
//     if(permission == LocationPermission.denied){
//       permission = await Geolocator.requestPermission();
//       if(permission == LocationPermission.denied){
//         return Future.error("Location Permissions are denied.");
//       }
//     }
//     if(permission== LocationPermission.deniedForever)
//     {
//       return Future.error("Location permissions are permanently denied , we can't request any permission");
//     }
//
//     return await Geolocator.getCurrentPosition();
//   }
//
// }
