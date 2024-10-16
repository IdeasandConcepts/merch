
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/rtv/rtv_with_ai.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/merch_nav_bar.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/profile/branch_appbar.dart';
import 'package:arrow_merchandising/models/rtv_model.dart';
import 'package:flutter/material.dart';
import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/rtv/rtv_review_body.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/daily%20tasks/rtv/scan_barcode.dart';
import 'package:arrow_merchandising/const.dart';
import 'package:arrow_merchandising/models/products.dart';
import 'package:arrow_merchandising/models/rtv_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:arrow_merchandising/view/widgets/custom_dropdown.dart';
import 'package:arrow_merchandising/view/widgets/custom_icon.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RtvSectionScreen extends StatefulWidget {
  final int id, phone, managerPhone;
  final String userName,
      manegerName,
      market,
      branch,
  place,
  category,
      marketImage,
      profileImage,
      nationality;
  final String orderBy,taskType;
  const RtvSectionScreen({
    super.key,
    required this.orderBy,
    required this.managerPhone,
    required this.userName,
    required this.market,
    required this.branch,
    required this.marketImage,
    required this.profileImage,
    required this.id,
    required this.phone,
    required this.nationality,
    required this.manegerName,
    required this.place,
    required this.category,
    required this.taskType,
  });
  // const RtvSectionScreen({super.key});

  @override
  State<RtvSectionScreen> createState() => _RtvSectionScreenState();
}

class _RtvSectionScreenState extends State<RtvSectionScreen> {
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
  List<String> branches=[];
  List<String> categories = [];
  String selectedCategory = "All Categories".tr;
  // List<String> productsList = [];
  // String selectedProduct = "";

