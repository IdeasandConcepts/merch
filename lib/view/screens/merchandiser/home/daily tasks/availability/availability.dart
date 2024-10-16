
import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/availability/all_availbility.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/availability/availability_chart_body.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/rtv/scan_barcode.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/merch_nav_bar.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/profile/branch_appbar.dart';
import 'package:arrow_merchandising/view/widgets/custom_dropdown.dart';
import 'package:arrow_merchandising/view/widgets/custom_icon.dart';
import 'package:arrow_merchandising/const.dart';
import 'package:arrow_merchandising/models/availability_products.dart';
import 'package:arrow_merchandising/models/availability_task.dart';
import 'package:arrow_merchandising/models/products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Availability extends StatefulWidget {
  final id, phone, managerPhone;
  final String username,
      manegerName,
      marketImage,
      profileImage,
      branch,
      place,
  category,
      market,
      nationality;
  final String orderBy, taskType;

  Availability({
    super.key,
    required this.managerPhone,
    required this.username,
    required this.marketImage,
    required this.profileImage,
    required this.branch,
    required this.market,
    required this.id,
    required this.phone,
    required this.nationality,
    required this.orderBy,
    required this.manegerName,
    required this.place,
    required this.taskType,
    required this.category,
  });

  @override
  State<Availability> createState() => _AvailabilityState();
}

class _AvailabilityState extends State<Availability> {
  TextEditingController productController = TextEditingController();
  TextEditingController productCountsController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  //ScrollController _scrollController = ScrollController();

  // from fire base
//  List<String> categories = [];
  // for search
  List<String> branches=[];
  
  String searchResult = "";
  String scanResult = "";
  bool readCategory = false, open_category = false;

  bool switchValue = false;

