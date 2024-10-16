import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/view/screens/splash/auth_page.dart';
import 'package:arrow_merchandising/const.dart';
import 'package:arrow_merchandising/view/screens/add_task/add_task_details.dart';
import 'package:arrow_merchandising/view/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';



class AddTaskScreen extends StatefulWidget {
  final String comeFrom;
  final int id, phone;
  final String profileImage;
  final String userName;
  final String selectedMarket,
      selectedMarketImage,
      selectedBranch,
      selectedMerch;
  final String taskTitle;
  const AddTaskScreen(
      {super.key,
      required this.selectedMarket,
      required this.selectedMarketImage,
      required this.profileImage,
      required this.userName,
      required this.id,
      required this.phone,
      required this.selectedBranch,
      required this.selectedMerch,
      required this.comeFrom,
      required this.taskTitle});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final formkey = GlobalKey<FormState>();
  TextEditingController detailsController = TextEditingController();
  TextEditingController taskDateController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  String details = "",
      date = "",
      searchResult = "",
      selectedPlace = "All Places";
  String newBranch = "", newMarket = "";
  late DateTime taskDate;
  String selectedMerchandiser = "";

  // bool anyMerchandiserRadio=false;
  bool selectMerchandisersRadio = false;
  bool firstMerchandiserRadio = false;
  bool secondMerchandisersRadio = false;
  bool thirdMerchandiserRadio = false;

  bool cancelFirstMerch = false,
      cancelSecondMerch = false,
      anyMerchandiserBoxValue = false,
      checkBoxValue = false,
      branchBoxValue = false;

  List<String> markets = [],
      branches = [],
      places = ["On Shelves", "On Display", "On Gandola", "On Back Door"],
      // usedMerchandiser = [],
      merchandiserList = [];

