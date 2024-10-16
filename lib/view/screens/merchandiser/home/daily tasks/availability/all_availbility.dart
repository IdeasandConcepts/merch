import 'dart:convert';
import 'dart:io';

import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/availability/availability.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/availability/video_detection.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/merch_nav_bar.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/profile/branch_appbar.dart';

import 'package:arrow_merchandising/view/screens/merchandiser/profile/profile_screen.dart';
import 'package:arrow_merchandising/models/availability_products.dart';
import 'package:arrow_merchandising/models/inventory_products.dart';
import 'package:arrow_merchandising/models/new_task.dart';
import 'package:arrow_merchandising/models/pricing_product.dart';
import 'package:arrow_merchandising/models/rtv_product.dart';
import 'package:arrow_merchandising/models/share_products.dart';
import 'package:arrow_merchandising/view/widgets/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:arrow_merchandising/const.dart';
import 'package:arrow_merchandising/const.dart';
import 'package:arrow_merchandising/models/availability_products.dart';

import 'package:arrow_merchandising/models/new_products.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;


class AvailabilityWithAi extends StatefulWidget {
  const AvailabilityWithAi({
    super.key,
    required this.managerPhone,
    required this.marketImage,
    required this.profileImage,
    required this.username,
    required this.branch,
    required this.market,
    required this.id,
    required this.phone,
    required this.nationality,
    required this.place,
    required this.managerName, required this.orderBy, required this.taskType,
     required this.category
  });
  final int id, phone, managerPhone;
  final String marketImage,
      profileImage,
      username,
      managerName,
      branch,
      market,
      nationality;
  final String place,category;
  final String orderBy,taskType;

  @override
  State<AvailabilityWithAi> createState() => _AvailabilityWithAiState();
}

class _AvailabilityWithAiState extends State<AvailabilityWithAi> {

 // late FlutterVision vision;

  File? selectedImage;
  String? message = "";
  String? greetings = '';
  //var resJson="";
  //List<String> resJson = [];
  List<String> resJson = [];

  List<String> places = [
    "On Shelves",
    "On Display",
    "On Gandola",
    "On Back Door"
  ];
  List<String> rtvType = [
    "Damaged Product's".tr,
    "Expired Product's".tr,
    "Near Expired Product's".tr
  ];
  String selectedRtvType = "Expired";
  String selectedPlace = "All Places";
  String selectedCategory = "All Categories";
  bool selectPlace = false;

  List<String> categories = [];
  late List<Map<String, dynamic>> yoloResults = [];
  int imageHeight = 1;
  int imageWidth = 1;
  //File? imageFile;
  List<dynamic>? label;
  bool isLoaded = false;
  List<String>tags=[];
  // Future<void> loadYoloModel() async {
  //   await vision.loadYoloModel(
  //     labels: 'assets/label.txt',
  //     modelPath: 'assets/yolos.tflite',
  //     modelVersion: "yolov8",
  //     quantization: false,
  //     numThreads: 1,
  //     useGpu: true,
  //   );
  //   setState(() {});
  // }
  // yoloOnImage() async {
  //   print('*****************');
  //   setState(() {
  //     startProgress = true;
  //   });
  //   newJson.clear();
  //   tags.clear();
  //   yoloResults.clear();
  //   Uint8List byte = await selectedImage!.readAsBytes();
  //   final image = await decodeImageFromList(byte);
  //   imageHeight = image.height;
  //   imageWidth = image.width;
  //   final result = await vision.yoloOnImage(
  //     bytesList: byte,
  //     imageHeight: image.height,
  //     imageWidth: image.width,
  //     iouThreshold: 0.8,
  //     confThreshold: 0.4,
  //     classThreshold: 0.5,
  //   );
  //   if (result.isNotEmpty) {
  //     setState(() {
  //       // jsonToList(jsonDecode(result.z);
  //       print(result);
  //       yoloResults = result;
  //       isLoaded = true;
  //     });
  //   }
  //   for (int p = 0; p < result.length; p++) {
  //     setState(() {
  //       tags.add(result[p]['tag']);
  //     });
  //   }
  //   filterList();
  //   setState(() {
  //     startProgress = false;
  //   });
  // }

  uploadImage() async {
    setState(() {
      startProgress = true;
    });
    // print("Error Hi");
    final request =
    await http.MultipartRequest("POST", Uri.parse("${urlApi}/upload"));
    final headers = {"Content-type": "multipart/from-data"};
    request.files.add(http.MultipartFile("image",
        selectedImage!.readAsBytes().asStream(), selectedImage!.lengthSync(),
        filename: selectedImage!.path.split("/").last));
    request.headers.addAll(headers);
    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);

