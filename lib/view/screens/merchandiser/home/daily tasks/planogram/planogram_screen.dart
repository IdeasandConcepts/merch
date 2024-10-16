import 'package:arrow_merchandising/view/screens/merchandiser/merch_nav_bar.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/profile/branch_appbar.dart';
import 'package:arrow_merchandising/view/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'dart:io';
import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/const.dart';
import 'package:arrow_merchandising/models/ai_planogram_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class PlanogramAI extends StatefulWidget {
  final int id, phone, adminPhone;
  final String marketImage,
      profileImage,
      username,
      managerName,
      branch,
      place,
      orderBy,
      taskType,
      market,
      nationality;
  //marketDetails;
  // final List<String> conditionList;
  const PlanogramAI(
      {super.key,
      required this.managerName,
      required this.orderBy,
      required this.marketImage,
      required this.profileImage,
      required this.username,
      required this.branch,
      required this.market,
      required this.id,
      required this.phone,
      required this.nationality,
      required this.place,
      required this.adminPhone,
      required this.taskType});
  @override
  State<PlanogramAI> createState() => _PlanogramAIState();
}

class _PlanogramAIState extends State<PlanogramAI> {
  String imageClass = "No Result Yet";
  String planoImagePath = "";
  String degree = "";
  File? selectedImage;
  String? message = "";
  String? greetings = '';
  var resJson = "";

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
      selectedPlace = widget.place;
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

  uploadImage() async {
    setState(() {
      startProgress = true;
    });
    final request =
        http.MultipartRequest("POST", Uri.parse("${urlApi}/upload2"));
    final headers = {"Content-type": "multipart/from-data"};
    request.files.add(http.MultipartFile("image",
        selectedImage!.readAsBytes().asStream(), selectedImage!.lengthSync(),
        filename: selectedImage!.path.split("/").last));
    request.headers.addAll(headers);
    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    final resJson = jsonDecode(res.body);
    message = resJson['message'];
    if (message != "") {

      print(message);
    }
    setState(() {
      if (message == "1") {
        imageClass = "Excellent";
        degree = "90 % - 100 %";
      } else if (message == "2") {
        imageClass = "Very Good";
        degree = "70 % - 90 %";
      } else if (message == "3") {
        imageClass = "Good";
        degree = "50 % - 70 %";
      } else {
        imageClass = "Not Arranged";
      }
      print(imageClass);
    });
    //

    final file = File(selectedImage!.path);
    final ref = FirebaseStorage.instance
        .ref()
        .child("Planogram Pictures/" + DateTime.now().toString() + '.png');
    setState(() {
      startProgress = true;
      uploadTask = ref.putFile(file);
    });

    final snapShot = await uploadTask!.whenComplete(() {
      setState(() {
        uploadDone = true;
        startProgress = false;
      });
    });
    planoImagePath = await snapShot.ref.getDownloadURL();
    print(planoImagePath);
    setState(() {
      uploadTask = ref.putFile(file);
      uploadDone = true;
    });
    if ((planoImagePath != "") && (uploadTask != null))
      setState(() {
        uploadDone = true;
        startProgress = false;
      });
    // setState(() {
    //   startProgress = false;
    // });
  }

