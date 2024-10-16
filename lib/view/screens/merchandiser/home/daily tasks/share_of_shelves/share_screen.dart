

import 'dart:io';

import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/share_of_shelves/sh_with_ai.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/merch_nav_bar.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/profile/branch_appbar.dart';

import 'package:arrow_merchandising/view/widgets/custom_dropdown.dart';
import 'package:arrow_merchandising/const.dart';
import 'package:arrow_merchandising/models/ai_share_model.dart';
import 'package:arrow_merchandising/models/share_products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


class ShareOfShelfScreen extends StatefulWidget {
 // const ({Key? key}) : super(key: key);
  final int id, phone, adminPhone;
  final String marketImage,
      profileImage,
      username,
   orderBy,
      taskType,
      branch,
  place,
      managerName,
      market,
      nationality;
  //marketDetails;
  // final List<String> conditionList;
  const ShareOfShelfScreen(
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
  State<ShareOfShelfScreen> createState() => _ShareOfShelfScreenState();
}

class _ShareOfShelfScreenState extends State<ShareOfShelfScreen> {
  TextEditingController shelfController=TextEditingController();
  TextEditingController fullController=TextEditingController();
  //TextEditingController detailsController=TextEditingController();

  String product="";
  String details="";
  double price=0;

  List<String> places = [
    "On Shelves",
    "On Display",
    "On Gandola",
    "On Back Door"
  ];
  String selectedPlace = "All Places";
  bool selectPlace=false;
  List<String> categories = [];
  String selectedCategory = "All Categories";


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
      getId();
      selectedPlace = widget.place;
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
            title: "Share Of Shelves",
            manegerName: widget.managerName,
            phone: widget.phone,
            market: widget.market,
            marketImage: widget.marketImage,
            branch: widget.branch,
            username: widget.username,
            profileImage: widget.profileImage,
          ) ),
      body: Container(height: MediaQuery.of(context).size.height-80,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.0,),
          Container(
            height: 120.h,
            width: 330.w,
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              //border: Border.all(width: 1.w),
                borderRadius: BorderRadius.circular(10.r)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(

                  child: Column(

                      children: [
                        // Text("Filter",
                        //     style: TextStyle(
                        //         fontWeight: FontWeight.w700, fontSize: 28.sp)),
                       // SizedBox(height: 12.h),

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
                                  child: Text("${
                                      categories[index].tr}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.sp))),
                            )),
                      ]),
                  height: 120.w,
                  width: 240.h,
                ),
                GestureDetector(
                  onTap: (){
                    Get.to(()=>ShareWithAi(
                      taskType: widget.taskType,
                      orderBy: widget.orderBy,
                      manegerName: widget.managerName,
                      place: widget.place,
                      phone: widget.phone,
                      adminPhone:widget.adminPhone,
                      market:widget.market,
                      marketImage:widget.marketImage,
                      username: widget.username,
                      profileImage: widget.profileImage,
                      nationality:widget.nationality,
                      branch: widget.branch,
                      id: widget.id,
                    ));
                  },
                  child: Container(
                    height: 80.h,
                    width:80.w,
                    child:Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt_outlined,
                            size: 60.dm,
                          ),
                          Text(
                              "Using AI".tr,
                            style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    )
                    // CustomIconsButom(
                    //
                    //   titel: "Using AI",
                    //   //onTap: () {},
                    // ),
                  ),
                ),
              ],
            ),
          ),
          Container(

            height: 130.h,
            //color: kprimaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
    Padding(
    padding:  EdgeInsets.only(left:15.w,right: 15.w,top:10.h,bottom: 10.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:<Widget>[
        Container(
         // width: 100.w,
          height: 50.h,
          child: Center(child: Text("Shelf Area".tr, style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold
          ),)),),
        Container(
         // width: 130.w,
          height: 50.h,
          child: Center(child: Text("Shelf Full Area".tr, style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold
          ),)),),
      ],
    )),
                        Padding(
                          padding:  EdgeInsets.only(left:20.w,right: 20.w,top:10.h,bottom: 10.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Material(
                                elevation: 10,
                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                child: Container(
                                  width: 160.w,
                                  height: 50.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: Border.all(),
                                    //  color: const Color(0xffEAE9E9),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10.r))),
                                  child: Center(
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: shelfController,
                                      decoration: InputDecoration(

                                        contentPadding:  EdgeInsets.only(left:15.h,right: 15.h),
                                        hintText: (shelfController.text=="")?"Shelf Area".tr:shelfController.text,
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp),
                                        // prefixIcon: const Icon(Icons.search_sharp),
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (value){
                                        setState(() {
                                          markerArea=double.parse(value);
                                        });
                                      },
                                    ),
                                  ),

                                ),
                              ),
                             SizedBox(height: 10.h,),
                              Material(
                               // elevation: 10,
                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                child: Container(
                                  width: 160.w,
                                  height: 50.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                     // color: const Color(0xffEAE9E9),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(10.r))),
                                  child: Center(
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: fullController,
                                      decoration: InputDecoration(
                                      //  hintText: (priceController.text=="")?"Price":priceController.text+"\t"+"SR",
                                        hintText: "Full Area".tr,
                                        contentPadding:  EdgeInsets.only(left:15.h,right: 15.h,),
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp),
                                        //  prefixIcon: const Icon(Icons.search_sharp),
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (value){
                                        setState(() {
                                          fullArea=double.parse(value);
                                        });
                                      },
                                    ),
                                  ),
                              
                                ),
                              ),

                            ],
                          ),
                        ),
            ]),
          ),
          if(markerArea!=0&&fullArea!=0)
          Padding(    padding:  EdgeInsets.only(left:25.h,right: 25.h,),
            // Text(
            //   'Share of Shelve'.tr +'\t'+
            //       (markerArea / fullArea * 100).toStringAsFixed(0)
            //       + "%",
            //   style: TextStyle(fontSize: 24),
            // ),
            child: Text((fullArea>markerArea)?
              "Result"+":"+"\t"+ (markerArea / fullArea * 100).toStringAsFixed(0)
                  +"%":"Wrong Data",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold
            ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.h),
            child: InkWell(
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
                            child: DefualtButton( selected: true,text: "From Camera".tr)),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                            onTap: () {
                              getImage();

                              Navigator.of(context).pop();
                            },
                            child: DefualtButton( selected: true,text: "From Gallery".tr)),
                      ],
                    )
                );
              },
              child: Card(
                child: Container(
                    height: 280.h,
                   // width:
                    //300.w,
                    child: Center(
                      child: (imagePath==null)
                          ? Icon(
                        Icons.add,
                        size: 280.sp,
                        color: Colors.white,
                      )
                          : Container(
                           // padding: EdgeInsets.only(top: 10.h),
                            height: 260.h,
                            width: double.infinity,
                            child:
                                    Image.file(imagePath!),

                          ),
                    )),
              ),
            ),
          ),
          if(imagePath==null)
          Padding(
                  padding: EdgeInsets.only(left: 30.h, right: 30.h,),
                  child: MaterialButton(
          onPressed: () async {
          //  await getImage();

            Get.defaultDialog(
                title: "",
                content: Column(
                  children: [
                    InkWell(
                        onTap: () {
                          getCameraImage();
                          Navigator.of(context).pop();
                        },
                        child: DefualtButton( selected: true,text: "From Camera".tr)),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                        onTap: () {
                          getImage();

                          Navigator.of(context).pop();
                        },
                        child: DefualtButton( selected: true,text: "From Gallery".tr)),
                  ],
                )
            );
          },
          child: DefualtButton(selected:false,text:
          //(imagePath.length == 0)?
          "Take A Picture".tr
            //  : "Take Another Picture".tr,
          ),
                  ),

              ),

        ],
      ),
      ),
      bottomNavigationBar:(imagePath!=null)? Padding(
        padding:  EdgeInsets.only(left:15.h,right: 15.0),
        child: InkWell(
          onTap: ()async {
         await   uploadImage(imagePath);
            createShareTask(
                AiShareModel(
                  taskType: widget.taskType,
                  fullArea: fullArea,
                  markerArea:markerArea,
                  place: selectedPlace,
                  selectedProducts: selectedCategory,
                  orderBy: widget.orderBy,
                  status: 'Done',
                  branch: widget.branch,
                  market: widget.market,
                  madeBy: widget.username,
                  taskDate: (DateFormat('yyyy-MM-dd')
                      .format(DateTime.now())
                      .toString()),
                  taskTime: (DateFormat('kk:mm')
                      .format(DateTime.now())
                      .toString()),
                  degree: ((markerArea / fullArea * 100)).toDouble(),
                  imagePath:imagePath1Str,
                )
                // ShareOfShelvesModel(
                //     orderBy: widget.orderBy,
                //     selectedProducts: selectedCategory,
                //     status: 'done',
                //     branch: widget.branch,
                //     market: widget.market,
                //     madeBy: widget.username,
                //     taskDate: (DateFormat('yyyy-MM-dd')
                //         .format(DateTime.now())
                //         .toString()),
                //     taskTime: (DateFormat('kk:mm')
                //         .format(DateTime.now())
                //         .toString()),
                //     fullArea: fullArea.toDouble(),
                //     markerArea: markerArea.toDouble(),
                //     degree: fullArea/markerArea,
                //     imagePath1: imagePath1Str,
                //     place: selectedPlace
                // )
            );
            if(doneTask==true)
            {
              completeShareTasks.add(selectedPlace);
              Get.offAll(() =>
                  MerchNavBar(
                      tab_index:2,
                      manegerName: widget.managerName,
                      username: widget.username,
                      marketImage: widget.marketImage,
                      profileImage: widget
                          .profileImage,
                      branch: widget.branch,
                      market: widget.market,
                      id: widget.id,
                      phone: widget.phone,
                      //marketDetails:widget. marketDetails,
                      nationality: widget.nationality,
                      mangerphone: widget.adminPhone)
              );
            }
          },
          child: (startProgress==true)?buildProgress():
          DefualtButton( selected: true,text: "Confirm"),
        ),
      ):null,
    );
  }

  Future createShareTask(AiShareModel share) async {
    final shareData =
    FirebaseFirestore.instance.collection('Share Of Shelves').doc();
    final json = share.tojson();
    await shareData.set(json);
   setState(() {
     doneTask=true;
   });

    //  final
  }
  //bool doneTask=false;

  double fullArea = 0.0,
      markerArea = 0.0;