    // message = resJson['message'];
    if (response.statusCode == 200) {
      //print("Error Hi");
      setState(() {
        resJson = jsonToList(jsonDecode(res.body));

      });
      print("class is : $resJson ");
    } else {
      print("Error ${response.statusCode}");
    }
    print(resJson.length);
    filterList();
    {
      setState(() {
        startProgress = false;
      });
    }
  }

  List<T> jsonToList<T>(Object? responseData) {
    final temp = responseData as List? ?? <dynamic>[];
    final list = <T>[];
    for (final tmp in temp) {
      list.add(tmp as T);
    }
    return list;
  }
  // File? imagePath;

  final imagePicker = ImagePicker();

  Future getCameraImage() async {
    resJson=[];
    availabilityTaskDetails=[];
    final image = await imagePicker.pickImage(source: ImageSource.camera,
        requestFullMetadata: true
    );
    setState(() {
      selectedImage = (File(image!.path));
      startProgress = false;
    });
  }

  Future getImage() async {
    setState(() {
      resJson=[];
      availabilityTaskDetails=[];
      //rTVTaskDetails=[];
      // rTVTaskDetails=[];
    });
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = File(pickedImage!.path);
    });
    // if(startProgress==true)
    //   {
    //     setState(() {
    //       startProgress=false;
    //     });
    //   }
  }


  Future getId(int id,int amount) async {
    await FirebaseFirestore.instance
        .collection("arrow_products")
        .where("id", isEqualTo: id)
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
          //  for (int k = 0; k < data.length; k++)
              {
            if (data['id'] == (id)) {
              setState(() {
                availabilityTaskDetails.add(AvailabilityProduct
                    (
                      //rType: selectedRtvType,
                      image: data['photo'],
                      weight: data['weight'],
                      prCategory: data['category'],
                      product: data['product_name'] + "\t" +
                          "${data["weight"]}",
                      prAmount: amount,
                      //pType:"Piece"
                    ));
              });
            }
          }
        });
      });
    });
    // for (int i = 0; i < rTVTaskDetails.length; i++) {
  }

  Future getCategories() async {
    await FirebaseFirestore.instance
        .collection("arrow_products")
    //.where("id", isEqualTo: int.parse(i))
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
          for (int i = 0; i < data.length; i++) {
            if (categories.contains(data['category'])) {
            } else {
              setState(() {
                categories.add(data['category']);
              });
            }
          }
        });
      });
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      selectedPlace=widget.place;
      selectedCategory=widget.category;
      getCategories();
      // vision = FlutterVision();
      // super.initState();
      // loadYoloModel().then((value) {
      //   setState(() {
      //     yoloResults = [];
      //     isLoaded = false;
      //   });
      // });
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
  // Future getId(List<String> allData) async {
  //   await FirebaseFirestore.instance
  //       .collection("arrow_products")
  //       .orderBy("id", descending: true)
  //       .limit(700)
  //       .get()
  //       .then((snapshot) {
  //     snapshot.docs.forEach((element) {
  //       FirebaseFirestore.instance
  //           .collection("arrow_products")
  //           .doc(element.reference.id)
  //           .get()
  //           .then((value) {
  //         Map<String, dynamic> data = value.data() as Map<String, dynamic>;
  //         {
  //           for(int i=0;i<allData.length;i++)
  //           if (!allProducts.contains(data['product_name']) &&
  //               !allWeights.contains(data['weight'].toDouble))
  //           setState(() {
  //
  //             if (!allProducts.contains(data['product_name']) &&
  //                 !allWeights.contains(data['weight'].toDouble))
  //               // allProducts.add(
  //               //     data['product_name']
  //               //   //  +"_"+'${data['weight']}'
  //               // );
  //               allProducts.add(data['product_name']);
  //             allWeights.add(data['weight'].toDouble());
  //             // print( '${data['id']}\t'+data['product_name']
  //             //     +"_"+'${data['weight']}');
  //           });
  //           // print(allProducts.length);
  //         }
  //       });
  //     });
  //   });
  //
  //   //print(allProducts.length);
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kprimaryColor,
          title:
          MerchAppBar(
            // appBar: MerchAppBar(
            title: "Availability Section",
            manegerName: widget.managerName,
            phone: widget.phone,
            market: widget.market,
            marketImage: widget.marketImage,
            branch: widget.branch,
            username: widget.username,
            profileImage: widget.profileImage,
          ) ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 12.h),
          ///  Filter
          Container(
            height: 190.h,
            width: 378.w,
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
                border: Border.all(width: 1.w),
                borderRadius: BorderRadius.circular(10.r)),
            child: Column(children: [
              Text("Filter".tr,
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 28.sp)),
              SizedBox(height: 12.h),

              // Shelve DropdownButton
              (selectPlace!=false)?
              CustomDropdownButton(
                  onChanged: (value) {},
                  onTap: () {},
                  hintText: selectedPlace.tr,
                  items: List.generate(
                    1,
                        (index) => DropdownMenuItem(
                        onTap: (){},
                        value: 1,
                        child: Text(selectedPlace.tr,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp))),
                  )):
              (widget.place != "All Places")
                  ? CustomDropdownButton(
                  onChanged: (value) {},
                  onTap: () {},
                  hintText: widget.place.tr,
                  items: List.generate(
                    1,
                        (index) => DropdownMenuItem(
                        onTap: (){},
                        value: 1,
                        child: Text(widget.place.tr,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp))),
                  ))
                  :
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
                            selectedPlace =
                            places[index];
                            selectPlace=true;
                          });
                        },
                        value: 1,
                        child: Text("${places[index].tr}",
                            style: TextStyle(
                                fontWeight:
                                FontWeight.w500,
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
                            selectedCategory =
                            categories[index];
                          });
                        },
                        value: 1,
                        child: Text("${categories[index].tr}",
                            style: TextStyle(
                                fontWeight:
                                FontWeight.w500,
                                fontSize: 14.sp))),
                  )),
              // SizedBox(height: 12.h),

              SizedBox(height: 12.h),
            ]),
          ),
          SizedBox(height: 12.h),
          (selectedImage == null)
              ? Text("Please pick a Image to upload".tr)
              : GestureDetector(
            onTap: (){
              Get.defaultDialog(
                  title: "",
                  content: Column(
                    children: [
                      InkWell(
                          onTap: () {
                            getCameraImage();
                            Navigator.of(context).pop();
                          },
                          child: DefualtButton(  selected: true,text: "From Camera".tr)),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                          onTap: () {
                            Get.to(()=>AvailabilityVideoDetection(
                              category: selectedCategory,
                              managerPhone: widget.managerPhone,
                              marketImage: widget.marketImage,
                              profileImage: widget.profileImage,
                              username:widget. username,
                              branch: widget.branch, market: widget.market,
                              id: widget.id, phone:widget. phone,
                              nationality: widget.nationality,
                              place: selectedPlace, managerName: widget.managerName,
                              orderBy: widget.orderBy,
                            taskType: widget.taskType,
                            ));
                            //getImage();

                            //Navigator.of(context).pop();
                          },
                          child: DefualtButton(
                              selected: true, text: "Video Detection".tr)),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                          onTap: () {
                            getImage();

                            Navigator.of(context).pop();
                          },
                          child: DefualtButton(  selected: true,text: "From Gallery".tr)),
                    ],
                  ));
            },
            child: Image.file(
              selectedImage!,
              width: MediaQuery.of(context).size.width - 30,
              height: 300.h,
              // height: MediaQuery.of(context).size.height / 1.6,
            ),
          ),
          SizedBox(height: 180),
        ],
      ),
      floatingActionButton: (selectedCategory!="All Categories"&&selectedPlace!="All Places"&&
          selectedImage==null)
          ? FloatingActionButton(
        backgroundColor: kprimaryColor,
        onPressed: () {
          Get.defaultDialog(
              title: "",
              content: Column(
                children: [
                  InkWell(
                      onTap: () {
                        getCameraImage();
                        Navigator.of(context).pop();
                      },
                      child: DefualtButton(  selected: true,text: "From Camera".tr)),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                      onTap: () {
                        Get.to(()=>AvailabilityVideoDetection(
                          category: selectedCategory,
                          managerPhone: widget.managerPhone,
                          marketImage: widget.marketImage,
                          profileImage: widget.profileImage,
                          username:widget. username,
                          branch: widget.branch, market: widget.market,
                          id: widget.id, phone:widget. phone,
                          nationality: widget.nationality,
                          place: selectedPlace, managerName: widget.managerName,
                          orderBy: widget.orderBy,
                          taskType: widget.taskType,
                        ));
                        //getImage();

                       // Navigator.of(context).pop();
                      },
                      child: DefualtButton(
                          selected: true, text: "Video Detection".tr)),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                      onTap: () {
                        getImage();

                        Navigator.of(context).pop();
                      },
                      child: DefualtButton(  selected: true,text: "From Gallery".tr)),
                ],
              ));
        },
        child: Icon(
          Icons.add_a_photo,
          color: Colors.white,
        ),
      )
          : null,
      bottomNavigationBar: ((selectedCategory != "All Categories") &&
          (selectedImage != null)&&(selectedPlace!="All Places"))
          ? Padding(
        padding: EdgeInsets.only(
          left: 15.h,
          right: 15.h,
        ),
        child: (availabilityTaskDetails.isEmpty) && (tags.length == 0)
            ? InkWell(
          onTap:
          //yoloOnImage,
          uploadImage,
          child: startProgress != true
              ? DefualtButton(
            selected: true,
            text: "Available Products".tr,
          )
              : buildProgress(),
        )
            : InkWell(
            onTap: () {
              //print(rTVTaskDetails.length);
              // filterList();
              Get.to(()=>Availability(
                category: selectedCategory,
                taskType: widget.taskType,
                //imageSrc: selectedImage,
                manegerName:widget.managerName,
                phone: widget.phone,
                managerPhone: widget.managerPhone,
                market: widget.market,
                marketImage: widget.marketImage,
                username: widget.username,
                profileImage: widget.profileImage,
                place: selectedPlace,
                nationality: widget.nationality,
                branch: widget.branch,
                id: widget.id,
                orderBy: widget.orderBy,
              ));
            },
            child: (availabilityTaskDetails.length > 0)
                ? DefualtButton(selected: true, text: 'View List'.tr)
                : DefualtButton(selected: false, text: 'Fail'.tr)
          //Text("Fail"),
        ),
      )
          : null,
    );
  }

  bool doneTask = false, uploadDone = false, startProgress = false;
  UploadTask? uploadTask;
  void filterList() {
//    var ascading = resJson..sort();
    resJson.sort((a,b)=>a.compareTo(b));
    print(tags.length);
    for (int k = 0; k < tags.length; k++) {
      // tags.sort((a,b)=>a.compareTo(b));
      // print(tags[k]);
      if (!selectedJsonProducts.contains(tags[k])) {
        setState(() {
          selectedJsonProducts.add(tags[k]);
          selectedNewJsonProducts.add(tags[k]);
          newJson.add(JsonProduct(
              product: tags[k],
              prAmount: 1
          ));
        });
      }
      else {

        for (int x = 0; x < selectedJsonProducts.length; x++) {
          if (newJson[x].product == tags[k]) {
            setState(() {
              newJson[x].prAmount = newJson[x].prAmount + 1;
            });
          }
          else{

          }
        }
      }


    }

    print("..........");

    for(int p=0;p<newJson.length;p++)
    {
      getId(
          int.parse(newJson[p].product),
          newJson[p].prAmount);
    }
    print(newJson.length);
    newJson=[];
    selectedJsonProducts=[];
    selectedNewJsonProducts=[];
  }