  // List<String> selectedMerchList = [];
  Future getMarket() async {
    setState(() {
      markets = [];
    });
    await FirebaseFirestore.instance
        .collection('Super_markets')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection('Super_markets')
            .doc(element.reference.id)
            .get()
            .then((value) {
          Map<String, dynamic> branchData =
              value.data() as Map<String, dynamic>;
          print(branchData['market_name']);

          if (!markets.contains(branchData['market_name'])) {
            setState(() {
              markets.add(branchData['market_name']);
            });
          }
        });
      });
    });
    if (widget.selectedMarket != "All Markets")
      await FirebaseFirestore.instance
          .collection(widget.selectedMarket)
          .get()
          .then((snapshot) {
        snapshot.docs.forEach((element) {
          FirebaseFirestore.instance
              .collection(widget.selectedMarket)
              .doc(element.reference.id)
              .get()
              .then((value) {
            Map<String, dynamic> branchData =
                value.data() as Map<String, dynamic>;
            print(branchData['branch_name']);
            if (!branches.contains(branchData['branch_name'])) {
              setState(() {
                branches.add(branchData['branch_name']);
              });
            }
          });
        });
      });
  }

  Future getMerchandiser(String market) async {
    setState(() {
      merchandiserList = [];
    });
    // get Merchandiser
    await FirebaseFirestore.instance
        .collection('Merchandisers')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection("Merchandisers")
            .doc(element.reference.id)
            .get()
            .then((value) {
          Map<String, dynamic> data = value.data() as Map<String, dynamic>;
          // print(data['name']);
          if (!merchandiserList.contains(data['full_name'])) {
            setState(() {
              merchandiserList.add(data['full_name']);
            });
          }
        });
      });
    });

    // get Markets
  }

  // get branches
  Future getBranch(String myMarket) async {
    setState(() {
      branches = [];
    });
    // get branches
    await FirebaseFirestore.instance
        .collection(myMarket)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection(myMarket)
            .doc(element.reference.id)
            .get()
            .then((value) {
          Map<String, dynamic> branchData =
              value.data() as Map<String, dynamic>;
          print(branchData['branch_name']);
          if (!branches.contains(branchData['branch_name'])) {
            setState(() {
              branches.add(branchData['branch_name']);
            });
          }
        });
      });
    });
  }

  @override
  void initState() {
    setState(() {
      newBranch = widget.selectedBranch;
      newMarket = widget.selectedMarket;
      selectedMerchandiser = widget.selectedMerch;
      getMarket();
      getBranch(widget.selectedMarket);
      getMerchandiser(widget.selectedMarket);
    });
    // TODO: implement initState
    super.initState();
    getMarket();
    getBranch(widget.selectedMarket);
    getMerchandiser(widget.selectedMarket);
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
        title: Text(
          "",
          style: TextStyle(color: Colors.white, fontSize: 20.sp),
        ),
        leading: IconButton(
            onPressed: () {
              Get.offAll(AndroidAuthPage());
            },
            icon: Icon(
              Icons.home,
              color: Colors.white,
            )),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),

          /// add Task Details
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Material(
                elevation: 20,
                borderRadius: BorderRadius.circular(11.r),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.w),
                      borderRadius: BorderRadius.circular(11.r)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.taskTitle.tr,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 28.sp)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.w, right: 15.w),
                        child: Material(
                          elevation: 10,
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: const Color(0xffEAE9E9),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.r))),
                            child: TextFormField(
                              controller: searchController,
                              decoration: InputDecoration(
                                hintText: "Search".tr,
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp),
                                prefixIcon: const Icon(Icons.search_sharp),
                                border: InputBorder.none,
                              ),
                              onSaved: (newValue) => searchResult = newValue!,
                              onChanged: (value) => searchResult = value,
                            ),
                          ),
                        ),
                        //  const CustomSearchBar(height: 45),
                      ),
                      SizedBox(height: 12.h),

                      /// Market DropdownButton
                      (widget.selectedMarket != "All Markets")
                          ? CustomDropdownButton(
                              onChanged: (value) {},
                              onTap: () {},
                              hintText: widget.selectedMarket.tr,
                              items: List.generate(
                                1,
                                (index) => DropdownMenuItem(
                                    value: 1,
                                    child: Text(widget.selectedMarket.tr,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp))),
                              ),
                            )
                          : CustomDropdownButton(
                              onChanged: (value) {},
                              onTap: () {},
                              hintText: newMarket.tr,
                              items: List.generate(
                                markets.length,
                                (index) => DropdownMenuItem(
                                    onTap: () {
                                      setState(() {
                                        newMarket = markets[index];
                                        getMerchandiser(markets[index]);
                                        getBranch(markets[index]);
                                      });
                                    },
                                    value: 1,
                                    child: Text(markets[index],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp))),
                              ),
                            ),
                      SizedBox(height: 12.h),

                      /// Market DropdownButton
                      (widget.selectedBranch != "All Branches")
                          ? CustomDropdownButton(
                              onChanged: (value) {
                                getBranch(newMarket);
                              },
                              onTap: () {
                                getBranch(newMarket);
                              },
                              hintText: widget.selectedBranch.tr,
                              items: List.generate(
                                1,
                                (index) => DropdownMenuItem(
                                    value: 1,
                                    child: Text(widget.selectedBranch.tr,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp))),
                              ))
                          : CustomDropdownButton(
                              onChanged: (value) {},
                              onTap: () {},
                              hintText: newBranch.tr,
                              items: List.generate(
                                branches.length,
                                (index) => DropdownMenuItem(
                                    onTap: () {
                                      setState(() {
                                        newBranch = branches[index];
                                      });
                                    },
                                    value: 1,
                                    child: Text(branches[index],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp))),
                              )),

                      SizedBox(height: 12.h),

                      /// Merchandisers DropdownButton
                      (widget.selectedMerch != "")
                          ? CustomDropdownButton(
                              onChanged: (value) {},
                              onTap: () {},
                              hintText: widget.selectedMerch.tr,
                              items: List.generate(
                                1,
                                (index) => DropdownMenuItem(
                                    onTap: () {},
                                    value: 1,
                                    child: Text(widget.selectedMerch.tr,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp))),
                              ))
                          : CustomDropdownButton(
                              onChanged: (value) {},
                              onTap: () {},
                              hintText: (selectedMerchandiser != "")
                                  ? selectedMerchandiser.tr
                                  : "Merchandiser".tr,
                              items: List.generate(
                                merchandiserList.length,
                                (index) => DropdownMenuItem(
                                    onTap: () {
                                      // getId();
                                      setState(() {
                                        selectedMerchandiser =
                                            merchandiserList[index];
                                      });
                                    },
                                    value: 1,
                                    child: Text(merchandiserList[index],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp))),
                              )),
                      SizedBox(height: 12.h),
                      // SizedBox(height: 12.h),
                      CustomDropdownButton(
                          onChanged: (value) {},
                          onTap: () {},
                          hintText: (selectedPlace != "")
                              ? selectedPlace.tr
                              : "Place".tr,
                          items: List.generate(
                            places.length,
                            (index) => DropdownMenuItem(
                                onTap: () {
                                  setState(() {
                                    selectedPlace = places[index];
                                  });
                                },
                                value: 1,
                                child: Text(places[index],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp))),
                          )),
                      SizedBox(height: 12.h),
                      //Date
                      Padding(
                        padding: EdgeInsets.only(left: 10.w, right: 10.w),
                        child: Material(
                          borderRadius: BorderRadius.circular(11.r),
                          elevation: 15,
                          color: const Color(0xffF6F6F6),
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.only(left: 10.w, right: 10.w),
                            child: InkWell(
                              onTap: () async {
                                var pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2025));
                                if (pickedDate != null) {
                                  setState(() {
                                    taskDate = (pickedDate);
                                    date = (DateFormat('yyyy-MM-dd')
                                        .format(pickedDate));
                                  });
                                }
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    (date == "") ? "Date".tr : date,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp),
                                  ),
                                  const Icon(Icons.calendar_month_outlined)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(height: 12.h),

                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          elevation: 15,
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              width: MediaQuery.of(context).size.width - 20,
                              height: 160.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(11.r),
                                color: Colors.grey.withOpacity(0.1),
                              ),
                              child: TextFormField(
                                  controller: detailsController,
                                  maxLines: 5,
                                  onSaved: (newValue) => details = newValue!,
                                  onChanged: (value) => details = value,
                                  decoration: InputDecoration(
                                    labelText: "Details".tr,
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp),
                                    border: InputBorder.none,
                                  ))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 70.h),
              GestureDetector(
                onTap: () {
                  {
                    formkey.currentState?.save();
                    if ((selectedMerchandiser != "") &&
                        (newMarket != "") &&
                        (newBranch != "") &&
                        (taskDate != "") &&
                        (details != "") &&
                        (selectedPlace != "All Places")) {
                      Get.to(() => RtvTaskDetails(
                            title: widget.taskTitle,
                            comeFrom: widget.comeFrom,
                            marketImage: widget.selectedMarketImage,
                            profileImage: widget.profileImage,
                            market: widget.selectedMarket,
                            branch: widget.selectedBranch,
                            userName: widget.userName,
                            id: widget.id,
                            phone: widget.phone,
                            detail: details,
                            selectedMarket: newMarket,
                            product: selectedPlace,
                            taskDate: taskDate,
                            selectedBranch: newBranch,
                            merchandiser: selectedMerchandiser,
                          ));
                    } else {
                      Fluttertoast.showToast(
                          msg: "Enter Full Details".tr,
                          backgroundColor: Colors.grey,
                          toastLength: Toast.LENGTH_LONG,
                          fontSize: 20,
                          gravity: ToastGravity.CENTER);
                    }
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 10.h, right: 10.h),
                  child: DefualtButton(
                    selected: true,
                    text: "Add Task".tr,
                    //onTap: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
