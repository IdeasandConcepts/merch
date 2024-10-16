// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors


import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:arrow_merchandising/const.dart';
import '../../../../splash/auth_page.dart';
import '../../../merch_nav_bar.dart';
import '../../../profile/merchandiser_container.dart';


class AndroidFullPlonogramTaskDetails extends StatefulWidget {
  final int id, phone, adminPhone;
  final String marketImage,
      profileImage,
      username,manegerName,
      branch,
  //city,
      market,
      nationality;
  //marketDetails;;
final String firstPhoto,secondPhoto;
  const AndroidFullPlonogramTaskDetails({
    super.key,
    required this.marketImage,
    required this.profileImage,
    required this.username,
    required this.branch,
    required this.market,
    required this.id,
    required this.phone,
    required this.nationality,
    //required this.marketDetails,
    required this.adminPhone,
    required this.firstPhoto,
    required this.secondPhoto, required this.manegerName,
    //required this.merchPlanogramModel,

  });

  @override
  State<AndroidFullPlonogramTaskDetails> createState() =>
      _AndroidFullPlonogramTaskDetailsState();
}

class _AndroidFullPlonogramTaskDetailsState
    extends State<AndroidFullPlonogramTaskDetails> {
  String secondImage='';

  File? imagepath;

  final imagePicker = ImagePicker();

  Future getimage() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    // await ImagePicker.getImage(
    //   source: ImageSource.camera);
    setState(() {
      imagepath = File(image!.path);
      FirebaseStorage.instance
          .ref()
          .child('planogram/secondImage'+DateTime.now().toString()+'.png')
          .putFile(imagepath!)
          .then((TaskSnapshot taskSnapshot) {
        if (taskSnapshot.state == TaskState.success) {
          print("Image uploaded Successful");
          // Get Image URL Now
          taskSnapshot.ref.getDownloadURL().then((imageURL) {
            setState(() {
              secondImage = imageURL.toString();
            });
            // firstphotopath = imageURL.toString();
            print("Image Download URL is $secondImage");
            //return pathString;
          });
        } else if (taskSnapshot.state == TaskState.running) {
          // Show Prgress indicator
        } else if (taskSnapshot.state == TaskState.error) {
          // Handle Error Here
          // print("Error in $TaskState.error");
        }
      });

    });
  }
  double matchdegree=0.0 ,defrencedegree=0.0;

  PlatformFile? pickedFile;

  Future selectFile() async {
    final photo = await FilePicker.platform.pickFiles();
    if (photo == null) return;
    setState(() {
      pickedFile = photo.files.first;
      FirebaseStorage.instance
          .ref()
          .child('planogram/secondImage'+DateTime.now().toString()+'.png')
          .putFile(imagepath!)
          .then((TaskSnapshot taskSnapshot) {
        if (taskSnapshot.state == TaskState.success) {
          print("Image uploaded Successful");
          // Get Image URL Now
          taskSnapshot.ref.getDownloadURL().then((imageURL) {
            setState(() {
              secondImage = imageURL.toString();
            });
            // firstphotopath = imageURL.toString();
            print("Image Download URL is $secondImage");
            //return pathString;
          });
        } else if (taskSnapshot.state == TaskState.running) {
          // Show Prgress indicator
        } else if (taskSnapshot.state == TaskState.error) {
          // Handle Error Here
          // print("Error in $TaskState.error");
        }
      });

      //imagepath = photo.files.first as File?;
    });
  }

  bool switchVal = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: kprimaryColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(top:10),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.username,
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold
                        //fontFamily: PdfGoogleFonts.alefBold()
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      '${widget.phone}',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black.withOpacity(0.7)),
                    )
                  ],
                ),
              ),

              SizedBox(
                  width:10
              ),

              InkWell(
                onTap: (){
                  Get.to(()=>
                      MerchNavBar(
                        tab_index: 2,
                        manegerName: widget.manegerName,
                        username: widget.username,
                        id: widget.id,
                        phone: widget.phone,
                        marketImage: widget.marketImage,
                        profileImage: widget.profileImage,
                        // city: city,
                       // marketDetails: widget.marketDetails,
                        nationality: widget.nationality,
                        market: widget.market,
                        // user: username,
                        branch: "All Branches",
                        mangerphone:widget.adminPhone,
                      )
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(top:10.0),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.home),
                      // SizedBox(height: 8,),
                      Text("Home".tr,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black.withOpacity(0.7)
                        ),),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width:10,
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(top:10.0),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.logout_outlined),
                      //SizedBox(height: 8,),
                      //children: [
                      Text("log out".tr, style: TextStyle(
                          fontSize: 15,
                          color: Colors.black.withOpacity(0.7)
                      ),),
                    ],
                  ),
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Get.offAll(AndroidAuthPage());
                },
              ),
              SizedBox(
                width:10,
              ),
            ],
          ),
          centerTitle: true,
        ),
      //appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(height: 40),
              AndroidMerchandiserContainer(
                branch:widget. branch,
                nationality: widget.nationality,
                //marketDetails: widget.marketDetails,
                id: widget.id,
                phone: widget.phone,
                market: widget.market,
                username: widget.username,
                marketImage: widget.marketImage,
                profileImage: widget.profileImage,
                managerPhone: widget.adminPhone,),
              //SizedBox(height: 8),
              // Text(
              //   "69".tr,
              //   style: TextStyle(fontWeight: FontWeight.bold),
              //   textAlign: TextAlign.center,
              // ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    // Text(
                    //     '-------------------         Planogram         --------------------'),
                    SizedBox(
                      height: 15,
                    ),
                    // Container(
                    //   //height: 250,
                    //   //width: 280,
                    //   color: kprimaryColor.withOpacity(0.45),
                    //   child: DataTable(
                    //     columns: [
                    //       DataColumn(label: Text('Selected Branch'.tr)),
                    //       DataColumn(
                    //           label: Text(widget.merchPlanogramModel.branch)),
                    //     ],
                    //     rows: [
                    //       DataRow(cells: <DataCell>[
                    //         DataCell(Text('Super Market'.tr)),
                    //         DataCell(Text(widget.merchPlanogramModel.market)),
                    //       ]),
                    //       // DataRow(cells: <DataCell>[
                    //       //   DataCell(Text('merchandiser name'.tr)),
                    //       //   DataCell(Text(branch)),
                    //       // ]),
                    //       DataRow(cells: <DataCell>[
                    //         DataCell(Text(
                    //           'Made By'.tr + ': ',
                    //         )),
                    //         DataCell(Text(
                    //           widget.merchPlanogramModel.madeBy,
                    //         )),
                    //       ]),
                    //       DataRow(cells: <DataCell>[
                    //         DataCell(Text('task date'.tr)),
                    //         DataCell(Text(widget.merchPlanogramModel.date)),
                    //       ]),
                    //       // DataRow(cells: <DataCell>[
                    //       //   DataCell(Text('Selected product'.tr)),
                    //       //   DataCell(Text(product)),
                    //       // ]),
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                    Container(
                      width: 280,
                      height: 170,
                      // color: kprimaryColor.withOpacity(0.45),
                      child: Image.network(widget.firstPhoto),
                      //NetworkImage(),
                    ),
                  ],
                ),
                // Image.asset(imageassets),
              ),

              const SizedBox(height: 18.0),