  List<String> places = [
    "On Shelves",
    "On Display",
    "On Gandola",
    "On Back Door"
  ];
  String selectedPlace = "On Shelves";
  bool selectPlace = false;
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
      selectedPlace = widget.place;
      selectedCategory=widget.category;
      getId();
      branches=categories;
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
            title: "Availability Section",
            manegerName: widget.manegerName,
            phone: widget.phone,
            market: widget.market,
            marketImage: widget.marketImage,
            branch: widget.branch,
            username: widget.username,
            profileImage: widget.profileImage,
          )),
      body: Column(children: [
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.h, right: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Search bar
              // Material(
              //   elevation: 10,
              //   borderRadius: BorderRadius.all(Radius.circular(10.r)),
              //   child: Container(
              //     width: 202.w,
              //     height: 45.h,
              //     alignment: Alignment.center,
              //     decoration: BoxDecoration(
              //         color: const Color(0xffEAE9E9),
              //         borderRadius: BorderRadius.all(Radius.circular(10.r))),
              //     child: TextField(
              //       controller: searchController,
              //       decoration: InputDecoration(
              //         hintText: "Search".tr + "\t" + "...",
              //         hintStyle: TextStyle(
              //             fontWeight: FontWeight.w400, fontSize: 14.sp),
              //         prefixIcon: const Icon(Icons.search_sharp),
              //         border: InputBorder.none,
              //       ),
              //       onChanged: (value) {},
              //       onSubmitted: (value) {},
              //     ),
              //   ),
              // ),
          Padding(
          padding: const EdgeInsets.only(left:15,right: 15),
          child: Material(
            elevation: 10,
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            child: Container(
              width: 200.w,
              height: 55.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color(0xffEAE9E9),
                  borderRadius: BorderRadius.all(Radius.circular(10.r))),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search".tr+"\t...\t",
                  hintStyle:
                  TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp),
                  prefixIcon: const Icon(Icons.search_sharp),
                  border: InputBorder.none,
                ),
                onChanged: (value){
                  setState(() {
                    getId();
                    searchResult=value;
                    runFilter(value);
                    // searchResult=value;
                  });
                },
                onSubmitted: (newValue){
                  setState(() {
                    getId();
                    searchResult=newValue;
                    runFilter(newValue);
                    // searchResult=newValue;
                  });
                },
              ),
            ),)
          ),
              // Scan Barcode
              GestureDetector(
                onTap: () {
                  Get.to(() => AvailabilityWithAi(
                    category: selectedCategory,
                        orderBy: widget.orderBy,
                        taskType: widget.taskType,
                        managerName: widget.manegerName,
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
                      ));
                  // selectedCategory=
                },
                child: CustomIconsButom(
                  icon: Icons.camera_alt_outlined,
                  titel: "Using AI",
                  //onTap: () {},
                ),
              ),
              // Scan Barcode
              InkWell(
                onTap: () {
                  Get.to(() => ScanBarCode(
                        managerName: widget.manegerName,
                        phone: widget.phone,
                        market: widget.market,
                        marketImage: widget.marketImage,
                        branch: widget.branch,
                        userName: widget.username,
                        managerPhone: widget.managerPhone,
                        profileImage: widget.profileImage,
                        // products: productsList,
                        //productsCodes: productsCodesList,
                      ));
                },
                child: CustomIconsButom(
                  icon: Icons.qr_code_scanner_outlined,
                  titel: "Scan Barcode",
                  //onTap: () {},
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15.h),

        ///  Filter
        Container(
          height: 240.h,
          width: 378.w,
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
              border: Border.all(width: 1.w),
              borderRadius: BorderRadius.circular(10.r)),
          child: Column(children: [
            Text("Filter".tr,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28.sp)),
            SizedBox(height: 12.h),

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
            SizedBox(height: 12.h),
            //
            
            // category
            (searchResult=="")?
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
                )):
            SizedBox(
              height: 320,
              child: Container(
                  height:MediaQuery.of(context).size.height - 100,
                  child: ListView.builder(
                      key: ValueKey(branches[0].toString()) ,
                      itemCount: branches.length,
                      itemBuilder:(context,index){
                        {
                          return ListTile(
                              title: Text(branches[index]),
                              onTap: () {
                             setState(() {
                               selectedCategory=branches[index];
                               searchResult="";
                               searchController.text="";
                             });
                                print(branches[index]);
                              }
                          );
                        }

                      }
                  )
              ),
            ),

            ///
            SizedBox(height: 12.h),
            // Product DropdownButton
            SingleChildScrollView(
              child: Container(
                // padding: EdgeInsets.only(
                //     top: 10, bottom: 10, left: 10, right: 10),
                decoration: BoxDecoration(),
                child: StreamBuilder<List<ProductsByPiece>>(
                    stream: readCategoryProducts(selectedCategory),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text(' Error ya Ahmed :: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final product = snapshot.data!;
                        return CustomDropdownButton(
                            onChanged: (value) {},
                            //onTap: () {},
                            hintText: "All Products".tr,
                            items: List.generate(
                              product.length,
                              (index) =>
                                  //null)
                                  DropdownMenuItem(
                                      onTap: () {
                                        setState(() {
                                          //selectedProduct = product[index];
                                          if (!selectedAvailabilityProducts
                                              .contains(
                                            product[index].productCategory +
                                                product[index].productItemCode,
                                          )) {
                                            setState(() {
                                              selectedAvailabilityProducts.add(
                                                  product[index]
                                                          .productCategory +
                                                      product[index]
                                                          .productItemCode);
                                              availabilityTaskDetails
                                                  .add(AvailabilityProduct(
                                                image: product[index].photo,
                                                weight:
                                                    product[index].productSize,
                                                prCategory: product[index]
                                                    .productCategory,
                                                product: "Pringles" +
                                                    "\t" +
                                                    product[index].productName +
                                                    "\t" +
                                                    "${product[index].productSize}",
                                                prAmount: 1,
                                                //pType:"Piece"
                                              ));
                                              // selectedInventoryProducts.add( myProducts.productDescription);
                                            });

                                            // productCount_Controller.clear();
                                            //Get.back();
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "This Product has already been added",
                                                backgroundColor: Colors.grey,
                                                toastLength: Toast.LENGTH_LONG,
                                                fontSize: 20,
                                                gravity: ToastGravity.CENTER);
                                            //productCount_Controller.clear();
                                            // Get.back();
                                          }
                                        });
                                      },
                                      value: 1,
                                      child: Text(
                                          product[index].productName.tr +
                                              "\t" +
                                              product[index].productDetails,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp))),
                            ));
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ),
            SizedBox(height: 12.h),
          ]),
        ),
        //SizedBox(height: 12.h),
        SizedBox(height: 12.h),
       // SizedBox(height: 12.h),
        AndroidAvailabilityTaskBody(
          comeFrom: "Normal",
          branch: widget.branch,
          nationality: widget.nationality,
          id: widget.id,
          phone: widget.phone,
          market: widget.market,
          username: widget.username,
          marketImage: widget.marketImage,
          managerPhone: widget.managerPhone,
          profileImage: widget.profileImage,
        ),
      ]),
      bottomNavigationBar: (availabilityTaskDetails.length > 0&&selectedPlace!="All Places")
          ? Padding(
              padding: EdgeInsets.only(
                left: 15.h,
                right: 15.h,
              ),
              child: InkWell(
                onTap: () {
                  // if (true) {
                  createAvailabilityTask(AvailabilityTaskModel(
                    taskType: widget.taskType,
                    orderBy: widget.orderBy,
                    photo: availabilityTaskDetails[0].image,
                    place: selectedPlace,
                    // photo: inventoryPhoto,
                    market: widget.market,
                    branch: widget.branch,
                    availabilityProduct: availabilityTaskDetails,
                    madeBy: widget.username,
                    taskDate: (DateFormat('yyyy-MM-dd')
                        .format(DateTime.now())
                        .toString()),
                    taskTime:
                        (DateFormat('kk:mm').format(DateTime.now()).toString()),
                    status: "Done",
                  ));

                  setState(() {
                    availabilityTaskDetails = [];
                    selectedAvailabilityProducts = [];
                    completeAvailabilityTasks.add(selectedPlace);
                  });
                  Get.offAll(() => MerchNavBar(
                      tab_index: (widget.taskType == "New Task") ? 1 : 2,
                      //username: username, marketImage: marketImage, profileImage: profileImage, branch: branch, market: market, id: id, phone: phone, manegerName: manegerName, nationality: nationality, mangerphone: mangerphone)
                      manegerName: widget.manegerName,
                      username: widget.username,
                      marketImage: widget.marketImage,
                      profileImage: widget.profileImage,
                      branch: widget.branch,
                      market: widget.market,
                      id: widget.id,
                      phone: widget.phone,
                      nationality: widget.nationality,
                      mangerphone: widget.managerPhone));
                  //}
                },
                child: DefualtButton(
                  selected: true,
                  text: "Confirm".tr,
                ),
                // child: Container(
                //     padding: EdgeInsets.all(5),
                //     decoration: BoxDecoration(
                //         color: kprimaryColor,
                //         borderRadius: BorderRadius.circular(10)),
                //     width: double.infinity,
                //     height: 60.h,
                //     child: Center(
                //       child: Text(
                //         "Confirm".tr,
                //         style: TextStyle(
                //           fontWeight: FontWeight.bold,
                //           fontSize: 20.sp,
                //           color: Colors.white,
                //         ),
                //       ),
                //     ),
                //     // ),
                //   ),
              ),
            )
          : null,
    );
  }

  Future createAvailabilityTask(AvailabilityTaskModel availabilityTask) async {
    final availabilityData =
        FirebaseFirestore.instance.collection('Availability').doc();
    final json = availabilityTask.toMap();
    await availabilityData.set(json);
    doneTask = true;
  }
