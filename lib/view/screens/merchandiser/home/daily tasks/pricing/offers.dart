import 'dart:io';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/pricing/offer_review.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/profile/branch_appbar.dart';
import 'package:arrow_merchandising/view/widgets/custom_dropdown.dart';
import 'package:arrow_merchandising/models/pricing_product.dart';
import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:arrow_merchandising/const.dart';
import '../../../../splash/indicator.dart';

class Offers extends StatefulWidget {
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
  const Offers(
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
        required this.taskType

      });

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> with TickerProviderStateMixin {
  TextEditingController productController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  String product = "";
  String details = "";
  double price = 0;
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
  String selectedPlace = "All Places";
  bool selectPlace=false;
  List<String> categories = [];
  String selectedCategory = "All Categories";
  // List<String> productsList = [];
  // String selectedProduct = "";

  // List<String> rtvType = [
  //   "Damaged Product's".tr,
  //   "Expired Product's".tr,
  //   "Near Expired Product's".tr
  // ];
  // String selectedRtvType = "Expired";

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
      selectedPlace=widget.place;
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
            title: "Offers Section",
            manegerName: widget.managerName,
            phone: widget.phone,
            market: widget.market,
            marketImage: widget.marketImage,
            branch: widget.branch,
            username: widget.username,
            profileImage: widget.profileImage,
          )),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        // shrinkWrap: true,
        children: <Widget>[
          //  SizedBox(height: 10.h),

          ///  Filter
          Container(
            // padding:  EdgeInsets.only(left:5.h,right: 5.h,),
            height: 130.h,
            width: 378.w,
            // margin: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
                //border: Border.all(width: 1.w),
                borderRadius: BorderRadius.circular(10.r)),
            child: Column(children: [
              // Text("Filter",
              //     style: TextStyle(
              //         fontWeight: FontWeight.w700, fontSize: 28.sp)),
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
          Padding(
            padding: EdgeInsets.only(left: 15.h, right: 15.h),
            child: Container(
              color: Colors.transparent,
              // padding: EdgeInsets.only(left: 15.h,right: 15.h),
              // height: 100,color: kprimaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 5.h, right: 5.h, top: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Material(
                          elevation: 10,
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          child: Container(
                            width: 155.w,
                            height: 50.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: const Color(0xffEAE9E9),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.r))),
                            child: TextField(
                              controller: productController,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: 15.h, right: 15.h),
                                hintText: "Product".tr,
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp),
                                // prefixIcon: const Icon(Icons.search_sharp),
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  product = value;
                                });
                              },
                            ),
                          ),
                        ),
                        Material(
                          elevation: 10,
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          child: Container(
                            width: 155.w,
                            height: 50.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: const Color(0xffEAE9E9),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.r))),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: priceController,
                              decoration: InputDecoration(
                                hintText: (priceController.text == "")
                                    ? "Price".tr
                                    : priceController.text + "\t" + "SR",
                                // hintTextDirection: Hint,
                                contentPadding:
                                    EdgeInsets.only(left: 15.h, right: 15.h),
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp),
                                //  prefixIcon: const Icon(Icons.search_sharp),
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  price = double.parse(value);
                                  price = double.parse(priceController.text);
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.h, right: 5.h, top: 10.h),
                    child: Material(
                      elevation: 10,
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      child: Container(
                        width: 350.w,
                        height: 80.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: const Color(0xffEAE9E9),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r))),
                        child: TextField(
                          controller: detailsController,
                          decoration: InputDecoration(
                            hintText: "Details".tr,
                            //  hintTextDirection: ,
                            // hintTextDirection: Hint,
                            contentPadding:
                                EdgeInsets.only(left: 15.h, right: 15.h),
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14.sp),
                            //  prefixIcon: const Icon(Icons.search_sharp),
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            setState(() {
                              details = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Card(
            child: Container(
                height: 250.h,
                width: 330.w,
                child: Center(
                  child: (imagePath.length == 0)
                      ? Icon(
                          Icons.add,
                          size: 250.sp,
                          color: Colors.white,
                        )
                      : Column(children: [
                          Container(
                            padding: EdgeInsets.only(top: 10.h),
                            height: 200.h,
                            // width: 360.w,
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
          //             ),
          // ),
          //SizedBox(height: 20,),
          //   ],
          // ),
          SizedBox(height: 12.h),

         (startProgress==true)?
            buildProgress():

          Container(
            child: Column(
              children: <Widget>[
                if ((selectedPlace != "All Places") &&
                        (selectedCategory != "All Categories") &&
                        (product != "") &&
                        (price != 0.0) &&
                        (details != "") &&
                        (detailsController.text != "") &&
                        (productController.text != "") &&
                        (priceController.text != "")
                    // &&
                    // (imagePath.length!=0)
                    )
                  // if (imagePath.length <= 9)

                  Padding(
                    padding: EdgeInsets.only(left: 30.h, right: 30.h),
                    child: InkWell(
                      onTap: () async {
                        await getImage();
                      },
                      child: DefualtButton(
                        selected: false,
                        text: (imagePath.length == 0)
                            ? "Take A Picture".tr
                            : "Take Another Picture".tr,
                      ),
                    ),
                  ),
                SizedBox(
                  height: 5.h,
                ),
              if   (
                (selectedPlace != "All Places") &&
                    (selectedCategory != "All Categories") &&
                    (product != "") &&
                    (price != 0.0) &&
                    (details != "") &&
                    (detailsController.text != "") &&
                    (productController.text != "") &&
                    (priceController.text != "") &&
                    (imagePath.length != 0)
                )
                  Padding(
                    padding: EdgeInsets.only(left: 30.h, right: 30.h),
                    child: InkWell(
                      child: DefualtButton(
                        selected: false,
                        text: "Add Product".tr,
                      ),
                      onTap: () async {
                        await uploadImage();
                        if (uploadDone == true) if (offersTaskDetails.contains(
                            PricingProduct(
                                category: selectedCategory,
                                details: details,
                                price: price,
                               // place: selectedPlace,
                                product: product,
                                images: images))) {
                        } else {
                         // setState(() {
                         //   startProgress=true;
                         // });
                          offersTaskDetails.add(PricingProduct(
                              category: selectedCategory,
                              details: details,
                              price: price,
                            //  place: selectedPlace,
                              product: product,
                              images: images));
                          setState(() {
                           // selectedPlace = "All Places";
                            selectedCategory = "All Categories";
                            imagePath = [];
                            product ="";
                            price =0.0;
                            details = "";
                            detailsController.text = "";
                            productController.text = "";
                            priceController.text = "";
                          });
                        }
                      },
                    ),
                  )
                   //  :
                 //(startProgress==true)
                      //?
                // buildProgress()
                     //:null,
              ],
            ),
            //  height: 130.h,
          ),

          //  if(imagePath.length > 1)
          // (startProgress==true)?
          //     buildProgress():
        ],
      ),
      bottomNavigationBar:
      (
      (offersTaskDetails.length > 0)
      &&
          (selectedPlace != "All Places") &&
          (selectedCategory == "All Categories") &&
          (product == "") &&
          (price == 0.0) &&
          (details == "") &&
          (detailsController.text == "") &&
          (productController.text == "") &&
          (priceController.text == "") &&
          (imagePath.length == 0)
      )
          ? Padding(
              padding: EdgeInsets.only(left: 15.h, right: 15.h),
              child: InkWell(
                onTap: () {
                  //if (offersTaskDetails.length > 0)
                    Get.to(() => OfferReview(
                      place: selectedPlace,
                          orderBy: widget.orderBy,
                          taskType: widget.taskType,
                          username: widget.username,
                          marketImage: widget.marketImage,
                          profileImage: widget.profileImage,
                          branch: widget.branch,
                          market: widget.market,
                          id: widget.id,
                          phone: widget.phone,
                          nationality: widget.nationality,
                          adminPhone: widget.adminPhone,
                          managerName: widget.managerName,
                        ));
                },
                child: DefualtButton(
                  selected: true,
                  text: "Review Offers".tr,
                ),
              ),
            )
          : null,
    );
  }

//   Future createPhotosTask(CapturePhotos capturePhotos) async {
//     final photoslist =
//     FirebaseFirestore.instance.collection(widget.title).doc();
//     final json = capturePhotos.toMap();
//     await photoslist.set(json);
//     doneTask=true;
//     //  final
//   }
  bool doneTask = false, uploadDone = false, startProgress = false;
  UploadTask? uploadTask;
  List<String> images = [];
//   //String rtvImage="";
//
  Future uploadImage() async {
    // setState(() {
    //   startProgress=true;
    // });
    for (int i = 0; i < imagePath.length; i++) {
      final file = File(imagePath[i]!.path);
      final ref = FirebaseStorage.instance.ref().child(imagePath[i]!.path);
      setState(() {
        startProgress = true;
        uploadTask = ref.putFile(file);
      });
      final snapShot = await uploadTask!.whenComplete(() {
        if (images.length == imagePath.length)
          setState(() {
            uploadDone = true;
            //startProgress=false;
          });

        // });
      });
      images.add(await snapShot.ref.getDownloadURL());
      setState(() {
        uploadTask = ref.putFile(file);
      });
    }
    setState(() {
      if (images.length == imagePath.length) uploadDone = true;
      startProgress = false;
    });
  }

//
// List<String> strCarPhotosList=[];
  List<File?> imagePath = [];

  final imagePicker = ImagePicker();

  Future getImage() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera,
     requestFullMetadata: true
     // preferredCameraDevice:
    );
    setState(() {
      imagePath.add(File(image!.path));
    });
  }

//
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

//
