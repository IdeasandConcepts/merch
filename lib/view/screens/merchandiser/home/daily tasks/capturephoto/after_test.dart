import 'dart:io';
import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/capturephoto/visit_review.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/profile/branch_appbar.dart';
import 'package:arrow_merchandising/view/widgets/custom_dropdown.dart';
import 'package:arrow_merchandising/models/capture_photos.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:arrow_merchandising/const.dart';
import '../../../../splash/indicator.dart';

class AndroidAfterPhoto extends StatefulWidget {
  final int id, phone, adminPhone;
  final String marketImage,
      profileImage,
      username,managerName,
      title,
      branch,
  //city,
      market,
      nationality;
  //marketDetails;
  // final List<String> conditionList;
  const AndroidAfterPhoto(
      {super.key,
        required this.managerName,
        required this.title,
        required this.marketImage,
        required this.profileImage,
        required this.username,
        required this.branch,
        required this.market,
        required this.id,
        required this.phone,
        required this.nationality,
        // required this.marketDetails,
        required this.adminPhone});

  @override
  State<AndroidAfterPhoto> createState() => _AndroidAfterPhotoState();
}

class _AndroidAfterPhotoState extends State<AndroidAfterPhoto>
    with TickerProviderStateMixin {
  // CapturePhotos? beforePhotosTaskDetails;
  // CapturePhotos? afterPhotosTaskDetails ;

  // List<String> strCarPhotosList = [];

  var _sellectedIndex = 0;

  List<String> places = [
    "On Shelves",
    "On Display",
    "On Gandola",
    "On Back Door"
  ];
  String selectedPlace = "On Shelves";
  List<String> categories = [];
  String selectedCategory = "All Categories";
  // List<String> productsList = [];
  // String selectedProduct = "";

  List<String> rtvType = [
    "Damaged Product's".tr,
    "Expired Product's".tr,
    "Near Expired Product's".tr
  ];
  String selectedRtvType = "Expired";

  List<String> productsCodesList = [];

  Future getId() async {
    await FirebaseFirestore.instance
        .collection("arrow_products")
        .orderBy("id", descending: false)
        .limit(700)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection("arrow_products")
            .doc(element.reference.id)
            .get()
            .then((value) {
          Map<String, dynamic> data = value.data() as Map<String, dynamic>;
          // for (int i = 0; i < data.length; i++) {
          if (categories.contains(data['category'])) {
          } else {
            setState(() {
              categories.add(data['category']);
            });
            //  });
          }
          // }
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      lastVisitTask=[];
      //lastVisitTaskDetails
      //lastVisitTaskDetails=[];
      getId();
      //productsList = allProducts;
    });
    //getId();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kprimaryColor,
          title:
          MerchAppBar(
            // appBar: MerchAppBar(
            title: "After Ordering",
            manegerName: widget.managerName,
            phone: widget.phone,
            market: widget.market,
            marketImage: widget.marketImage,
            branch: widget.branch,
            username: widget.username,
            profileImage: widget.profileImage,
          ) ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 12.h),

          ///  Filter
          Container(
            height: 120.h,
            width: MediaQuery.of(context).size.width,
            //378.w,
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              // border: Border.all(width: 1.w),
                borderRadius: BorderRadius.circular(10.r)),
            child: Column(children: [
              // Text("Filter",
              //     style: TextStyle(
              //         fontWeight: FontWeight.w700, fontSize: 28.sp)),
              // SizedBox(height: 12.h),

              // Shelve DropdownButton
              CustomDropdownButton(
                  onChanged: (value) {},
                  onTap: () {},
                  hintText: selectedPlace.tr,
                  items: List.generate(
                    places.length,
                        (index) =>
                    // null)[
                    DropdownMenuItem(
                        onTap: () {
                          setState(() {
                            selectedPlace = places[index];
                          });
                        },
                        value: 1,
                        child: Text("${places[index].tr}",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp))),
                  )),
              SizedBox(height: 12.h),
              // category
              CustomDropdownButton(
                  onChanged: (value) {},
                  onTap: () {},
                  hintText: selectedCategory.tr,
                  items: List.generate(
                    categories.length,
                        (index) =>
                    // null)[
                    DropdownMenuItem(
                        onTap: () {
                          setState(() {
                            selectedCategory = categories[index];
                          });
                        },
                        value: 1,
                        child: Text("${categories[index].tr}",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp))),
                  )),
            ]),
          ),
          // SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.all(5.h),
            child: Card(
              child: Container(
                  height: 350.h,
                  width: 320.w,
                  child: Center(
                    child: (imagePath.length == 0)
                        ? Icon(
                      Icons.add,
                      size: 320.sp,
                      color: Colors.white,
                    )
                        : Column(children: [
                      Container(
                        //padding: EdgeInsets.only(top: 10.h),
                        height: 300.h,
                        width: 320.w,
                        child: PageView.builder(
                            onPageChanged: (value) {
                              setState(() {
                                _sellectedIndex = value;
                              });
                            },
                            itemCount: imagePath.length,
                            itemBuilder: (context, index) {
                              var _scale =
                              _sellectedIndex == index ? 1.0 : 0.8;
                              return TweenAnimationBuilder(
                                duration:
                                const Duration(milliseconds: 3500),
                                //kAnimationDuration,
                                tween: Tween(begin: _scale, end: _scale),
                                curve: Curves.ease,
                                builder: (context, value, child) {
                                  return Transform.scale(
                                      scale: value, child: child);
                                },
                                child: Container(
                                    padding: EdgeInsets.all(10),
                                    // width: 65,
                                    // height: 80,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(30)),
                                    child: Image.file(imagePath[index]!)
                                  //)
                                ),
                              );
                            }),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ...List.generate(
                                  imagePath.length,
                                      (index) => Indicator(
                                      isActive: _sellectedIndex == index
                                          ? true
                                          : false
                                    // isActive: isActive
                                  )
                                // buildDot(index: index),
                              ),
                            ]),
                      ),
                      //),
                    ]),
                  )),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          GestureDetector(
            onTap: () async {
              await getImage();
            },
            child: Padding(
              padding: EdgeInsets.only(left: 50.h, right: 50.h,),
              child: DefualtButton(selected:false,text:  (imagePath.length == 0)
                  ? "Take A Picture".tr
                  : "Take Another Picture".tr,),
            ),
          ),
          SizedBox(height: 10.h,),
          if (selectedCategory!= "All Categories"&&imagePath.length>0)
            GestureDetector(

                child: Padding(
                  padding: EdgeInsets.only(left: 50.h, right: 50.h,),
                  child: DefualtButton(selected:false,text:"Add Product".tr,),
                ),
         // MaterialButton(
            onTap: () async {
                await uploadImage(imagePath);
              // firstVisitTaskDetails.add()
              if(!lastVisitTask.contains(CapturePhotos(
                place:selectedPlace,
                product: selectedCategory,
                images: strCarPhotosList,
                  taskTime:  (DateFormat('kk:mm')
                          .format(DateTime.now())
                          .toString()),
                  title: "After")
              )){
              lastVisitTask.add(CapturePhotos(
                place:selectedPlace,
                product: selectedCategory,
                images: strCarPhotosList,
                  taskTime:  (DateFormat('kk:mm')
                          .format(DateTime.now())
                          .toString()),title: "After"));
              }
              setState(() {
                selectedPlace="On Shelves";
                selectedCategory= "All Categories";
                imagePath=[];
                completeLastOrderingTask.add(selectedPlace);
              });

            },

          ),
          SizedBox(
            height: 10.h,
          ),


        ],
      ),
      bottomNavigationBar: (
          firstVisitTask.length>0)?
      Padding(


        // child: Padding(
          padding: EdgeInsets.only(left: 15.h, right: 15.h, ),
          child:
          InkWell(
            onTap: () {
              setState(() {
                // lastVisitTask.add(CapturePhotos(
                //     product: product, taskTime: taskTime, place: place, images: images, title: title))=
                //     Visit(visit: lastVisitTask, taskTime:  (DateFormat('kk:mm')
                //     .format(DateTime.now())
                //     .toString()),title: "After");
              });
              // firstVisitTaskDetails=Visit(
              //
              //     firstVisit: firstVisitTask, taskTime:  firstVisitTaskDetails.taskTime
              // // (DateFormat('kk:mm')
              // //     .format(DateTime.now()))
              // );

              Get.to(()=>VisitReview(

                  manegerName:widget. managerName,
                  marketImage: widget.marketImage,
                  profileImage:widget. profileImage,
                  username:widget. username,
                  branch:widget. branch,
                  market: widget.market,
                  id:widget.id,
                  phone: widget.phone,
                  nationality: widget.nationality,
                  adminPhone:widget. adminPhone));

            },
            child:(startProgress==false)? DefualtButton(
              selected: true,text:
            "View List".tr,):buildProgress(),
          )
      ):null,
    );
  }
  bool doneTask=false,uploadDone=false,startProgress=false;
  UploadTask? uploadTask;
  //String rtvImage="";

  Future uploadImage(List<File?> myImagePath) async {
    for (int i = 0; i < myImagePath.length; i++) {
      final file = File(myImagePath[i]!.path);
      final ref =
      FirebaseStorage.instance
          .ref().child(myImagePath[i]!.path);
      setState(() {
        startProgress = true;
        uploadTask = ref.putFile(file);
      });
      final snapShot = await uploadTask!.whenComplete(() {
        if(strCarPhotosList.length==myImagePath.length)
          setState(() {
            uploadDone=true;
            startProgress=false;
          });

        // });
      });
      strCarPhotosList.add(await snapShot.ref.getDownloadURL());
      setState(() {
        uploadTask = ref.putFile(file);
      });
    }
    setState(() {
      if(strCarPhotosList.length==myImagePath.length)
        uploadDone=true;
      startProgress=false;
    });
  }