  List<String> rtvType = [
    "Damaged".tr,
    "Expired".tr,
    "Near Expired".tr
  ];
  String selectedRtvType = "Expired";
bool selectPlace=false;
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
      selectedPlace=widget.place;
      selectedCategory=widget.category;
      getId();
      branches=categories;
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
            manegerName: widget.manegerName,
            phone: widget.phone,
            market: widget.market,
            marketImage: widget.marketImage,
            branch: widget.branch,
            username: widget.userName,
            profileImage: widget.profileImage,
          )),
      body: Padding(
        padding: EdgeInsets.only(top: 10.h, left: 10.h, right: 10.h),
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

                  /// UsingAi
                  GestureDetector(
                    onTap: () {
                      Get.to(() => RTVWithAi(
                        orderBy: widget.orderBy,
                            taskType: widget.taskType,
                            managerName: widget.manegerName,
                            phone: widget.phone,
                            managerPhone: widget.managerPhone,
                            market: widget.market,
                            marketImage: widget.marketImage,
                            username: widget.userName,
                            profileImage: widget.profileImage,
                            place: widget.place,
                            nationality: widget.nationality,
                            branch: widget.branch,
                            id: widget.id,
                          ));
                    },
                    child: CustomIconsButom(
                      icon: Icons.camera_alt_outlined,
                      titel: "Using AI".tr,
                      //onTap: () {},
                    ),
                  ),
                  SizedBox(width: 5.w),
                  /// Scan Barcode
                  InkWell(
                    onTap: () {
                      Get.to(() => ScanBarCode(
                            managerName: widget.manegerName,
                            phone: widget.phone,
                            market: widget.market,
                            marketImage: widget.marketImage,
                            branch: widget.branch,
                            userName: widget.userName,
                            managerPhone: widget.managerPhone,
                            profileImage: widget.profileImage,
                            // products: productsList,
                            //productsCodes: productsCodesList,
                          ));
                    },
                    child: CustomIconsButom(
                      icon: Icons.qr_code_scanner_outlined,
                      titel: "Scan Barcode".tr,
                      //onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),

            ///  Filter
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Container(
                height: 300.h,
                width: 378.w,
                //margin: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                    border: Border.all(width: 1.w),
                    borderRadius: BorderRadius.circular(10.r)),
                child: Column(children: [
                  Text("Filter".tr,
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 28.sp)),
                  SizedBox(height: 10.h),

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

                  /// RTV Type DropdownButton
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
                                    selectedRtvType = rtvType[index];
                                  });
                                },
                                value: 1,
                                child: Text("${rtvType[index].tr}",
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
                  //     hintText: selectedCategory,
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
                  //               child: Text("${categories[index]}".tr,
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
                                                if (!selectedRtvDetailsList
                                                    .contains(
                                                  product[index]
                                                          .productCategory +
                                                      selectedPlace +
                                                      product[index]
                                                          .productItemCode +
                                                      selectedRtvType,
                                                )) {
                                                  setState(() {
                                                    selectedRtvDetailsList.add(
                                                        product[index]
                                                                .productCategory +
                                                            selectedPlace +
                                                            product[index]
                                                                .productItemCode +
                                                            selectedRtvType);
                                                    rTVTaskDetails
                                                        .add(RTVProduct(
                                                      rType: selectedRtvType,
                                                      image:
                                                          product[index].photo,
                                                      barCode: product[index]
                                                          .productItemCode,
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
                ]),
              ),
            ),
            SizedBox(height: 12.h),
            AndroidRTVTaskBody(
              comeFrom: "Normal",
              place: selectedPlace,
              branch: widget.branch,
              nationality: widget.nationality,
              // marketDetails: widget.marketDetails,
              id: widget.id,
              phone: widget.phone,
              market: widget.market,
              username: widget.userName,
              marketImage: widget.marketImage,
              //merhandiserImage: widget.merhandiserImage,
              managerPhone: widget.managerPhone,
              profileImage: widget.profileImage,
            ),
            //SizedBox(height: 30.h),

            // Positioned(
            //     bottom: -60,
            //     left: 53,
            //     right: 53,
            //     child: SizedBox(height: 20,))
          ],
        ),
      ),
      bottomNavigationBar: (rTVTaskDetails.length > 0&&selectedPlace!="All Places")
          ? Padding(
              padding: EdgeInsets.only(
                left: 15.h,
                right: 15.h,
              ),
              child: InkWell(
                  onTap: () {
                    if(doneTask==false)
                    createRtVTask(RTVTaskModel(
                      taskType: widget.taskType,
                      orderBy: widget.orderBy,
                      type: selectedRtvType,
                      place:selectedPlace,
                      market: widget.market,
                      branch: widget.branch,
                      rtvProduct: rTVTaskDetails,
                      madeBy: widget.userName,
                      status: "done",
                      taskDate: (DateFormat('yyyy-MM-dd')
                          .format(DateTime.now())
                          .toString()),
                      taskTime: (DateFormat('kk:mm')
                          .format(DateTime.now())
                          .toString()),
                    ));

                  },
                  child: DefualtButton(selected: true, text: "Confirm".tr)),
            )
          : null,
    );
  }

  Future createRtVTask(RTVTaskModel rtvTask) async {
    final rtvData = FirebaseFirestore.instance.collection("RTV Products").doc();
    final json = rtvTask.toMap();
    await rtvData.set(json);
    setState(() {
      doneTask = true;
    });
    if (doneTask == true) {
      rTVTaskDetails = [];
      completeRtvTasks.add(selectedPlace);
      Get.to(() => MerchNavBar(
        tab_index: (widget.taskType=="New Task")?1:2,
        manegerName: widget.manegerName,
        nationality: widget.nationality,
        //marketDetails: widget.marketDetails,
        branch:
        //branch.customerName+"    "+
        widget.branch,
        market: widget.market,
        marketImage: widget.marketImage,
        username: widget.userName,
        profileImage: widget.profileImage,
        id: widget.id,
        phone: widget.phone,
        mangerphone: widget.managerPhone,
      ));
    }
  }
// bool doneTask=false;
//
//   UploadTask? uploadTask;
//   List<String>rtvPhotos=[];

  bool doneTask = false, uploadDone = false, startProgress = false;

  // Future uploadImage() async {
  //   final file=File(imagePath!.path!);
  //   final ref=
  //   FirebaseStorage.instance
  //       .ref().child(imagePath!.path!);
  //   setState(() {
  //     startProgress=true;
  //     uploadTask=ref.putFile(file);
  //   });
  //
  //   //buildProgress();
  //
  //   final snapShot=await uploadTask!.whenComplete(() {
  //
  //     setState(() {
  //       uploadDone=true;
  //       startProgress=false;
  //     });
  //   });
  //   rtvPhotos.add(await snapShot.ref.getDownloadURL());
  //   //  print(inventoryPhoto);
  //   setState(() {
  //     uploadTask=ref.putFile(file);
  //     uploadDone=true;
  //   });
  //   if((uploadTask!=null))
  //     setState(() {
  //       uploadDone=true;
  //       startProgress=false;
  //     });
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

// Stream<List<ProductsByPiece>> readCategoryList() => FirebaseFirestore.instance
//     .collection('arrow_products')
//     .snapshots()
//     .map((snapshot) => snapshot.docs
//         .map((doc) => ProductsByPiece.fromJson(doc.data()))
//         .toList());
}