//               InkWell(
//                 onTap: () {
//                   updateData();
//                   // Edit data in data base
//                   Get.defaultDialog(
//                       content: Column(
//                         children: [
//                           Text('When you finish click ok'.tr),
//                           MaterialButton(
//                             onPressed: (){
//                               Get.defaultDialog(
//                                   title: "Select photo From ...",
//                                   content: Column(children: [
//                                     MaterialButton(
//                                       onPressed: () {
//                                         getimage();
//
//
//                                         // for(int i=0;i<strCarPhotosList.length;i++)
//                                         //   print(strCarPhotosList[i]+'\n');
//                                         //Get.back(closeOverlays: true);
//
//                                         // Open camera
//                                       },
//                                       child: Container(
//                                         padding: EdgeInsets.all(5),
//                                         width: 180,
//                                         height: 50,
//                                         decoration: BoxDecoration(
//                                             color: kprimaryColor,
//                                             borderRadius: BorderRadius.circular(15),
//                                             border: Border.all()),
//                                         child: Center(child: Row(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           children: [
//                                             Text("From Camera"),
//                                             Icon(Icons.navigate_next)
//
//                                           ],
//                                         )),
//                                         // ),
//                                       ),
//                                     ),
// // end of acmera
//
//                                     SizedBox(height: 20,),
//                                     MaterialButton(
//                                       onPressed: () {
//                                         // Open Files
//                                         selectFile();
//
//                                         // double matchdegree=widget.merchPlanogramModel.matchdegree;
//                                         // matchdegree=98.0;
//                                         // double defrence=widget.merchPlanogramModel.matchdegree;
//                                         //defrence=1.9;
//                                         //"defrence":widget.merchPlanogramModel.deffrence
//                                         //  Get.back(closeOverlays: true);
//                                       },
//                                       child: Container(
//                                         padding: EdgeInsets.all(5),
//                                         width: 180,
//                                         height: 50,
//                                         decoration: BoxDecoration(
//                                             color: kprimaryColor,
//                                             borderRadius: BorderRadius.circular(15),
//                                             border: Border.all()),
//                                         child: Center(child: Row(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           children: [
//                                             Text("From gallery"),
//                                             Icon(Icons.navigate_next)
//                                           ],
//                                         )
//                                         ),
//                                       ),
//                                     ),
//                                     // End Of gallery
//
//                                   ])
//                               );
//                             },
//                             child: Center(child: DefualtButton(text: "Add Second Photo",),),
//                           ),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           customSwith('Running...', switchVal, OnChangFun),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           MaterialButton(
//                             onPressed: () {
//                               switchVal = !switchVal;
//                               //EditData if firebase
//
//                               updateDatatoFinish();
//
//
//                               // if (switchVal)
//                               // Get.back(
//                               //     // title: "",
//                               //     );
//                             },
//                             child: DefualtButton(text: 'finish'.tr),
//                           ),
//                         ],
//                       ));
//                   // Save Data ....
//                 },
//                 child: DefualtButton(
//                   text: 'Start'.tr,
//                 ),
//               ),
              // NoAcccountText()
            ],
          ),
        ));
  }

  Widget customSwith(String text, bool myValue, Function onchange) {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 20),
      child: Row(
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w800,
                fontFamily: 'Roboto',
                color: Colors.black),
          ),
          Spacer(),
          CupertinoSwitch(
              trackColor: Colors.grey,
              activeColor: kprimaryColor,
              value: myValue,
              onChanged: (newValue) {
                OnChangFun(newValue);
                //  onchange();
                //switchVal = !switchVal;
              })
        ],
      ),
    );
  }

  OnChangFun(bool val) {
    setState(() {
      switchVal = val;
      // v
    });
  }

  @override
  updateData() async {
    var user = await FirebaseFirestore.instance
        .collection('planogram')
        .where('branch', isEqualTo: widget.branch)
        .where('status', isEqualTo: 'not yet')
        .get();
    if (user.docs.isNotEmpty) {
      var doc_Id = user.docs.first.id;
      await FirebaseFirestore.instance
          .collection('planogram')
          .doc(doc_Id)
          .update({"status": "run"});

      //   print(doc_Id);
    }
  }

  @override
  updateDatatoFinish() async {
    var user = await FirebaseFirestore.instance
        .collection('planogram')
    // .where('madeBy', isEqualTo:widget.name)
        .where('branch', isEqualTo: widget.branch)
        .where('status', isEqualTo: 'run')
        .get();
    if (user.docs.isNotEmpty) {
      var doc_Id = user.docs.first.id;
      await FirebaseFirestore.instance
          .collection('planogram')
          .doc(doc_Id)
          .update(
          {"status": "done",
            "secondImage":secondImage,
            "matchdegree":matchdegree,
            "defrence":defrencedegree
          });

      print(doc_Id);
    }
  }
}