//
  List<String> strCarPhotosList=[];
  List<File?> imagePath = [];

  final imagePicker = ImagePicker();

  Future getImage() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imagePath.add(File(image!.path));
    });
  }
//
  Widget buildProgress() =>
      StreamBuilder<TaskSnapshot>(
          stream: uploadTask?.snapshotEvents,
          builder: (context,snapshot)
          {
            if (snapshot.hasError) {
              return Text(' Error ya Ahmed :: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final task = snapshot.data!;
              double progress=task.bytesTransferred / task.totalBytes;

              return Padding(
                padding: const EdgeInsets.only(left:20.0,right:20,bottom: 10),
                child: SizedBox(
                  height: 50,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      LinearProgressIndicator(
                        value: progress,
                        backgroundColor: kprimaryColor,
                        color: Colors.grey,
                      ),
                      //  ((progress / 100 )!=1)?
                      Center(child: Text('${(100 * progress).roundToDouble()}%'),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child:
                CircularProgressIndicator(),
              );
            }
          }
      );

// List<File?> imagePath = [];
//
//   final imagePicker = ImagePicker();
//
//   Future getImage() async {
//     final image = await imagePicker.pickImage(source: ImageSource.camera);
//     setState(() {
//       imagePath.add(File(image!.path));
//     });
//   }
}
