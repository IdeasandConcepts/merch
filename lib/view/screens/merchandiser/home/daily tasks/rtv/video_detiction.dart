// import 'package:arrow_merchandising/Android/components/default_button.dart';
// import 'package:arrow_merchandising/android/merchandiser/home/daily%20tasks/rtv/rtv_screen.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// //import 'package:flutter_vision/flutter_vision.dart';
// import 'package:camera/camera.dart';
// import 'package:arrow_merchandising/const.dart';
// import 'package:arrow_merchandising/models/rtv_product.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import 'package:arrow_merchandising/models/new_products.dart';
// import 'package:flutter_vision/flutter_vision.dart';
// import 'package:get/get.dart';
//
// late List<CameraDescription> cameras;
//
// class RTVYoloVideo extends StatefulWidget {
//   final int id, phone, managerPhone;
//   final String marketImage,
//       profileImage,
//       username,
//       managerName,
//       branch,
//       market,
//       nationality;
//   final String place, taskType, orderBy;
//   const RTVYoloVideo({
//     Key? key,
//     required this.managerPhone,
//     required this.marketImage,
//     required this.profileImage,
//     required this.username,
//     required this.branch,
//     required this.market,
//     required this.id,
//     required this.phone,
//     required this.nationality,
//     required this.place,
//     required this.managerName,
//     required this.orderBy,
//     required this.taskType,
//     // RTVYoloVideo({Key? key
//   }) : super(key: key);
//
//   @override
//   State<RTVYoloVideo> createState() => _RTVYoloVideoState();
// }
//
// class _RTVYoloVideoState extends State<RTVYoloVideo> {
//   late CameraController controller;
//   late FlutterVision vision;
//   List<Map<String, dynamic>> yoloResults = [];
//   List<Map<String, dynamic>> allresult = [];
//
//   CameraImage? cameraImage;
//   bool isLoaded = false;
//   bool isDetecting = false;
//   double confidenceThreshold = 0.5;
//
//   @override
//   void initState() {
//     super.initState();
//     init();
//   }
//
//   Future<void> init() async {
//     try {
//       cameras = await availableCameras();
//       // vision = FlutterVision();
//       controller = CameraController(
//         cameras[0],
//         ResolutionPreset.high,
//       );
//       await controller.initialize();
//       await loadYoloModel();
//       setState(() {
//         isLoaded = true;
//         isDetecting = false;
//       });
//     } catch (e) {
//       print("Error initializing the camera or loading the model: $e");
//     }
//   }
//
//   // @override
//   // void dispose() {
//   //   controller.dispose();
//   //   vision.closeYoloModel();
//   //   super.dispose();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//
//     List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
//       if (yoloResults.isEmpty) return [];
//       double factorX = screen.width / (cameraImage?.height ?? 1);
//       double factorY = screen.height / (cameraImage?.width ?? 1);
//
//       Color colorPick = const Color.fromARGB(255, 50, 233, 30);
//
//       return yoloResults.map((result) {
//         double objectX = result["box"][0] * factorX;
//         double objectY = result["box"][1] * factorY;
//         double objectWidth = (result["box"][2] - result["box"][0]) * factorX;
//         double objectHeight = (result["box"][3] - result["box"][1]) * factorY;
//
//         return Positioned(
//           left: objectX,
//           top: objectY,
//           width: objectWidth,
//           height: objectHeight,
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: const BorderRadius.all(Radius.circular(10.0)),
//               border: Border.all(color: Colors.pink, width: 2.0),
//             ),
//             child: Text(
//               "${result['tag']} ${(result['box'][4] * 100).toStringAsFixed(2)}%",
//               style: TextStyle(
//                 background: Paint()..color = colorPick,
//                 color: const Color.fromARGB(255, 115, 0, 255),
//                 fontSize: 18.0,
//               ),
//             ),
//           ),
//         );
//       }).toList();
//     }
//
//     if (!isLoaded) {
//       return const Scaffold(
//         body: Center(
//           child: Text("Model not loaded, waiting for it"),
//         ),
//       );
//     }
//
//     return Scaffold(
//       bottomNavigationBar: (allresult.length > 0 && isDetecting == false)
//           ? Padding(
//               padding: EdgeInsets.only(
//                 left: 15.h,
//                 right: 15.h,
//               ),
//               child:
//                   //(rTVTaskDetails.isEmpty) && (tags.length == 0)
//                   //  ?
//                   InkWell(
//                 onTap: () {
//                   startProgress = true;
//                   for (int x = 0; x < allresult.length; x++) {
//                     // allresult
//                     tags.add(allresult[x]['tag']);
//                   }
//                   //  })
//                   print(tags.length);
//                   // for (int p = 0; p < result.length; p++) {
//                   //   setState(() {
//                   //     tags.add(result[p]['tag']);
//                   //   });
//                   // }
//                   filterList();
//                   if (startProgress == false)
//                     Get.defaultDialog(
//                       title: "Success".tr,
//                       content: GestureDetector(
//                         onTap: () {
//                           Get.to(() => RtvSectionScreen(
//                               taskType: widget.taskType,
//                               place: widget.place,
//                               orderBy: widget.orderBy,
//                               //managerPhone: managerPhone, userName: userName, market: market, branch: branch, marketImage: marketImage, profileImage: profileImage, id: id, phone: phone, nationality: nationality, manegerName: manegerName))
//                               manegerName: widget.managerName,
//                               // tab_index: 2,
//                               userName: widget.username,
//                               marketImage: widget.marketImage,
//                               profileImage: widget.profileImage,
//                               market: widget.market,
//                               branch: widget.branch,
//                               id: widget.id,
//                               phone: widget.phone,
//                               //marketDetails:widget. marketDetails,
//                               nationality: widget.nationality,
//                               managerPhone: widget.managerPhone));
//                         },
//                         // child: (rTVTaskDetails.length > 0)
//                         // ? DefualtButton(selected: true, text: 'View List'.tr)
//                         //     : DefualtButton(selected: false, text: 'Fail'.tr)
//                         //Text("Fail"),
//                       ),
//                     );
//                 },
//                 child: DefualtButton(selected: true, text: 'Review'.tr),
//               )
//               //  : null,
//               )
//           : null,
//       body: (startProgress == false)
//           ? ListView(
//               shrinkWrap: true,
//               children: [
//                 Stack(
//                   fit: StackFit.loose,
//                   children: [
//                     AspectRatio(
//                       aspectRatio: controller.value.aspectRatio,
//                       child: CameraPreview(controller),
//                     ),
//                     ...displayBoxesAroundRecognizedObjects(size),
//                     Positioned(
//                       bottom: 75,
//                       width: MediaQuery.of(context).size.width,
//                       child: Container(
//                         height: 80,
//                         width: 80,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                               width: 5,
//                               color: Colors.white,
//                               style: BorderStyle.solid),
//                         ),
//                         child: isDetecting
//                             ? IconButton(
//                                 onPressed: () async {
//                                   await stopDetection();
//                                 },
//                                 icon: const Icon(
//                                   Icons.stop,
//                                   color: Colors.red,
//                                 ),
//                                 iconSize: 50,
//                               )
//                             : IconButton(
//                                 onPressed: () async {
//                                   await startDetection();
//                                 },
//                                 icon: const Icon(
//                                   Icons.play_arrow,
//                                   color: Colors.white,
//                                 ),
//                                 iconSize: 50,
//                               ),
//                       ),
//                     ),
//                     // if(yoloResults.length>0&&isDetecting==false)
//                     //   Positioned(
//                     //     bottom: 15,
//                     //     width: MediaQuery.of(context).size.width,
//                     //     child: Container(
//                     //         height: 80,
//                     //         width: 80,
//                     //         decoration: BoxDecoration(
//                     //           shape: BoxShape.circle,
//                     //           border: Border.all(
//                     //               width: 5, color: Colors.white, style: BorderStyle.solid),
//                     //         ),
//                     //         child:
//                     //allresult.length>0&&isDetecting==false
//                     // isDetecting
//                     //     ? IconButton(
//                     //   onPressed: ()  {
//                     //   //  await stopDetection();
//                     //   },
//                     //   icon: const Icon(
//                     //     Icons.stop,
//                     //     color: Colors.red,
//                     //   ),
//                     //   iconSize: 50,
//                     // )
//                     //     :
//                     // ?
//                     //       IconButton(
//                     //         onPressed: ()  {
//                     //           setState(() {
//                     //             startProgress=true;
//                     //             for(int x=0;x<allresult.length;x++)
//                     //             {
//                     //               // allresult
//                     //               tags.add(allresult[x]['tag']);
//                     //             }
//                     //           });
//                     //           print(tags.length);
//                     //           // for (int p = 0; p < result.length; p++) {
//                     //           //   setState(() {
//                     //           //     tags.add(result[p]['tag']);
//                     //           //   });
//                     //           // }
//                     //           filterList();
//                     //           if(startProgress==false)
//                     //           Get.defaultDialog(title: "Success".tr,
//                     //           content: GestureDetector(
//                     //               onTap: (){
//                     //                 Get.to(()=>RtvSectionScreen(
//                     //                     taskType: widget.taskType,
//                     //                     place: widget.place,
//                     //                     orderBy: widget.orderBy,
//                     //                     //managerPhone: managerPhone, userName: userName, market: market, branch: branch, marketImage: marketImage, profileImage: profileImage, id: id, phone: phone, nationality: nationality, manegerName: manegerName))
//                     //                     manegerName: widget.managerName,
//                     //                     // tab_index: 2,
//                     //                     userName: widget.username,
//                     //                     marketImage: widget.marketImage,
//                     //                     profileImage: widget
//                     //                         .profileImage,
//                     //                     market: widget.market,
//                     //                     branch: widget.branch,
//                     //                     id: widget.id,
//                     //                     phone: widget.phone,
//                     //                     //marketDetails:widget. marketDetails,
//                     //                     nationality: widget.nationality,
//                     //                     managerPhone: widget
//                     //                         .managerPhone
//                     //                 ));
//                     //                 // Get.to(()=> RTVWithAiReview(
//                     //                 //   taskType: widget.taskType,
//                     //                 //   // rtvProduct: rTVTaskDetails,
//                     //                 //   orderBy: widget.orderBy,
//                     //                 //   //imageSrc: ,
//                     //                 //   manegerName: widget.managerName,
//                     //                 //   phone: widget.phone,
//                     //                 //   managerPhone: widget.managerPhone,
//                     //                 //   market: widget.market,
//                     //                 //   marketImage: widget.marketImage,
//                     //                 //   username: widget.username,
//                     //                 //   profileImage: widget.profileImage,
//                     //                 //   place:widget.place,
//                     //                 //   nationality: widget.nationality,
//                     //                 //   branch: widget.branch,
//                     //                 //   id: widget.id,
//                     //                 // ));
//                     //               },
//                     //               child: DefualtButton(text: "Review".tr, selected: true))
//                     //           );
//                     //
//                     //           // startDetection();
//                     //         },
//                     //         icon: const Icon(
//                     //           Icons.add,
//                     //           color: kprimaryColor,
//                     //         ),
//                     //         iconSize: 50,
//                     //       )
//                     //     //:null,
//                     //   ),
//                     //  ),
//                   ],
//                 ),
//                 for (int x = 0; x < allresult.length; x++)
//                   SingleChildScrollView(
//                       physics: PageScrollPhysics(),
//                       child: Text(allresult[x]["tag"]))
//               ],
//             )
//           : buildProgress(),
//     );
//   }
//
//   void filterList() {
// //    var ascading = resJson..sort();
//     for (int h = 0; h < tags.length; h++) {
//       tags.sort((a, b) => a.compareTo(b));
//     }
//     print(tags.length);
//     for (int k = 0; k < tags.length; k++) {
//       // tags.sort((a,b)=>a.compareTo(b));
//       // print(tags[k]);
//       if (!selectedJsonProducts.contains(tags[k])) {
//         setState(() {
//           selectedJsonProducts.add(tags[k]);
//           selectedNewJsonProducts.add(tags[k]);
//           newJson.add(JsonProduct(product: tags[k], prAmount: 1));
//         });
//       } else {
//         for (int x = 0; x < selectedJsonProducts.length; x++) {
//           if (newJson[x].product == tags[k]) {
//             setState(() {
//               newJson[x].prAmount = newJson[x].prAmount + 1;
//             });
//           } else {}
//         }
//       }
//     }
//
//     print("..........");
//
//     for (int p = 0; p < newJson.length; p++) {
//       getId(int.parse(newJson[p].product), newJson[p].prAmount);
//     }
//     setState(() {
//       startProgress = false;
//     });
//     print(newJson.length);
//     newJson = [];
//     selectedJsonProducts = [];
//     selectedNewJsonProducts = [];
//     print(rTVTaskDetails.length);
//     // if(rTVTaskDetails.length>0
//     // &&startProgress==false)
//     // Get.to(()=> RTVWithAiReview(
//     //   taskType: widget.taskType,
//     //   // rtvProduct: rTVTaskDetails,
//     //   orderBy: widget.orderBy,
//     //   //imageSrc: ,
//     //   manegerName: widget.managerName,
//     //   phone: widget.phone,
//     //   managerPhone: widget.managerPhone,
//     //   market: widget.market,
//     //   marketImage: widget.marketImage,
//     //   username: widget.username,
//     //   profileImage: widget.profileImage,
//     //   place:widget.place,
//     //   nationality: widget.nationality,
//     //   branch: widget.branch,
//     //   id: widget.id,
//     // ));
//   }
//
//   List<String> tags = [];
//   Future getId(int id, int amount) async {
//     await FirebaseFirestore.instance
//         .collection("arrow_products")
//         .where("id", isEqualTo: id)
//         .limit(700)
//         .get()
//         .then((snapshot) {
//       snapshot.docs.forEach((element) {
//         FirebaseFirestore.instance
//             .collection("arrow_products")
//             .doc(element.reference.id)
//             .get()
//             .then((value) {
//           Map<String, dynamic> data = value.data() as Map<String, dynamic>;
//           //  for (int k = 0; k < data.length; k++)
//           {
//             if (data['id'] == (id)) {
//               setState(() {
//                 rTVTaskDetails.add(RTVProduct(
//                   rType: widget.taskType,
//                   image: data['photo'],
//                   barCode: data['product_item_code'],
//                   prCategory: data['category'],
//                   product: data['product_name'] + "\t" + "${data["weight"]}",
//                   prAmount: amount,
//                   //pType:"Piece"
//                 ));
//
//                 print(
//                   data['product_name'] + "\t" + "${data["weight"]}",
//                 );
//               });
//             }
//           }
//         });
//       });
//     });
//     // for (int i = 0; i < rTVTaskDetails.length; i++) {
//   }
//
//   Future<void> loadYoloModel() async {
//     try {
//       await vision.loadYoloModel(
//         labels: 'assets/label.txt',
//         modelPath: 'assets/yolos.tflite',
//         modelVersion: "yolov8",
//         numThreads: 1,
//         useGpu: true,
//       );
//       setState(() {
//         isLoaded = true;
//       });
//     } catch (e) {
//       print("Error loading YOLO model: $e");
//     }
//   }
//
//   Future<void> yoloOnFrame(CameraImage cameraImage) async {
//     try {
//       final result = await vision.yoloOnFrame(
//         bytesList: cameraImage.planes.map((plane) => plane.bytes).toList(),
//         imageHeight: cameraImage.height,
//         imageWidth: cameraImage.width,
//         iouThreshold: 0.4,
//         confThreshold: 0.4,
//         classThreshold: 0.5,
//       );
//       if (result.isNotEmpty) {
//         setState(() {
//           yoloResults = result;
//           allresult.addAll(result); // Append new results
//         });
//       }
//     } catch (e) {
//       print("Error during YOLO detection: $e");
//     }
//   }
//
//   Future<void> startDetection() async {
//     setState(() {
//       isDetecting = true;
//     });
//     if (controller.value.isStreamingImages) {
//       return;
//     }
//     await controller.startImageStream((image) async {
//       if (isDetecting) {
//         cameraImage = image;
//         await yoloOnFrame(image);
//       }
//     });
//   }
//
//   Future<void> stopDetection() async {
//     print("all result *************************************************");
//     print(allresult);
//     setState(() {
//       isDetecting = false;
//       yoloResults.clear();
//     });
//     await controller.stopImageStream();
//   }
//
//   bool startProgress = false;
//   UploadTask? uploadTask;
//
//   // UploadTask? uploadTask;
//   // bool progress = false;
//   // bool doneTask = false, uploadDone = false, startProgress = false;
//   Widget buildProgress() => StreamBuilder<TaskSnapshot>(
//       stream: uploadTask?.snapshotEvents,
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Text(' Error ya Ahmed :: ${snapshot.error}');
//         } else if (snapshot.hasData) {
//           final task = snapshot.data!;
//           double progress = task.bytesTransferred / task.totalBytes;
//
//           return Padding(
//             padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
//             child: SizedBox(
//               height: 50,
//               child: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   LinearProgressIndicator(
//                     value: progress,
//                     backgroundColor: kprimaryColor,
//                     color: Colors.grey,
//                   ),
//                   //  ((progress / 100 )!=1)?
//                   Center(
//                     child: Text('${(100 * progress).roundToDouble()}%'),
//                   )
//                 ],
//               ),
//             ),
//           );
//         } else {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//       });
// }