// bool doneTask=false;

  bool doneTask = false, uploadDone = false, startProgress = false;
  UploadTask? uploadTask;
  String AvailabilityImagePath = "";
//
// Future uploadImage() async {
// final file=File(ima//!.path!);
// final ref=
// FirebaseStorage.instance
//     .ref().child("Availability Pictures/"+DateTime.now().toString()+'.png');
// setState(() {
// startProgress=true;
// uploadTask=ref.putFile(file);
// });
//
// final snapShot=await uploadTask!.whenComplete(() {
//
// setState(() {
// uploadDone=true;
// startProgress=false;
// });
// });
// AvailabilityImagePath= (await snapShot.ref.getDownloadURL());
// print(AvailabilityImagePath);
// setState(() {
// uploadTask=ref.putFile(file);
// uploadDone=true;
// });
// if(AvailabilityImagePath!="")
// setState(() {
// uploadDone=true;
// startProgress=false;
// });
// }

// List<String> strCarPhotosList=[];
//File? imagePath;
//
//
//   final imagePicker = ImagePicker();
//
//   Future  getImage() async {
//     final image = await imagePicker.pickImage(source: ImageSource.camera);
//     setState(() {
//       //availabilityDisplayPhotos=[];
//       imagePath=File(image!.path);
//       availabilityDisplayPhotos.add(File(image!.path));
//       //inventoryPhoto==imagePath!.path!.toString();
//     });
//   }

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