//  File? imagePath1=null, imagePath2=null;
  String imagePath1Str="";
      //imagePath2Str="";
  //List< File?> imagesAsFiles=[];
  File? imagePath;

   final imagePicker = ImagePicker();
  //
  // Future  getFirstImage() async {
  //   final image = await imagePicker.pickImage(source: ImageSource.camera);
  //   setState(() {
  //     imagePath1=(File(image!.path));
  //     imagesAsFiles.add((File(image!.path)));
  //   });
  // }

  Future getImage() async {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
 imagePath = File(pickedImage!.path);
    setState(() {
imagePath = File(pickedImage.path);
      //imagePath1Str = selectedImage.toString();
    });
  }
  //File? imagePath;
  File? selectedImage;
  //final imagePicker = ImagePicker();

  Future getCameraImage() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    imagePath = (File(image!.path));
    setState(() {
      imagePath = (File(image.path));
      // progress=false;
    });
  }
  // Future  getImage() async {
  //   final image = await imagePicker.pickImage(source: ImageSource.camera);
  //   setState(() {
  //     imagePath = File(image!.path);
  //     //imagesAsFiles.add((File(image!.path)));
  //   });
  //   // return imagepath!.path;
  // }
  bool doneTask=false,uploadDone=false,startProgress=false;
  UploadTask? uploadTask;

  Future uploadImage(File? myImagePath) async {
  //  for (int i = 0; i < myImagePath.length; i++) {
      final file = File(myImagePath!.path);
      final ref =
      FirebaseStorage.instance
          .ref().child(myImagePath.path);
      setState(() {
        startProgress = true;
        uploadTask = ref.putFile(file);
      });
      final snapShot = await uploadTask!.whenComplete(() {
      //  if(strCarPhotosList.length==myImagePath.length)
          setState(() {

            uploadDone=true;
            startProgress=false;
          });

        // });
      });
      imagePath1Str=(await snapShot.ref.getDownloadURL());
      setState(() {
        uploadTask = ref.putFile(file);
      });
    //}
    // setState(() {
    // //  if(strCarPhotosList.length==myImagePath.length) {
    //     imagePath1Str = strCarPhotosList[0];
    //    // imagePath2Str = strCarPhotosList[1];
    //     uploadDone = true;
    //     startProgress = false;
       }
  //   });

    //print(uploadDone);



  List<String>strCarPhotosList=[];
  //   for (int i = 0; i < myImagePath.length; i++)
  //   {
  //     final file = File(myImagePath[i]!.path!);
  //     final ref =
  //     FirebaseStorage.instance
  //         .ref().child("Share Of Shelves/"+DateTime.now().toString()+".png");
  //     setState(() {
  //       startProgress = true;
  //       uploadTask = ref.putFile(file);
  //     });
  //     final snapShot = await uploadTask!.whenComplete(() {
  //       if(imagePath1Str.length==myImagePath.length)
  //         setState(() {
  //           uploadDone=true;
  //           startProgress=false;
  //         });
  //
  //       // });
  //     });
  //     imagePath1Str=await snapShot.ref.getDownloadURL();
  //     setState(() {
  //       uploadTask = ref.putFile(file);
  //     });
  //   }
  //   setState(() {
  //     if(imagePath1Str!=""&&imagePath2Str!="") {
  //       uploadDone = true;
  //       startProgress = false;
  //     }
  //   });
  // }

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
}