  Future getImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    selectedImage = File(pickedImage!.path);
    setState(() {
      planoImagePath = selectedImage.toString();
    });
  }
  //File? imagePath;

  final imagePicker = ImagePicker();

  Future getCameraImage() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    selectedImage = (File(image!.path));
    setState(() {
      planoImagePath = selectedImage.toString();
      // progress=false;
    });
  }

  List<String> places = [
    "On Shelves",
    "On Display",
    "On Gandola",
    "On Back Door"
  ];
  String selectedPlace = "On Shelves";
  List<String> categories = [];
  String selectedCategory = "All Categories";
  @override
  Widget build(BuildContext context) {
    //  //final  Controller  c = Get.put(Controller());
    //  double height =MediaQuery.sizeOf(context).height;
    //  double width =MediaQuery.sizeOf(context).width;
    // // var filterTitle = ["Shelf","Category","Product"];
    //  Color primaryColor =Colors.teal.shade900;
    //  Color BgroundColor =Colors.grey.shade300;
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: kprimaryColor,
            title: MerchAppBar(
              // appBar: MerchAppBar(
              title: "Planogram Section",
              manegerName: widget.managerName,
              phone: widget.phone,
              market: widget.market,
              marketImage: widget.marketImage,
              branch: widget.branch,
              username: widget.username,
              profileImage: widget.profileImage,
            )),
        body:      (startProgress==false)?
        Column(
            //  shrinkWrap: true,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             // (startProgress==false)?
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 12.h),
                    Padding(
                      padding: EdgeInsets.only(left: 20.h, right: 20.h),
                      child: Container(
                        // height: 120.h,
                        // width: 378.w,
                        // margin: EdgeInsets.symmetric(horizontal: 10.w),
                        // decoration: BoxDecoration(
                        //     border: Border.all(width: 1.w),
                        //     borderRadius: BorderRadius.circular(10.r)),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            (widget.place != "All Places")
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
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14.sp))),
                                )),
                          ],
                        ),
                      ),
                    )
                  ]),
              //   ),
              //SizedBox(height: 12.h),
              // SizedBox(height: 12.h),
              // SizedBox(
              // height: 20.h,
              // ),
              //  if (imagePath.length <= 9)

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(left: 25.h, right: 25.h, top: 10.h),
                    child: Card(
                        child: Container(
                            height: 320.h,
                            width: 330.w,
                            child: Center(
                              child: (planoImagePath == "")
                                  ? Icon(
                                      Icons.add,
                                      size: 320.sp,
                                      color: Colors.white,
                                    )
                                  : Container(
                                      // padding: EdgeInsets.only(top: 10.h),
                                      height: 300.h,
                                      width: 320.w,
                                      child: Container(
                                          padding: EdgeInsets.all(10),
                                          // width: 65,
                                          // height: 80,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Image.file(selectedImage!)
                                          //)
                                          ),
                                      //);
                                      // }
                                    ),
                            ))),
                  ),
                  if (planoImagePath == "")
                    Padding(
                      padding: EdgeInsets.only(left: 20.h, right: 20.h),
                      child: MaterialButton(
                        onPressed: () async {
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
                                          selected: true,
                                          text: "From Camera".tr)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        getImage();

                                        Navigator.of(context).pop();
                                      },
                                      child: DefualtButton(
                                          selected: true,
                                          text: "From Gallery".tr)),
                                ],
                              ));
                        },
                        child: DefualtButton(
                          selected: false,
                          text: "Take A Picture".tr,
                        ),
                      ),
                    ),
                  if (imageClass == "No Result Yet" &&
                      planoImagePath != "" &&
                      selectedCategory != "All Categories")
                    Padding(
                      padding: EdgeInsets.only(left: 10.h, right: 10.h),
                      child: (imageClass == "No Result Yet")
                          ? InkWell(
                              onTap:
                                  // (imageClass == "No Result Yet")
                                  uploadImage,
                              //     :({
                              //
                              // });

                              child: DefualtButton(
                                selected: true,
                                text: "Compare".tr,
                              ),
                            )
                          : null,
                    ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.h, right: 10.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20.h, right: 20.h),
                      child: Text(
                        imageClass.tr,
                        style: TextStyle(
                          fontSize: 25,
                          color: kprimaryColor,
                          //Colors.purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (degree != "")
                      Padding(
                        padding: EdgeInsets.only(left: 20.h, right: 20.h),
                        child: Text(
                          degree,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              //     ],
              // ),
              SizedBox(
                height: 30,
              ),
            ])   :   buildProgress(),
        bottomNavigationBar: (imageClass != "No Result Yet")
            ? Padding(
                padding: EdgeInsets.only(
                  left: 15.h,
                  right: 15.h,
                ),
                child: InkWell(
                  onTap: () async {
                    await uploadImage();
                    if (uploadDone == false) {
                      buildProgress();
                    } else
                      await createPlanogramTask(AiPlanogramModel(
                          orderBy: widget.orderBy,
                          taskType: widget.taskType,
                          degree: imageClass,
                          place: selectedPlace,
                          // description: "may be the images are so different",
                          market: widget.market,
                          branch: widget.branch,
                          madeBy: widget.username,
                          taskDate: (DateFormat('yyyy-MM-dd')
                              .format(DateTime.now())
                              .toString()),
                          taskTime: (DateFormat('kk:mm')
                              .format(DateTime.now())
                              .toString()),
                          imagePath: planoImagePath,
                          status: 'done'));
                    //  completedPlanogramTasks.

                  },
                  child: (startProgress == false && (planoImagePath != ""))
                      ?
                      // child: startProgress!=true?
                      DefualtButton(
                          selected: true,
                          text: "Create Task".tr,
                        )
                      :null
                  //buildProgress(),
                  //):
                ),
              )
            : null
    );
  }

  Future createPlanogramTask(AiPlanogramModel planogram) async {
    final planogramtask =
        FirebaseFirestore.instance.collection('Planogram').doc();
    final json = planogram.tojson();
    await planogramtask.set(json);
    setState(() {
      doneTask=true;
    });
    completedPlanogramTasks.add(selectedCategory);
    imageClass = "No Result Yet";
    planoImagePath = "";
    degree = "";
    selectedImage = null;
    message = "";
    greetings = '';
    resJson = "";
    uploadDone = false;
    doneTask = false;

    Get.offAll(MerchNavBar(
        tab_index: 2,
        username: widget.username,
        marketImage: widget.marketImage,
        profileImage: widget.profileImage,
        branch: widget.branch,
        market: widget.market,
        id: widget.id,
        phone: widget.phone,
        manegerName: widget.managerName,
        nationality: widget.nationality,
        mangerphone: widget.adminPhone));
    //  final
  }

  bool doneTask = false, uploadDone = false, startProgress = false;
  UploadTask? uploadTask;
  //List<String> availabPhoto=;

  // bool doneTask=false,uploadDone=false,startProgress=false;
  // UploadTask? uploadTask;
  // List<String> availabilityPhoto=[];

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
