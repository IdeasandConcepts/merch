//
// import 'dart:io';
//
// import 'package:arrow_merchandising/android/merchandiser/home/daily%20tasks/availability/availability.dart';
// import 'package:arrow_merchandising/android/merchandiser/home/daily%20tasks/availability/availability_chart_body.dart';
// import 'package:arrow_merchandising/android/merchandiser/home/main%20data/daily_task_screen.dart';
// import 'package:arrow_merchandising/android/merchandiser/home/main%20data/merch_home.dart';
// import 'package:arrow_merchandising/android/merchandiser/merch_nav_bar.dart';
// import 'package:arrow_merchandising/android/merchandiser/profile/branch_appbar.dart';
// import 'package:arrow_merchandising/android/merchandiser/profile/profile_screen.dart';
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
// class AndroidMyAvailabilityChart extends StatefulWidget {
//   final int id, phone,managerPhone;
//   final String username,manegerName,
//       marketImage,
//       profileImage,
//       branch,
//       market,
//       nationality;
//   final String place;
//   final File? imageSrc;
//   final String orderBy,taskType;
//   //marketDetails;
//   // final List<InventoryProduct> inventoryProduct;
//   const AndroidMyAvailabilityChart(
//       {super.key,
//         required this.orderBy,
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
//         //required this.imageSrc,
//         required this.manegerName, required this.taskType,
//         this.imageSrc
//       });
//   // const MyInventoryChart({super.key});
//
//   @override
//   State<AndroidMyAvailabilityChart> createState() => _AndroidMyAvailabilityChartState();
// }
//
// class _AndroidMyAvailabilityChartState extends State<AndroidMyAvailabilityChart> {
//
//   //List<InventoryProduct> inventoryProduct=[];
//   //List<String> displayType=[];
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar:AppBar(
//             automaticallyImplyLeading: false,
//             backgroundColor: kprimaryColor,
//             title:
//             MerchAppBar(
//               // appBar: MerchAppBar(
//               title: "Availability Section",
//               manegerName: widget.manegerName,
//               phone: widget.phone,
//               market: widget.market,
//               marketImage: widget.marketImage,
//               branch: widget.branch,
//               username: widget.username,
//               profileImage: widget.profileImage,
//             ) ),
//         // appBar:AppBar(
//         //   automaticallyImplyLeading: false,
//         //   backgroundColor: kprimaryColor,
//         //   title: IconButton(
//         //       onPressed: (){
//         //         Get.defaultDialog(
//         //           title: "",
//         //           content: MerchDrawerItems(
//         //             branch: widget.branch,
//         //             name: widget.username,
//         //             // todaysTasks: notYetList,
//         //             market: widget.market,
//         //             profileImage: widget.profileImage,
//         //             phone: widget.phone,
//         //             //  imageasset: widget.marketImage,
//         //           ),
//         //         );
//         //       },
//         //       icon:Icon(Icons.menu,color: Colors.white,)
//         //   ),
//         //
//         // ),
//         body:AndroidAvailabilityTaskBody(
//           comeFrom: 'AI',
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
//         bottomNavigationBar: GestureDetector(
//             onTap: () async {
// Get.to(()=>Availability(
//   manegerName:widget.manegerName,
//   username: widget.username,
//   marketImage: widget.marketImage,
//   profileImage: widget
//       .profileImage,
//   branch: widget.branch,
//   market: widget.market,
//   id: widget.id,
//   phone: widget.phone,
//   nationality: widget.nationality,
//   managerPhone: widget.managerPhone,
//   orderBy: widget.orderBy,
//   taskType: widget.taskType,
//   place: widget.place,
//
// ));
//         // createAvailabilityTask(
//         // AvailabilityTaskModel(
//         //   orderBy: widget.orderBy,
//         // lat: lat,
//         // long: long,
//         // photo: AvailabilityImagePath,
//         // type: widget.place,
//         // // photo: inventoryPhoto,
//         // market: widget.market,
//         // branch: widget.branch,
//         // availabilityProduct: availabilityTaskDetails,
//         // madeBy: widget.username,
//         // taskDate: (DateFormat('yyyy-MM-dd')
//         //     .format(DateTime.now())
//         //     .toString()),
//         // taskTime: (DateFormat('kk:mm')
//         //     .format(DateTime.now())
//         //     .toString()),
//         // status: "Done",
//         //
//         // )
//         // );
//         //           // onTap: () {
//         // setState(() {
//         // availabilityTaskDetails = [];
//         // selectedAvailabilityProducts=[];
//         // completeAvailabilityTasks.add(widget.place);
//         // });
//         // Get.offAll(() =>
//         // MerchNavBar(
//         // tab_index: 2,
//         // //username: username, marketImage: marketImage, profileImage: profileImage, branch: branch, market: market, id: id, phone: phone, manegerName: manegerName, nationality: nationality, tab_index: tab_index, mangerphone: mangerphone)
//         // manegerName:widget.manegerName,
//         // username: widget.username,
//         // marketImage: widget.marketImage,
//         // profileImage: widget
//         //     .profileImage,
//         // branch: widget.branch,
//         // market: widget.market,
//         // id: widget.id,
//         // phone: widget.phone,
//         // nationality: widget.nationality,
//         // mangerphone: widget.managerPhone)
//         // );
//                //    }
//         },
//                                      child: DefualtButton(
//                                          selected: true,
//                                          text: 'Add To List'.tr
//                                              )
//               )
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
//     final file=File(widget.imageSrc!.path!);
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
//   //File? imagePath;
// //
// //
// //   final imagePicker = ImagePicker();
// //
// //   Future  getImage() async {
// //     final image = await imagePicker.pickImage(source: ImageSource.camera);
// //     setState(() {
// //       //availabilityDisplayPhotos=[];
// //       imagePath=File(image!.path);
// //       availabilityDisplayPhotos.add(File(image!.path));
// //       //inventoryPhoto==imagePath!.path!.toString();
// //     });
// //   }
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
