import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/invintory/inventory_with_ai.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/invintory/incentory_chart_body.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/merch_nav_bar.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/profile/branch_appbar.dart';
import 'package:arrow_merchandising/view/widgets/custom_dropdown.dart';
import 'package:arrow_merchandising/view/widgets/custom_icon.dart';
import 'package:arrow_merchandising/const.dart';
import 'package:arrow_merchandising/models/inventory_products.dart';
import 'package:arrow_merchandising/models/inventory_task.dart';
import 'package:arrow_merchandising/models/products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class InventoryScreen extends StatefulWidget {
  //const InventoryScreen({super.key});
  final int id, phone, managerPhone;
  final String marketImage,
      profileImage,
      username,
      managerName,
      place,
  category,
      branch,
      market,
      nationality,
      orderBy,
      taskType;

  // final String comeFrom;
  const InventoryScreen(
      {super.key,
      required this.orderBy,
      required this.managerPhone,
      required this.marketImage,
      required this.profileImage,
      required this.username,
      required this.branch,
      required this.market,
      required this.id,
      required this.phone,
      required this.nationality,
      required this.taskType,
      required this.managerName,
      required this.place,
        required this.category});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  TextEditingController productController = TextEditingController();
  TextEditingController productCountsController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  //ScrollController _scrollController = ScrollController();

  //int productCounts = 0;

  //final formkey = GlobalKey<FormState>();
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
  String selectedPlace = "All Places";
  bool selectPlace = false;
  List<String> branches=[];
  List<String> categories = [];
  String selectedCategory = "All Categories";
  // List<String> productsList = [];
  // String selectedProduct = "";
  //
  // List<String> rtvType = [
  //   "Damaged Product's".tr,
  //   "Expired Product's".tr,
  //   "Near Expired Product's".tr
  // ];
  //String selectedRtvType = "Expired";

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
          for (int i = 0; i < data.length; i++) {
            if (categories.contains(data['category'])) {
            } else {
              setState(() {
                categories.add(data['category']);
              });
              //  });
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
      selectedPlace = widget.place;
      selectedCategory=widget.category;
      getId();
      branches = categories;
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
              title: "Inventory Section",
              manegerName: widget.managerName,
              phone: widget.phone,
              market: widget.market,
              marketImage: widget.marketImage,
              branch: widget.branch,
              username: widget.username,
              profileImage: widget.profileImage,
            )),
        body: Padding(
          padding: EdgeInsets.only(top: 15.h, bottom: 5.h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Search bar
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
                    // Material(
                    //   elevation: 10,
                    //   borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    //   child: Container(
                    //     width: 202.w,
                    //     height: 45.h,
                    //     alignment: Alignment.center,
                    //     decoration: BoxDecoration(
                    //         color: const Color(0xffEAE9E9),
                    //         borderRadius:
                    //             BorderRadius.all(Radius.circular(10.r))),
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
                    // CustomSearchBar(
                    //   width: 202.w,
                    //   height: 45.h,
                    //   onChanged: (value) {},
                    //   onSubmitted: (value) {},
                    // ),

                    /// Scan Using AI
                    GestureDetector(
                      onTap: () {
                        Get.to(() => InventoryWithAi(
                          category: selectedCategory,
                              taskType: widget.taskType,
                              orderBy: widget.orderBy,
                              managerName: widget.managerName,
                              phone: widget.phone,
                              managerPhone: widget.managerPhone,
                              market: widget.market,
                              marketImage: widget.marketImage,
                              username: widget.username,
                              profileImage: widget.profileImage,
                              place: widget.place,
                              nationality: widget.nationality,
                              branch: widget.branch,
                              id: widget.id,
                            ));
                      },
                      child: CustomIconsButom(
                        icon: Icons.camera_alt_outlined,
                        titel: "Using AI",
                        //onTap: () {},
                      ),
                    ),

                    /// Scan Barcode
                    CustomIconsButom(
                      icon: Icons.qr_code_scanner_outlined,
                      titel: "Scan Barcode",
                      //onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),

              ///  Filter
              Container(
                height: 250.h,
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

                  // CustomDropdownButton(
                  //     onChanged: (value) {},
                  //     onTap: () {},
                  //     hintText: selectedCategory.tr,
                  //     items: List.generate(
                  //       categories.length,
                  //       (index) =>
                  //           // null)[
                  //           DropdownMenuItem(
                  //               onTap: () {
                  //                 setState(() {
                  //                   selectedCategory = categories[index];
                  //                 });
                  //               },
                  //               value: 1,
                  //               child: Text("${categories[index]}",
                  //                   style: TextStyle(
                  //                       fontWeight: FontWeight.w500,
                  //                       fontSize: 14.sp))),
                  //     )),
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
                              return Text(
                                  ' Error ya Ahmed :: ${snapshot.error}');
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
                                                if (!selectedInventoryProducts
                                                    .contains(
                                                  product[index]
                                                          .productCategory +
                                                      product[index]
                                                          .productItemCode,
                                                  //      RTVProduct(
                                                  //        image: product[index].photo,
                                                  //        barCode: product[index].productItemCode,
                                                  //        prCategory: product[index].productCategory,
                                                  //        product:  product[index].productName,
                                                  //        prAmount: 1,
                                                  //        //pType:"Piece"
                                                )) {
                                                  setState(() {
                                                    selectedInventoryProducts
                                                        .add(product[index]
                                                                .productCategory +
                                                            product[index]
                                                                .productItemCode);
                                                    inventoryTaskDetails
                                                        .add(InventoryProduct(
                                                      weight: product[index]
                                                          .productSize,
                                                      image:
                                                          product[index].photo,
                                                      // barCode: product[index].productItemCode,
                                                      prCategory: product[index]
                                                          .productCategory,
                                                      product: product[index]
                                                              .productName +
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
                                                      backgroundColor:
                                                          Colors.grey,
                                                      toastLength:
                                                          Toast.LENGTH_LONG,
                                                      fontSize: 20,
                                                      gravity:
                                                          ToastGravity.CENTER);
                                                  //productCount_Controller.clear();
                                                  // Get.back();
                                                }
                                              });
                                            },
                                            value: 1,
                                            child: Text(
                                                product[index].productName +
                                                    "\t" +
                                                    product[index]
                                                        .productDetails,
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

              SizedBox(height: 5.h),
              InventoryChartBody(
                comeFrom: "Normal",
                place: selectedPlace,
                branch: widget.branch,
                nationality: widget.nationality,
                // marketDetails: widget.marketDetails,
                id: widget.id,
                phone: widget.phone,
                market: widget.market,
                username: widget.username,
                marketImage: widget.marketImage,
                //merhandiserImage: widget.merhandiserImage,
                managerPhone: widget.managerPhone,
                profileImage: widget.profileImage,
              ),
              // SizedBox(height: 10,),
              //  SizedBox(height: 12.h),
              // )
            ],
          ),
        ),
        bottomNavigationBar: (inventoryTaskDetails.length > 0&&selectedPlace!="All Places")
            ? Padding(
                padding: EdgeInsets.only(
                  left: 15.h,
                  right: 15.h,
                ),
                child: InkWell(
                  onTap: () async {
                    //onTap: () async {
                    //   await uploadImage();

                    // if (uploadDone = true)
                    // {
                    // if(inventoryPhoto.length>0)
                    // (doneTask == false)
                      createInventoryTask(InventoryTask(
                        taskType: widget.taskType,
                        orderBy: widget.orderBy,
                        place: selectedPlace,
                        market: widget.market,
                        branch: widget.branch,
                        inventoryProduct: inventoryTaskDetails,
                        //widget.inventoryProduct,
                        madeBy: widget.username,
                        taskDate: (DateFormat('yyyy-MM-dd')
                            .format(DateTime.now())
                            .toString()),
                        taskTime: (DateFormat('kk:mm')
                            .format(DateTime.now())
                            .toString()),
                        status: "Done",
                      ));


                  },
                  child: (startProgress == false)
                      ? DefualtButton(
                          selected: true,
                          text: (widget.taskType== "Daily Task")
                              ? "Confirm".tr
                              : "Finish".tr,
                        )
                      : buildProgress(),
                ),
                // ),
              )
            : null);
  }

  Future createInventoryTask(InventoryTask inventoryTask) async {
    // bool createTask=false;
    final rtvData =
        FirebaseFirestore.instance.collection('Inventory Tasks').doc();
    final json = inventoryTask.toMap();
    await rtvData.set(json);
    // if(rtvData.set(json)==true)
    //   createTask=true;
    // doneTask=createTask;
setState(() {
  doneTask=true;
});
    if (doneTask == true) {
      // startProgress=true;
      Get.offAll(() => MerchNavBar(
          tab_index: (widget.taskType == "New Task") ? 1 : 2,
          manegerName: widget.managerName,
          username: widget.username,
          marketImage: widget.marketImage,
          profileImage: widget.profileImage,
          branch: widget.branch,
          market: widget.market,
          id: widget.id,
          phone: widget.phone,
          //marketDetails:widget. marketDetails,
          nationality: widget.nationality,
          mangerphone: widget.managerPhone));

      selectedInventoryProducts = [];
      inventoryTaskDetails = [];
      //displayPhoto = [];
      //inventoryPhoto=[];
      setState(() {
        completeInventoryTasks.add(selectedPlace);
      });
// Get.defaultDialog(
//
// );
    } else {
      buildProgress();
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
  void runFilter(String branch){

    if(branch.isEmpty){
      searchResult="";
    }else{
      branches=categories
          .where((branchesList) =>
          branchesList.toLowerCase().contains(branch.toLowerCase())).toList();
    }
  }
}