//   void filterList() {
// //    var ascading = resJson..sort();
// //resJson.sort((a,b)=>a.compareTo(b));
//     print(resJson.length);
//     for (int k = 0; k < resJson.length; k++) {
//       resJson.sort((a,b)=>a.compareTo(b));
//       print(resJson[k]);
//       if (!selectedJsonProducts.contains(resJson[k])) {
//         setState(() {
//           selectedJsonProducts.add(resJson[k]);
//           selectedNewJsonProducts.add(resJson[k]);
//           newJson.add(JsonProduct(
//               product: resJson[k],
//               prAmount: 1
//           ));
//         });
//       }
//       else {
//
//         for (int x = 0; x < selectedJsonProducts.length; x++) {
//           if (newJson[x].product == resJson[k]) {
//             setState(() {
//               newJson[x].prAmount = newJson[x].prAmount + 1;
//             });
//           }
//           else{
//
//           }
//         }
//       }
//
//
//     }
//
//     print("..........");
//
//     for(int p=0;p<newJson.length;p++)
//     {
//       getId(
//           int.parse(newJson[p].product),
//           newJson[p].prAmount);
//     }
//     print(newJson.length);
//     newJson=[];
//     selectedJsonProducts=[];
//     selectedNewJsonProducts=[];
//   }
  // UploadTask? uploadTask;
  // bool progress = false;
  // bool doneTask = false, uploadDone = false, startProgress = false;
  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(' Error ya Ahmed :: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final task = snapshot.data!;
          double progress = task.bytesTransferred / task.totalBytes;

          return Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
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
                  Center(
                    child: Text('${(100 * progress).roundToDouble()}%'),
                  )
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      });
}
