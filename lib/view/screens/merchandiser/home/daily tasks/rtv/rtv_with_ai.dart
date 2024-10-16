import 'dart:convert';
import 'dart:io';
import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/rtv/rtv_screen.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/rtv/rtv_yolo.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/rtv/video_detiction.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/profile/branch_appbar.dart';
import 'package:arrow_merchandising/view/widgets/custom_dropdown.dart';
import 'package:arrow_merchandising/const.dart';
import 'package:arrow_merchandising/models/new_products.dart';
import 'package:arrow_merchandising/models/rtv_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:flutter_vision/flutter_vision.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'dart:typed_data';

//import 'package:panorama/panorama.dart';


class RTVWithAi extends StatefulWidget {
  const RTVWithAi(
      {super.key,
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
      required this.managerName,
      required this.orderBy, required this.taskType,


      });
  final int id, phone, managerPhone;
  final String marketImage,
      profileImage,
      username,
      managerName,
      branch,
      market,
      nationality;
  final String place, orderBy,taskType;

  @override
  State<RTVWithAi> createState() => _RTVWithAiState();
}

class _RTVWithAiState extends State<RTVWithAi> {

 // late FlutterVision vision;

  // @override
  // void initState() {
  //
  // }
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

//   yoloOnImage() async {
//     print('*****************');
//     setState(() {
//       startProgress = true;
//     });
//     newJson.clear();
//     tags.clear();
//     yoloResults.clear();
//     Uint8List byte = await selectedImage!.readAsBytes();
//     final image = await decodeImageFromList(byte);
//     imageHeight = image.height;
//     imageWidth = image.width;
//     final result = await vision.yoloOnImage(
//       bytesList: byte,
//       imageHeight: image.height,
//       imageWidth: image.width,
//       iouThreshold: 0.8,
//       confThreshold: 0.4,
//       classThreshold: 0.5,
//     );
//     if (result.isNotEmpty) {
//       setState(() {
//        // jsonToList(jsonDecode(result.z);
//         print(result);
//         yoloResults = result;
//         isLoaded = true;
//       });
//     }
//       for (int p = 0; p < result.length; p++) {
//         setState(() {
//           tags.add(result[p]['tag']);
//         });
//        }
// filterList();
//         setState(() {
//           startProgress = false;
//         });
//     }
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
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {

      selectedImage = (File(image!.path));

      startProgress = false;
    });
  }

  Future getImage() async {
    setState(() {
      resJson=[];
      rTVTaskDetails=[];
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
                  rTVTaskDetails.add(
                      RTVProduct(
                        rType: selectedRtvType,
                        image: data['photo'],
                        barCode: data['product_item_code'],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kprimaryColor,
          title: MerchAppBar(
            // appBar: MerchAppBar(
            title: "RTV Section",
            manegerName: widget.managerName,
            phone: widget.phone,
            market: widget.market,
            marketImage: widget.marketImage,
            branch: widget.branch,
            username: widget.username,
            profileImage: widget.profileImage,
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 12.h),

          ///  Filter
          Container(
            height: 230.h,
            width: 378.w,
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
                border: Border.all(width: 1.w),
                borderRadius: BorderRadius.circular(10.r)),
            child: Column(children: [
              Text("Filter".tr,
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 28.sp)),
              SizedBox(height: 5.h),
              CustomDropdownButton(
                  onChanged: (value) {},
                  onTap: () {},
                  hintText: selectedRtvType.tr,
                  items: List.generate(
                    rtvType.length,
                    (index) =>
                        //null)
                        DropdownMenuItem(
                            onTap: () {
                              setState(() {
                                selectedRtvType = rtvType[index].tr;
                              });
                            },
                            value: 1,
                            child: Text("${rtvType[index]}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp))),
                    // DropdownMenuItem(
                    //     value: 2,
                    //     child: Text("2",
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.w500,
                    //             fontSize: 14.sp))),
                  )),
              SizedBox(height: 10.h),
              // Shelve DropdownButton
              (selectPlace != false)
                  ? CustomDropdownButton(
                      onChanged: (value) {},
                      onTap: () {},
                      hintText: selectedPlace.tr,
                      items: List.generate(
                        1,
                        (index) => DropdownMenuItem(
                            onTap: () {},
                            value: 1,
                            child: Text(selectedPlace.tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp))),
                      ))
                  : (widget.place != "All Places")
                      ? CustomDropdownButton(
                          onChanged: (value) {},
                          onTap: () {},
                          hintText: widget.place.tr,
                          items: List.generate(
                            1,
                            (index) => DropdownMenuItem(
                                onTap: () {},
                                value: 1,
                                child: Text(widget.place.tr,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp))),
                          ))
                      : CustomDropdownButton(
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
                                        selectPlace = true;
                                      });
                                    },
                                    value: 1,
                                    child: Text("${places[index].tr}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp))),
                          )),
              SizedBox(height: 10.h),
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
                            child: Text("${categories[index]}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp))),
                  )),
              // SizedBox(height: 12.h),

              //SizedBox(height: 12.h),
            ]),
          ),
          SizedBox(height: 12.h),
          (selectedImage == null)
              ? Text("Please pick a Image to upload".tr)
              : GestureDetector(
                  onTap: () {
                    Get.defaultDialog(
                        title: "",
                        content: Column(
                          children: [
                            InkWell(
                                onTap: () {
                                  getCameraImage();
                                  Navigator.of(context).pop();
                                },
                                child: DefualtButton(
                                    selected: true, text: "From Camera".tr)),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                                onTap: () {
                                  // Get.to(()=>RTVYoloVideo(
                                  //     managerPhone: widget.managerPhone,
                                  //     marketImage: widget.marketImage,
                                  //     profileImage: widget.profileImage,
                                  //     username:widget. username,
                                  //     branch: widget.branch, market: widget.market,
                                  //     id: widget.id, phone:widget. phone,
                                  //     nationality: widget.nationality,
                                  //     place: widget.place, managerName: widget.managerName,
                                  //     orderBy: widget.orderBy, taskType: selectedRtvType));
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
                                child: DefualtButton(
                                    selected: true, text: "From Gallery".tr)),
                          ],
                        ));
                  },
                  child:
                      //


                  //Obx(()=>
                  Container(    height: 300.h,child:
                    //   Panorama(
                    //
                    // zoom: 1,
                    // animSpeed: 1.0,
                    // child:  selectedImage!=null?
                    Image.file(
                      selectedImage!,
                      width: MediaQuery.of(context).size.width - 30,
                      height: 300.h,
                      // height: MediaQuery.of(context).size.height / 1.6,

                   // )
                   // controller.selectedImagePath.value!=""?
                    // Image.file(
                    //     File(
                    //         controller. selectedImagePath.value!))
                        //:Image.asset("assets/images/appBackground.jpeg"),
                  ) )),

                  //

                //   Image.file(
                //     selectedImage!,
                //     width: MediaQuery.of(context).size.width - 30,
                //     height: 300.h,
                //     // height: MediaQuery.of(context).size.height / 1.6,
                //   ),
                // ),

        ],
      ),
      floatingActionButton:
          (selectedCategory != "All Categories" && selectedPlace!="All Places" && selectedImage == null)
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
                                child: DefualtButton(
                                    selected: true, text: "From Camera".tr)),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                                onTap: () {
                                  Get.to(()=>RTVVideoDetection(
                                      managerPhone: widget.managerPhone,
                                      marketImage: widget.marketImage,
                                      profileImage: widget.profileImage,
                                      username:widget. username,
                                      branch: widget.branch,
                                      market: widget.market,
                                      id: widget.id,
                                      phone:widget. phone,
                                      nationality: widget.nationality,
                                      place: selectedPlace,
                                      category: selectedCategory,
                                      managerName: widget.managerName,
                                      orderBy: widget.orderBy,
                                      taskType: selectedRtvType));
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
                                child: DefualtButton(
                                    selected: true, text: "From Gallery".tr)),
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
          (selectedImage != null)&&(selectPlace!="All Places"))
          ? Padding(
              padding: EdgeInsets.only(
                left: 15.h,
                right: 15.h,
              ),
              child: (rTVTaskDetails.isEmpty) && (tags.length == 0)
                  ? InkWell(
                      onTap:
                      //yoloOnImage,
                      uploadImage,
                      child: startProgress != true
                          ? DefualtButton(
                              selected: true,
                              text: "Read Data".tr,
                            )
                          : buildProgress(),
                    )
                  : InkWell(
                      onTap: () {
                         print(rTVTaskDetails.length);
                         Get.to(()=>RtvSectionScreen(
                           category: selectedCategory,
                             taskType: selectedRtvType,
                             place: widget.place,
                             orderBy: widget.orderBy,
                             //managerPhone: managerPhone, userName: userName, market: market, branch: branch, marketImage: marketImage, profileImage: profileImage, id: id, phone: phone, nationality: nationality, manegerName: manegerName))
                             manegerName: widget.managerName,
                             // tab_index: 2,
                             userName: widget.username,
                             marketImage: widget.marketImage,
                             profileImage: widget
                                 .profileImage,
                             market: widget.market,
                             branch: widget.branch,
                             id: widget.id,
                             phone: widget.phone,
                             //marketDetails:widget. marketDetails,
                             nationality: widget.nationality,
                             managerPhone: widget
                                 .managerPhone
                         ));
                        // filterList();
                        // Get.to(() => RTVWithAiReview(
                        //   taskType: widget.taskType,
                        //       //rtvProduct: rTVTaskDetails,
                        //       orderBy: widget.orderBy,
                        //       imageSrc: selectedImage,
                        //       manegerName: widget.managerName,
                        //       phone: widget.phone,
                        //       managerPhone: widget.managerPhone,
                        //       market: widget.market,
                        //       marketImage: widget.marketImage,
                        //       username: widget.username,
                        //       profileImage: widget.profileImage,
                        //       place: selectedPlace,
                        //       nationality: widget.nationality,
                        //       branch: widget.branch,
                        //       id: widget.id,
                        //     ));
                        //   }
                        // }
                        // Navigator.pop(context);
                        // Get.to(()=>);
                      },
                      child: (rTVTaskDetails.length > 0)
                          ? DefualtButton(selected: true, text: 'View List'.tr)
                          : DefualtButton(selected: false, text: 'Fail'.tr)
                      //Text("Fail"),
                      ),
            )
          : null,
    );
  }
  // Stream<List<ProductsByPiece>> readCategoryProducts(String category) =>
  //     FirebaseFirestore.instance
  //         .collection('arrow_products')
  //         .where('category', isEqualTo: category,)
  //         .snapshots()
  //         .map((snapshot) => snapshot.docs
  //         .map((doc) => ProductsByPiece.fromJson(doc.data()))
  //         .toList());

  // Future createInventoryTask(InventoryTask inventoryTask) async {
  //   // bool createTask=false;
  //   final rtvData = FirebaseFirestore.instance.collection('Inventory Tasks').doc();
  //   final json = inventoryTask.toMap();
  //   await rtvData.set(json);
  //   // if(rtvData.set(json)==true)
  //   //   createTask=true;
  //   // doneTask=createTask;
  //
  //   doneTask=true;
  // }
  bool startProgress = false;
  UploadTask? uploadTask;

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
  //int l=1;
//   void filterList() {
//     for (int h = 0; h < yoloResults.length; h++)
//       {
//         tags.add(yoloResults[h]['tag']);
//       }
// //    var ascading = resJson..sort();
//     //yoloResults.sort((a,b)=>a.compareTo(b));
//     tags.sort((a,b)=>a.compareTo(b));
//     print(tags.length);
//     for (int k = 0; k < tags.length; k++) {
//
//       print(tags[k]);
//       if (!selectedJsonProducts.contains(tags[k])) {
//         setState(() {
//           selectedJsonProducts.add(tags[k]);
//           selectedNewJsonProducts.add(tags[k]);
//           newJson.add(JsonProduct(
//               product: tags[k],
//               prAmount: 1
//           ));
//         });
//       }
//       else {
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
//     print(newJson.length);
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
//}
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
}
