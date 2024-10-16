// import 'dart:io';
//
// import 'package:arrow_merchandising/android/merchandiser/home/main%20data/daily_task_screen.dart';
// import 'package:arrow_merchandising/android/merchandiser/home/main%20data/merch_home.dart';
// import 'package:arrow_merchandising/android/merchandiser/profile/merchandiser_container.dart';
// import 'package:arrow_merchandising/android/splash/auth_page.dart';
// import 'package:arrow_merchandising/models/ai_share_model.dart';
// import 'package:arrow_merchandising/models/share_of_shel_model.dart';
//
// import 'package:arrow_merchandising/models/share_products.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import '../../../../../Android/merchandiser/merch_nav_bar.dart';
// import '../../../../components/default_button.dart';
// import 'package:arrow_merchandising/const.dart';
//
//
// class  ShareOfShelves extends StatefulWidget {
//   final int id, phone, adminPhone;
//   final String username,
//       marketImage,
//       profileImage,
//       branch,
//       product,
//       market,
//       nationality,
//       manegerName;
//   const ShareOfShelves(
//       {super.key,
//       required this.product,
//       required this.username,
//       required this.marketImage,
//       required this.profileImage,
//       required this.branch,
//       required this.market,
//       required this.id,
//       required this.phone,
//       required this.nationality,
//       required this.manegerName,
//       required this.adminPhone});
//
//   @override
//   State< ShareOfShelves> createState() => _ShareOfShelvesState();
// }
//
// class _ShareOfShelvesState extends State< ShareOfShelves> {
//   TextEditingController fullShaleAreaController = TextEditingController();
//   TextEditingController marketShaleAreaController = TextEditingController();
//
//   ScrollController _scrollController=ScrollController();
//
//   String productName="";
//   List<String> productsList = [];
//
//   Future getId() async {
//     await FirebaseFirestore.instance
//         .collection("products")
//         .get()
//         .then((snapshot) {
//       snapshot.docs.forEach((element) {
//         FirebaseFirestore.instance
//             .collection("products")
//             .doc(element.reference.id)
//             .get()
//             .then((value) {
//           Map<String, dynamic> data = value.data() as Map<String, dynamic>;
//           if(!productsList.contains(data['category'])) {
//             productsList.add(data['category']);
//             print(data['category']);
//             print(productsList.length);
//
//             // productImagesList.add('Photo');
//           }
//         });
//       });
//     });
//     print("\n");
//     print(productsList.length);
//   }
//
//   // String rtvImage="";
//   // //"https://firebasestorage.googleapis.com/v0/b/idias-concspts.appspot.com/o/profile_images%2Fmainlogo.png?alt=media&token=d8fa469a-e839-48e1-91a4-d112764b7ea7","
//   // File? imagepath;
//   //
//   // final imagePicker = ImagePicker();
//   // Future  getimage() async {
//   //   final image = await imagePicker.pickImage(source: ImageSource.camera);
//   //   setState(() {
//   //     imagepath = File(image!.path);
//   //   });
//   // }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     setState(() {
//        productName=widget.product;
//       // print(productName);
//       getId();
//     });
//
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//   }
//
//
// @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(backgroundColor: kprimaryColor,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top:10),
//               child: Column(
//                 //crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     widget.username,
//                     style: TextStyle(
//                         fontSize: 15, fontWeight: FontWeight.bold
//                       //fontFamily: PdfGoogleFonts.alefBold()
//                     ),
//                   ),
//                   SizedBox(
//                     height: 8,
//                   ),
//                   Text(
//                     '${widget.phone}',
//                     style: TextStyle(
//                         fontSize: 15,
//                         color: Colors.black.withOpacity(0.7)),
//                   )
//                 ],
//               ),
//             ),
//
//             SizedBox(
//                 width:10
//             ),
//
//             InkWell(
//               onTap: (){
//                 Get.offAll(()=>
//
//                      MerchNavBar(
//                        manegerName:widget.manegerName,
//                       username: widget.username,
//                       id: widget.id,
//                       phone: widget.phone,
//                       marketImage: widget.marketImage,
//                       profileImage: widget.profileImage,
//                       // city: city,
//                       //marketDetails: widget.marketDetails,
//                       nationality: widget.nationality,
//                       market: "All Markets",
//                       branch: "All Branches",
//                       mangerphone:widget.adminPhone,
//                     )
//                 );
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(top:10.0),
//                 child: Column(
//                   //crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Icon(Icons.home),
//                     // SizedBox(height: 8,),
//                     Text("Home".tr,
//                       style: TextStyle(
//                           fontSize: 15,
//                           color: Colors.black.withOpacity(0.7)
//                       ),),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               width:10,
//             ),
//             GestureDetector(
//               child: Padding(
//                 padding: const EdgeInsets.only(top:10.0),
//                 child: Column(
//                   //crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Icon(Icons.logout_outlined),
//                     //SizedBox(height: 8,),
//                     //children: [
//                     Text("log out".tr, style: TextStyle(
//                         fontSize: 15,
//                         color: Colors.black.withOpacity(0.7)
//                     ),),
//                   ],
//                 ),
//               ),
//               onTap: () {
//                 FirebaseAuth.instance.signOut();
//                 Get.offAll(AndroidAuthPage());
//               },
//             ),
//             SizedBox(
//               width:10,
//             ),
//           ],
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: ListView(
//             shrinkWrap: true,
//           controller: _scrollController,
//             children: [
//           SizedBox(
//             height: 10,
//           ),
//           AndroidMerchandiserContainer(
//             branch: widget.branch,
//               managerPhone: widget.adminPhone,
//               nationality: widget.nationality,
//               //marketDetails: widget.marketDetails,
//               id: widget.id,
//               phone: widget.phone,
//               market: widget.market,
//               username: widget.username,
//               marketImage: widget.marketImage,
//               profileImage: widget.profileImage),
//           SizedBox(
//             height: 10,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left:20.0,right: 20.0),
//             child: Container(
//               width: MediaQuery.of(context).size.height-60,
//               decoration: BoxDecoration(
//                   color: kprimaryColor.withOpacity(0.7),
//                   borderRadius: BorderRadius.circular(25)),
//               child: Center(
//                 child: Text(
//                   "Share of Shelves".tr,
//                   style: TextStyle(fontSize: 28),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//               (productName!=""||widget.product!="All Products")? Container(
//         height: 30,
//         width: MediaQuery.of(context).size.height,
//         decoration: BoxDecoration(
//           //color: kprimaryColor.withOpacity(0.7),
//             borderRadius: BorderRadius.circular(25)),
//         child: Center(
//           child: Text(
//             productName,
//             style: TextStyle(fontSize: 18),
//           ),
//         ),
//       ):
//               Padding(
//                 padding: const EdgeInsets.only(left:20.0,right:20,top:10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text("Selected Product".tr),
//                     Container(
//                       //padding: EdgeInsets.only(left: 20, right: 20),
//                       // width: double.infinity,
//                       width: 190,
//                       height: 50,
//                       decoration: BoxDecoration(
//                           border: Border.all(color: kprimaryColor),
//                           //color: kprimaryColor,
//                           //border: OutlinedBorder(side: ),
//                           borderRadius: BorderRadius.circular(15)),
//                       child: Autocomplete<String>(
//                         optionsBuilder: (TextEditingValue textEditingValue) {
//                           if (textEditingValue.text == '') {
//                             return const Iterable<String>.empty();
//                           }
//                           return productsList.where((String items) {
//                             return items.contains(textEditingValue.text.toUpperCase());
//                           });
//                         },
//                         onSelected: (String item) {
//                           setState(() {
//                             productName = item;
//                             //getPhotoId(productName,);
//                           });
//
//                           // city=item;
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//              if (productName!=""||widget.product!="All Products")
//          Column(
//            children: [
//              Row(
//                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Padding(
//                    padding: EdgeInsets.only(left: 10),
//                    child: Card(
//                      child: Container(
//                          width: 170,
//                          height: 180,
//                          //padding: EdgeInsets.all(10),
//                          child: Column(
//                            children: [
//                              SizedBox(
//                                height: 20,
//                              ),
//                              Container(
//                                height: 50,
//                                child: TextFormField(
//                                  controller: fullShaleAreaController,
//                                  keyboardType: TextInputType.numberWithOptions(
//                                    decimal: true,
//                                    signed: false,
//                                  ),
//                                  decoration: InputDecoration(
//                                    floatingLabelBehavior:
//                                    FloatingLabelBehavior.always,
//                                    border: OutlineInputBorder(
//                                      borderRadius: BorderRadius.circular(15),
//                                      borderSide: BorderSide(color: kTextColor),
//                                    ),
//                                    // fillColor: kprimaryColor,
//                                    // filled: true,
//                                    labelText: 'Shelve Full Area'.tr,
//                                  ),
//                                  validator: (value) {
//                                    if (value!.isEmpty) {
//                                      return "Can't Be Empty".tr;
//                                    }
//                                  },
//                                  onChanged: ((newValue) => fullArea = double.parse(
//                                      fullShaleAreaController.text.trim())),
//                                ),
//                              ),
//                              SizedBox(
//                                height: 10,
//                              ),
//                              Text('Full Area'.tr +
//                                  "\t" +
//                                  fullArea.toString() +
//                                  'Cm'.tr),
//                            ],
//                          )),
//                    ),
//                  ),
//                  Padding(
//                    padding: EdgeInsets.only(right: 10),
//                    child: Card(
//                      child: Container(
//                          width: 170,
//                          height: 180,
//                          //padding: EdgeInsets.all(10),
//                          child: Column(
//                            children: [
//                              SizedBox(
//                                height: 5,
//                              ),
//                              Text('Full Area'.tr),
//                              SizedBox(
//                                height: 10,
//                              ),
//                              (imagePath1!=null)?
//                                Container(
//                                    width: MediaQuery.of(context).size.width,
//                                    height: 130,
//                                    child:  Padding(
//                                        padding: const EdgeInsets.only(left:8.0,right: 8.0),
//                                        child: Image.file(imagePath1!))):
//                              //   SizedBox(
//                              //     height: 5,
//                              //   ),
//                              // ] else ...[
//                                MaterialButton(
//                                    onPressed: () {
//                                      getFirstImage();
//                                    },
//                                    child: Container(
//                                      padding: EdgeInsets.all(5),
//                                      decoration: BoxDecoration(
//                                          color: kprimaryColor,
//                                          borderRadius: BorderRadius.circular(25)),
//                                      width: double.infinity,
//                                      height: 50,
//                                      child: Center(
//                                        child: Text(
//                                          'Take A Picture'.tr,
//                                          style: TextStyle(
//                                            fontWeight: FontWeight.bold,
//                                            fontSize: 15,
//                                            color: Colors.white,
//                                          ),
//                                        ),
//                                      ),
//                                      // ),
//                                    )
//                                )
//
//                                //DefualtButton(text: 'Take A photo'.tr)),
//                              ]
//                           // ],
//                          )),
//                    ),
//                  ),
//                ],
//              ),
//              Row(
//                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Padding(
//                    padding: EdgeInsets.only(left: 10),
//                    child: Card(
//                      child: Container(
//                          width: 170,
//                          height: 180,
//                          //padding: EdgeInsets.all(10),
//                          child: Column(
//                            children: [
//                              SizedBox(
//                                height: 20,
//                              ),
//                              Container(
//                                height: 50,
//                                child: TextFormField(
//                                  keyboardType: TextInputType.numberWithOptions(
//                                    decimal: true,
//                                    signed: false,
//                                  ),
//                                  controller: marketShaleAreaController,
//                                  decoration: InputDecoration(
//                                    floatingLabelBehavior:
//                                    FloatingLabelBehavior.always,
//                                    border: OutlineInputBorder(
//                                      borderRadius: BorderRadius.circular(15),
//                                      borderSide: BorderSide(color: kTextColor),
//                                    ),
//                                    // fillColor: kprimaryColor,
//                                    // filled: true,
//                                    labelText: 'Market Area'.tr,
//                                  ),
//                                  validator: (value) {
//                                    if (value!.isEmpty) {
//                                      return "Can't Be Empty".tr;
//                                    }
//                                  },
//                                  onChanged: ((newValue) => markerArea =
//                                      double.parse(
//                                          marketShaleAreaController.text.trim())),
//                                  //  onSaved: ((value) => ),
//                                ),
//                              ),
//                              SizedBox(
//                                height: 20,
//                              ),
//                              Text('Market Area'.tr +
//                                  "  " +
//                                  markerArea.toString() +
//                                  'Cm'.tr),
//                            ],
//                          )),
//                    ),
//                  ),
//                  Padding(
//                    padding: EdgeInsets.only(right: 10),
//                    child: Card(
//                      child: Container(
//                          width: 170,
//                          height: 180,
//                          //padding: EdgeInsets.all(10),
//                          child: Column(
//                            children: [
//                              SizedBox(
//                                height: 5,
//                              ),
//                              Text('Market Area'.tr),
//                              SizedBox(
//                                height: 10,
//                              ),
//                              (imagePath2!=null)?
//                                Container(
//                                    width: MediaQuery.of(context).size.width,
//                                    height: 130,
//                                    child: Padding(
//                                      padding: const EdgeInsets.only(left:8.0,right: 8.0),
//                                      child: Image.file(imagePath2!),
//                                     )):
//                                // SizedBox(
//                                //   height: 5,
//                                // ),
//
//                                MaterialButton(
//                                    onPressed: () {
//                                      getSecondImage();
//                                    },
//                                    child: Container(
//                                      padding: EdgeInsets.all(5),
//                                      decoration: BoxDecoration(
//                                          color: kprimaryColor,
//                                          borderRadius: BorderRadius.circular(25)),
//                                      width: double.infinity,
//                                      height: 50,
//                                      child: Center(
//                                        child: Text(
//                                          'Shelve Picture'.tr,
//                                          style: TextStyle(
//                                            fontWeight: FontWeight.bold,
//                                            fontSize: 15,
//                                            color: Colors.white,
//                                          ),
//                                        ),
//                                      ),
//                                      // ),
//                                    )
//                                ),
//                              ]
//                          //  ],
//                          )),
//                    ),
//                  ),
//                ],
//              ),
//            ],
//          ),
//               if((markerArea!=0.0)&&(fullArea!=0.0))
//           Container(
//             child: Column(
//               children: [
//                 SizedBox(height: 5,),
//
//                 Text(
//                       'Share of Shelve'.tr +'\t'+
//                       (markerArea / fullArea * 100).toStringAsFixed(0)
//                   + "%",
//                   style: TextStyle(fontSize: 24),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                if(
//                       (imagePath1!=null)
//                    &&(imagePath2!=null)
//                    &&
//                    (productName!=""
//                    ||widget.product!="All Products"))
//                 MaterialButton(
//                   //child: DefualtButton(text: 'Save'.tr),
//                   onPressed: () async {
//                     await uploadImage(imagesAsFiles);
//
//                    //await uploadImage2();
//
//
//                     if (uploadDone==true)
//                     // {
//                       createRtVTask(
//                           ShareOfShelvesModel(
//                               place:,
//                               selectedProducts: productName,
//                               status: 'Done',
//                               branch: widget.branch,
//                               market: widget.market,
//                               madeBy: widget.username,
//                               taskDate: (DateFormat('yyyy-MM-dd')
//                                   .format(DateTime.now())
//                                   .toString()),
//                               taskTime: (DateFormat('kk:mm')
//                                   .format(DateTime.now())
//                                   .toString()),
//                               fullArea: fullArea.toDouble(),
//                               markerArea: markerArea.toDouble(),
//                               degree: fullArea/markerArea,
//                                imagePath1: imagePath1Str,
//                              // imagePath2: imagePath1Str
//                           )
//                       );
//
//                     if((doneTask=true)&&(uploadDone==true))
//                      // {
//                         Get.defaultDialog(
//                             title: " Success",
//                             content: Column(
//                               children: [
//                                 // buildProgress(),
//                                 // if(uploadDone)
//                                 Column(
//                                     children: [
//                                       GestureDetector(
//                                           onTap: () {
//                                             workingOnShare=[];
//                                             //completeShelve.add("Shelve");
//                                             imagesAsFiles=[];
//                                             Get.offAll(() =>
//                                                 AndroidDailyTasksScreen(
//                                                     manegerName:widget.manegerName,
//                                                     username: widget.username,
//                                                     marketImage: widget
//                                                         .marketImage,
//                                                     profileImage: widget
//                                                         .profileImage,
//                                                     branch: widget.branch,
//                                                     market: widget.market,
//                                                     id: widget.id,
//                                                     phone: widget.phone,
//                                                     //marketDetails:widget. marketDetails,
//                                                     nationality: widget
//                                                         .nationality,
//                                                     adminPhone: widget
//                                                         .adminPhone)
//                                             );
//                                           },
//                                           child: DefualtButton(
//                                               text: 'Daily Tasks'.tr
//                                                   .toUpperCase())),
//                                       SizedBox(height: 20,),
//                                       GestureDetector(
//                                           onTap: () {
//                                             //completeShelve.add("Shelve");
//                                             workingOnShare=[];
//                                             imagesAsFiles=[];
//                                             Get.offAll(() =>
//                                                  MerchNavBar(
//                                                      manegerName:widget.manegerName,
//                                                     username: widget.username,
//                                                     marketImage: widget
//                                                         .marketImage,
//                                                     profileImage: widget
//                                                         .profileImage,
//                                                     market: "All Markets",
//                                                     branch: "All Branches",
//                                                     id: widget.id,
//                                                     phone: widget.phone,
//                                                     //marketDetails:widget. marketDetails,
//                                                     nationality: widget
//                                                         .nationality,
//                                                     mangerphone: widget
//                                                         .adminPhone)
//                                             );
//                                             // Get.to(()=>AddCarFirstScreen(
//                                             //  business: widget.business,
//                                             //  ));
//                                           },
//                                           child: DefualtButton(
//                                               text: 'Home'.tr.toUpperCase()
//                                           )
//                                       ),
//                                       SizedBox(height: 20,),
//                                     ])
//                               ],
//                             )
//                         );
//                       //}
//                     //}
//                   },
//                     child: Padding(
//                       padding: const EdgeInsets.only(left:20.0,right:20,bottom: 10),
//                       child: DefualtButton(
//
//                         text: 'Create Task'.tr,
//                       ),
//                     )
//
//                   //  ؟؟++++++؟؟ـ-ـ§
//                 ),
//                   if(startProgress==true)
//                   buildProgress(),
//                 SizedBox(height: 20,)
//               ]
//             )
//           )
//         ]),
//       ),
//     );
//   }
//
//   Future createRtVTask(ShareOfShelvesModel share) async {
//     final shareData =
//         FirebaseFirestore.instance.collection('Share Of Shelves').doc();
//     final json = share.tojson();
//     await shareData.set(json);
//       doneTask=true;
//
//     //  final
//   }
//   //bool doneTask=false;
//
//   double fullArea = 0.0,
//       markerArea = 0.0;
//
//   File? imagePath1=null, imagePath2=null;
//   String imagePath1Str="",imagePath2Str="";
//   List< File?> imagesAsFiles=[];
//   //File? imagepath;
//
//  final imagePicker = ImagePicker();
//
//   Future  getFirstImage() async {
//     final image = await imagePicker.pickImage(source: ImageSource.camera);
//     setState(() {
//       imagePath1=(File(image!.path));
//       imagesAsFiles.add((File(image!.path)));
//     });
//   }
//
//
//   Future  getSecondImage() async {
//     final image = await imagePicker.pickImage(source: ImageSource.camera);
//     setState(() {
//       imagePath2 = File(image!.path);
//       imagesAsFiles.add((File(image!.path)));
//     });
//     // return imagepath!.path;
//   }
//   bool doneTask=false,uploadDone=false,startProgress=false;
//   UploadTask? uploadTask;
//
//   Future uploadImage(List<File?> myImagePath) async {
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
//         if(strCarPhotosList.length==myImagePath.length)
//           setState(() {
//             //uploadDone=true;
//            // startProgress=false;
//           });
//
//         // });
//       });
//       strCarPhotosList.add(await snapShot.ref.getDownloadURL());
//       setState(() {
//         uploadTask = ref.putFile(file);
//       });
//     }
//     setState(() {
//       if(strCarPhotosList.length==myImagePath.length) {
//         imagePath1Str = strCarPhotosList[0];
//         imagePath2Str = strCarPhotosList[1];
//         uploadDone = true;
//         startProgress = false;
//       }
//     });
//
//     //print(uploadDone);
//
//   }
//
//   List<String>strCarPhotosList=[];
//   //   for (int i = 0; i < myImagePath.length; i++)
//   //   {
//   //     final file = File(myImagePath[i]!.path!);
//   //     final ref =
//   //     FirebaseStorage.instance
//   //         .ref().child("Share Of Shelves/"+DateTime.now().toString()+".png");
//   //     setState(() {
//   //       startProgress = true;
//   //       uploadTask = ref.putFile(file);
//   //     });
//   //     final snapShot = await uploadTask!.whenComplete(() {
//   //       if(imagePath1Str.length==myImagePath.length)
//   //         setState(() {
//   //           uploadDone=true;
//   //           startProgress=false;
//   //         });
//   //
//   //       // });
//   //     });
//   //     imagePath1Str=await snapShot.ref.getDownloadURL();
//   //     setState(() {
//   //       uploadTask = ref.putFile(file);
//   //     });
//   //   }
//   //   setState(() {
//   //     if(imagePath1Str!=""&&imagePath2Str!="") {
//   //       uploadDone = true;
//   //       startProgress = false;
//   //     }
//   //   });
//   // }
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
// }
//
//