// getDropList(double width, double height, ) {
  //   return  Container(
  //     width: width,
  //     height: height*0.36,
  //     margin:  EdgeInsets.only(left: 10 ,right: 10),
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10),
  //         border: Border.all(
  //             style: BorderStyle.solid
  //         )),
  //     child:  Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: [
  //         Text("Filter",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Card(
  //             elevation: 10,
  //             child: Container(
  //               padding: EdgeInsets.all(5),
  //               decoration: BoxDecoration(
  //                 color: BgroundColor,
  //                 borderRadius:BorderRadius.all(Radius.circular(10)),
  //               ),
  //               child: DropdownButton(
  //                 iconSize: 40,
  //                 elevation: 15,
  //                 underline: SizedBox(),
  //                 value: displayTitle[0],
  //                 borderRadius: BorderRadius.all(Radius.circular(10)),
  //                 items: displayTitle.map((e) => DropdownMenuItem(
  //                     value: e,
  //                     child:Text(e))).toList(),
  //                 isExpanded: true,
  //                 onChanged: (String? value) {
  //                  // c.initDrop1.value=value!;
  //                 },),
  //             ),
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Card(
  //             elevation: 10,
  //             child: Container(
  //               padding: EdgeInsets.all(5),
  //               decoration: BoxDecoration(
  //                 color: BgroundColor,
  //                 borderRadius:BorderRadius.all(Radius.circular(10)),
  //               ),
  //               child: DropdownButton(
  //                 iconSize: 40,
  //                 value: categoryTitle[0],
  //                 underline: SizedBox(),
  //                 elevation: 15,
  //                 borderRadius: BorderRadius.all(Radius.circular(10)),
  //                 items: categoryTitle.map((e) => DropdownMenuItem(
  //                     value: e,
  //                     child:Text(e))).toList(),
  //                 isExpanded: true,
  //                 onChanged: (String? value) {
  //                  // c.initDrop2.value=value!;
  //                 },),
  //             ),
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Card(
  //             elevation: 10,
  //             child: Container(
  //               padding: EdgeInsets.all(5),
  //               decoration: BoxDecoration(
  //                 color:BgroundColor,
  //                 borderRadius:BorderRadius.all(Radius.circular(10)),
  //               ),
  //               child: DropdownButton(
  //                 iconSize: 40,
  //                 value: productTitle[0],
  //                 underline: SizedBox(),
  //                 elevation: 15,
  //                 borderRadius: BorderRadius.all(Radius.circular(10)),
  //                 items: productTitle.map((e) => DropdownMenuItem(
  //                     value: e,
  //                     child:Text(e))).toList(),
  //                 isExpanded: true,
  //                 onChanged: (String? value) {
  //                  // c.initDrop3.value=value!;
  //                 },),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),);
  // }

  // getStockList() {
  //   return ListView(
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Container(
  //           height: 130,
  //           color: BgroundColor,
  //           child: Column(
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Image.asset("assets/im.jpg",
  //                       width: 50,
  //                       height: 50,),
  //                   ),
  //                   Text("pringles chips 40 bbq")
  //                 ],),
  //               Obx(() =>
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: GestureDetector(
  //                           onTap: (){
  //                            // c.isSelectCat[0]=!c.isSelectCat[0];
  //                           },
  //                           child: Container(
  //                             height:40 ,
  //                             width: 100,
  //                             child: Center(child: Text("High Stock")),
  //                             decoration: BoxDecoration(
  //                               border: Border.all(
  //                                   style: BorderStyle.solid
  //                               ),
  //                               borderRadius: BorderRadius.circular(5),
  //                               color: primaryColor
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: GestureDetector(
  //                           onTap: (){
  //                           //  c.isSelectCat[1]=!c.isSelectCat[1];
  //                           },
  //                           child: Container(
  //                             height:40 ,
  //                             width: 100,
  //                             child: Center(child: Text("Low Stock")),
  //                             decoration: BoxDecoration(
  //                               border: Border.all(
  //                                   style: BorderStyle.solid
  //                               ),
  //                               borderRadius: BorderRadius.circular(5),
  //                               color: primaryColor
  //                               //c.isSelectCat[1]?primaryColor:Colors.white,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: GestureDetector(
  //                           onTap: (){
  //                            // c.isSelectCat[2]=!c.isSelectCat[2];
  //                           },
  //                           child: Container(
  //                             height:40 ,
  //                             width: 100,
  //                             child: Center(child: Text("Not Available")),
  //                             decoration: BoxDecoration(
  //                               border: Border.all(
  //                                   style: BorderStyle.solid
  //                               ),
  //                               borderRadius: BorderRadius.circular(5),
  //                               color: primaryColor
  //                             ),
  //                           ),
  //                         ),
  //                       ),],),)
  //             ],),),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Container(
  //           height: 130,
  //           color: BgroundColor,
  //           child: Column(
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Image.asset("assets/im.jpg",
  //                       width: 50,
  //                       height: 50,),
  //                   ),
  //                   Text("pringles chips 40 bbq")
  //                 ],),
  //               Obx(() =>
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: GestureDetector(
  //                           onTap: (){
  //                            // c.isSelectCat2[0]=!c.isSelectCat2[0];
  //                           },
  //                           child: Container(
  //                             height:40 ,
  //                             width: 100,
  //                             child: Center(child: Text("High Stock")),
  //                             decoration: BoxDecoration(
  //                               border: Border.all(
  //                                   style: BorderStyle.solid
  //                               ),
  //                               borderRadius: BorderRadius.circular(5),
  //                               color:primaryColor
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: GestureDetector(
  //                           onTap: (){
  //                             //c.isSelectCat2[1]=!c.isSelectCat2[1];
  //                           },
  //                           child: Container(
  //                             height:40 ,
  //                             width: 100,
  //                             child: Center(child: Text("5")),
  //                             decoration: BoxDecoration(
  //                               border: Border.all(
  //                                   style: BorderStyle.solid
  //                               ),
  //                               borderRadius: BorderRadius.circular(5),
  //                               color:primaryColor
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: GestureDetector(
  //                           onTap: (){
  //                            // c.isSelectCat2[2]=!c.isSelectCat2[2];
  //                           },
  //                           child: Container(
  //                             height:40 ,
  //                             width: 100,
  //                             child: Center(child: Text("Not Available")),
  //                             decoration: BoxDecoration(
  //                               border: Border.all(
  //                                   style: BorderStyle.solid
  //                               ),
  //                               borderRadius: BorderRadius.circular(5),
  //                               color:primaryColor
  //                             ),
  //                           ),
  //                         ),
  //                       ),],),)
  //             ],),),
  //       ),
  //
  //     ],
  //   );
  // }
  void runFilter(String branch){

    if(branch.isEmpty){
      searchResult="";
    }else{
      branches=categories
          .where((branchesList) =>
          branchesList.toLowerCase().contains(branch.toLowerCase())).toList();
    }
  }
  Stream<List<ProductsByPiece>> readCategoryProducts(String category) =>
      FirebaseFirestore.instance
          .collection('arrow_products')
          .where(
            'category',
            isEqualTo: category,
          )
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => ProductsByPiece.fromJson(doc.data()))
              .toList());
}
