//
//
// import 'dart:io';
// import 'package:arrow_merchandising/Android/merchandiser/merch_nav_bar.dart';
// import 'package:arrow_merchandising/android/merchandiser/profile/profile_menu.dart';
// import 'package:arrow_merchandising/android/splash/auth_page.dart';
// import 'package:arrow_merchandising/models/Visits.dart';
// import 'package:arrow_merchandising/models/capture_photos.dart';
// import 'package:arrow_merchandising/models/last_visit.dart';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// //import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import '../../../../components/default_button.dart';
// import '../../../../components/title_with_icon.dart';
// import 'package:arrow_merchandising/const.dart';
// import '../../../../splash/indicator.dart';
// import '../../../profile/merchandiser_container.dart';
// import '../../main data/daily_task_screen.dart';
// import '../../main data/merch_home.dart';
//
//
// class AndroidCapturePhoto extends StatefulWidget {
//   final FirstVisit before;
//   final LastVisit after;
//   final int id, phone, adminPhone;
//   final String marketImage,
//       profileImage,
//       username,
//       title,
//       branch,
//       manegerName,
//       market,
//       nationality;
//       //marketDetails;
//  // final List<String> conditionList;
//   const AndroidCapturePhoto(
//       {super.key,
//
//         required this.before,
//         required this.title,
//         required this.marketImage,
//         required this.profileImage,
//         required this.username,
//         required this.branch,
//         required this.market,
//         required this.id,
//         required this.phone,
//         required this.nationality,
//         required this.after,
//         required this.adminPhone,
//         required this.manegerName});
//
//   @override
//   State<AndroidCapturePhoto> createState() => _AndroidCapturePhotoState();
// }
//
// class _AndroidCapturePhotoState extends State<AndroidCapturePhoto>
//     with TickerProviderStateMixin
// {
//
//  //List<String> strCarPhotosList=[];
//
//
//   var _sellectedIndex = 0;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:PreferredSize(
//           preferredSize: const Size.fromHeight(60),
//           child:
//           MerchandiserAppBar(
//               phone: widget.phone,
//               profileImage: widget.profileImage,
//               username: widget.username
//           )),
//       // appBar: AppBar(backgroundColor: kprimaryColor,
//       //   title: Row(
//       //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       //     children: [
//       //       Padding(
//       //         padding: const EdgeInsets.only(top:10),
//       //         child: Column(
//       //           //crossAxisAlignment: CrossAxisAlignment.start,
//       //           children: <Widget>[
//       //             Text(
//       //               widget.username,
//       //               style: TextStyle(
//       //                   fontSize: 15, fontWeight: FontWeight.bold
//       //                 //fontFamily: PdfGoogleFonts.alefBold()
//       //               ),
//       //             ),
//       //             SizedBox(
//       //               height: 8,
//       //             ),
//       //             Text(
//       //               '${widget.phone}',
//       //               style: TextStyle(
//       //                   fontSize: 15,
//       //                   color: Colors.black.withOpacity(0.7)),
//       //             )
//       //           ],
//       //         ),
//       //       ),
//       //
//       //       SizedBox(
//       //           width:10
//       //       ),
//       //
//       //       InkWell(
//       //         onTap: (){
//       //           Get.offAll(() =>AndroidAuthPage()
//       //           // Get.offAll(()=>
//       //           //      MerchNavBar(
//       //           //       username: widget.username,
//       //           //       id: widget.id,
//       //           //       phone: widget.phone,
//       //           //       marketImage: widget.marketImage,
//       //           //       profileImage: widget.profileImage,
//       //           //       // city: city,
//       //           //       //marketDetails: widget.marketDetails,
//       //           //       nationality: widget.nationality,
//       //           //       market: "All Markets",
//       //           //       branch: "All Branches",
//       //           //       mangerphone:widget.adminPhone,
//       //           //     )
//       //           );
//       //         },
//       //         child: Padding(
//       //           padding: const EdgeInsets.only(top:10.0),
//       //           child: Column(
//       //             //crossAxisAlignment: CrossAxisAlignment.start,
//       //             children: [
//       //               Icon(Icons.home),
//       //               // SizedBox(height: 8,),
//       //               Text("Home".tr,
//       //                 style: TextStyle(
//       //                     fontSize: 15,
//       //                     color: Colors.black.withOpacity(0.7)
//       //                 ),),
//       //             ],
//       //           ),
//       //         ),
//       //       ),
//       //       SizedBox(
//       //         width:10,
//       //       ),
//       //       GestureDetector(
//       //         child: Padding(
//       //           padding: const EdgeInsets.only(top:10.0),
//       //           child: Column(
//       //             //crossAxisAlignment: CrossAxisAlignment.start,
//       //             children: [
//       //               Icon(Icons.logout_outlined),
//       //               //SizedBox(height: 8,),
//       //               //children: [
//       //               Text("log out".tr, style: TextStyle(
//       //                   fontSize: 15,
//       //                   color: Colors.black.withOpacity(0.7)
//       //               ),),
//       //             ],
//       //           ),
//       //         ),
//       //         onTap: () {
//       //           FirebaseAuth.instance.signOut();
//       //           Get.offAll(AndroidAuthPage());
//       //         },
//       //       ),
//       //       SizedBox(
//       //         width:10,
//       //       ),
//       //     ],
//       //   ),
//       //   centerTitle: true,
//       // ),
//       body: ListView(
//         children: <Widget>[
//           Column(
//             children: <Widget>[
//               // AndroidMerchandiserContainer(
//               //     managerPhone:widget.adminPhone,
//               //     branch: widget.branch,
//               //     nationality: widget.nationality,
//               //     //marketDetails: widget.marketDetails,
//               //     id: widget.id,
//               //     phone: widget.phone,
//               //     market: widget.market,
//               //     username: widget.username,
//               //     marketImage: widget.marketImage,
//               //     profileImage: widget.profileImage),
//
//
//
//               SizedBox(height: 20,),
//             // Before
//
//
//               Container(
//                 // height: 30,
//                 decoration: BoxDecoration(color: Colors.white),
//                 child:
//                 TitleWithIcon(
//                   icon: Icon(Icons.camera,size: 32,color: kprimaryColor,),
//                   title: widget.title.tr,
//                 ),
//               ),
//               SizedBox(height: 20,),
//               Column(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.only(top: 10),
//                     width: 150,
//                     height: 140,
//                     child: PageView.builder(
//                         onPageChanged: (value) {
//                           setState(() {
//                             _sellectedIndex = value;
//                           });
//                         },
//                         itemCount:  widget.before.images.length,
//                         itemBuilder: (context, index) {
//                           var _scale = _sellectedIndex == index ? 1.0 : 0.8;
//                           return TweenAnimationBuilder(
//                             duration: const Duration(milliseconds: 3500),
//                             //kAnimationDuration,
//                             tween: Tween(begin: _scale, end: _scale),
//                             curve: Curves.ease,
//                             builder: (context, value, child){
//                               return  Transform.scale(scale: value, child: child);
//                             },
//                             child:Container(
//                                 padding: EdgeInsets.all(10),
//                                 // width: 65,
//                                 // height: 80,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(30)),
//                                 child:Image.file( widget.before.images[index]!
//                                 )
//                               //)
//                             ),
//                           );
//                         }
//                     ),
//                   ),
//                   Padding(padding: EdgeInsets.only(top: 15,bottom: 15),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           ...List.generate(
//                               widget.before.images.length,
//                                   (index) => Indicator(
//                                   isActive:
//                                   _sellectedIndex == index ? true : false
//                                 // isActive: isActive
//                               )
//                             // buildDot(index: index),
//                           ),
//                         ]),
//                   ),
//                   //SizedBox(height: 20,),
//                 ],
//               ),
//
//               // After
//             // if(strCarPhotosList.length<=9)
//             //     MaterialButton(
//             //       onPressed: () async{
//             //        await getImage();
//             //       },
//             //       child: Center(
//             //         child: DefualtButton(
//             //             text:(imagePath.length==0)?
//             //             "Take A Picture".tr:
//             //           "Take Another Picture".tr
//             //       ),
//             //       ),
//             //     ),
//                     const SizedBox(height: 20,),
//                    // if(imagePath.length>1)
//
//                       InkWell(
//                           onTap: () async {
//
//                             await uploadBeforeImage(widget.before.images);
//                             setState(() {
//                               startProgress=true;
//                             });
//                             await uploadAfterImage(widget.after.images);
//                              setState(() {
//                               startProgress=true;
//                             });
//
//                             if(uploadDone=true)
//                               createPhotosTask(
//                                   FullVisit(
//                                     title: widget.title,
//                                     before: widget.before,
//                                     after:widget.after,
//                                     status: 'Done',
//                                      madeBy: widget.username,
//                                      market: widget.market,
//                                      branch: widget.branch,
//                                      date: (DateFormat('yyyy-MM-dd')
//                                         .format(DateTime.now())
//                                         .toString()),
//                                     taskTime: (DateFormat('kk:mm')
//                                         .format(DateTime.now())
//                                         .toString()),
//                                   ));
//
//                             if((doneTask=true)&&(uploadDone==true))
//                               Get.defaultDialog(
//                                   title: "",
//                                   content: Column(
//                                     children: [
//                                       // buildProgress(),
//                                      // if(uploadDone)
//                                         Column(
//                                             children: [
//                                               GestureDetector(
//                                                   onTap: () {
//                                                     Get.offAll(() =>
//                                                         AndroidDailyTasksScreen(
//                                                             manegerName:widget.manegerName,
//                                                             username: widget.username,
//                                                             marketImage: widget.marketImage,
//                                                             profileImage: widget.profileImage,
//                                                             branch: widget.branch,
//                                                             market: widget.market,
//                                                             id: widget.id,
//                                                             phone: widget.phone,
//                                                             //marketDetails:widget. marketDetails,
//                                                             nationality: widget.nationality,
//                                                             adminPhone: widget.adminPhone)
//                                                     );
//                                                   },
//                                                   child: DefualtButton(
//                                                       text: 'Daily Tasks'.tr.toUpperCase())),
//                                               SizedBox(height: 20,),
//                                               GestureDetector(
//                                                   onTap: () {
//                                                     Get.offAll(() =>AndroidAuthPage()
//                                                     // Get.offAll(() =>
//                                                     //      MerchNavBar(
//                                                     //         username: widget.username,
//                                                     //         marketImage: widget.marketImage,
//                                                     //         profileImage: widget.profileImage,
//                                                     //         market: "All Markets",
//                                                     //         branch: "All Branches",
//                                                     //         id: widget.id,
//                                                     //         phone: widget.phone,
//                                                     //         //marketDetails:widget. marketDetails,
//                                                     //         nationality: widget.nationality,
//                                                     //         mangerphone: widget.adminPhone)
//                                                     );
//                                                     // Get.to(()=>AddCarFirstScreen(
//                                                     //  business: widget.business,
//                                                     //  ));
//                                                   },
//                                                   child: DefualtButton(
//
//                                                       text: 'Home'.tr.toUpperCase()
//                                                   )
//                                               ),
//                                               SizedBox(height: 20,),
//                                             ])
//                                     ],
//                                   )
//                               );
//                             // setState(() {
//                             //   //startProgress=true;
//                             // });
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.only(left:20.0,right:20,bottom: 10),
//                             child: DefualtButton(
//
//                               text: 'Create Task'.tr,
//                             ),
//                           )
//
//                         //  ؟؟++++++؟؟ـ-ـ§
//                       ),
//               if(startProgress==true)
//                 buildProgress(),
//               SizedBox(height: 20,)
//             ]
//           )
//
//           //  ),
//         ],
//       ),
//
//     );
//   }
//
//  Future createPhotosTask(FullVisit capturePhotos) async {
//     final photoslist =
//     FirebaseFirestore.instance.collection(widget.title).doc();
//     final json = capturePhotos.toMap();
//     await photoslist.set(json);
//     doneTask=true;
//     //  final
//   }
//  bool doneTask=false,uploadDone=false,startProgress=false;
//  UploadTask? uploadTask;
//  //String rtvImage="";
//
//  Future uploadBeforeImage(List<File?> myImagePath) async {
//    for (int i = 0; i < myImagePath.length; i++) {
//      final file = File(myImagePath[i]!.path!);
//      final ref =
//      FirebaseStorage.instance
//          .ref().child(myImagePath[i]!.path!);
//      setState(() {
//        startProgress = true;
//        uploadTask = ref.putFile(file);
//      });
//      final snapShot = await uploadTask!.whenComplete(() {
//        if(strBeforePhotosList.length==myImagePath.length)
//        setState(() {
//          uploadDone=true;
//          startProgress=false;
//        });
//
//        // });
//      });
//      strBeforePhotosList.add(await snapShot.ref.getDownloadURL());
//      setState(() {
//        uploadTask = ref.putFile(file);
//      });
//    }
//    setState(() {
//      if(strBeforePhotosList.length==myImagePath.length)
//       // uploadDone=true;
//        startProgress=false;
//    });
//  }
//
//  List<String> strBeforePhotosList=[];
//
//
//  List<String> strAfterPhotosList=[];
//
//   Future uploadAfterImage(List<File?> myImagePath) async {
//     for (int i = 0; i < myImagePath.length; i++) {
//       final file = File(myImagePath[i]!.path!);
//       final ref =
//       FirebaseStorage.instance
//           .ref().child(myImagePath[i]!.path!);
//       setState(() {
//         startProgress = true;
//         uploadTask = ref.putFile(file);
//       });
//       final snapShot = await uploadTask!.whenComplete(() {
//         if(strAfterPhotosList.length==myImagePath.length)
//           setState(() {
//             uploadDone=true;
//             startProgress=false;
//           });
//
//         // });
//       });
//       strAfterPhotosList.add(await snapShot.ref.getDownloadURL());
//       setState(() {
//         uploadTask = ref.putFile(file);
//       });
//     }
//     setState(() {
//       if(strAfterPhotosList.length==myImagePath.length)
//          uploadDone=true;
//         startProgress=false;
//     });
//   }
// //  List<File?> imagePath=[];
// //
// //
// //  final imagePicker = ImagePicker();
// //
// //  Future  getImage() async {
// //    final image = await imagePicker.pickImage(source: ImageSource.camera);
// //    setState(() {
// //      imagePath.add(File(image!.path));
// //    });
// //  }
//
//  Widget buildProgress() =>
//      StreamBuilder<TaskSnapshot>(
//          stream: uploadTask?.snapshotEvents,
//          builder: (context,snapshot)
//          {
//            if (snapshot.hasError) {
//              return Text(' Error ya Ahmed :: ${snapshot.error}');
//            } else if (snapshot.hasData) {
//              final task = snapshot.data!;
//              double progress=task.bytesTransferred / task.totalBytes;
//
//              return Padding(
//                padding: const EdgeInsets.only(left:20.0,right:20,bottom: 10),
//                child: SizedBox(
//                  height: 50,
//                  child: Stack(
//                    fit: StackFit.expand,
//                    children: [
//                      LinearProgressIndicator(
//                        value: progress,
//                        backgroundColor: kprimaryColor,
//                        color: Colors.grey,
//                      ),
//                      //  ((progress / 100 )!=1)?
//                      Center(child: Text('${(100 * progress).roundToDouble()}%'),
//                      )
//                    ],
//                  ),
//                ),
//              );
//            } else {
//              return Center(
//                child:
//                CircularProgressIndicator(),
//              );
//            }
//          }
//      );
// }
//
//
