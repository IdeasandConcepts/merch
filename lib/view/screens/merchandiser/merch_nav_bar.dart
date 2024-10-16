import 'package:arrow_merchandising/const.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/main%20data/daily_task_screen.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/home/tasks%20list/tasks_list.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/profile/ProfileBody.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/profile/branch_appbar.dart';
import 'package:arrow_merchandising/models/availability_products.dart';
import 'package:arrow_merchandising/models/inventory_products.dart';
import 'package:arrow_merchandising/models/pricing_product.dart';
import 'package:arrow_merchandising/models/rtv_product.dart';
import 'package:arrow_merchandising/models/share_products.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'home/main data/home_details.dart';
import 'home/task history/tasks_history.dart';


class MerchNavBar extends StatefulWidget {
  final String username,
      manegerName,
      marketImage,
      profileImage,
      branch,
      //manegerName,
      market,
      //marketDetails,
      nationality;

  final int id, phone, mangerphone, tab_index;
  const MerchNavBar(
      {super.key,
      required this.username,
      required this.marketImage,
      required this.profileImage,
      required this.branch,
      required this.market,
      required this.id,
      required this.phone,
      required this.manegerName,
      required this.nationality,
      required this.tab_index,
      required this.mangerphone});
  // const MerchNavBar({
  //   super.key,
  // });

  @override
  State<MerchNavBar> createState() => _MerchNavBarState();
}

class _MerchNavBarState extends State<MerchNavBar>
    with SingleTickerProviderStateMixin {
  void initState() {
    // notYetList=widget.restedTasks+widget.completeTasks;
    // createDailyTask();

    // TODO: implement initState
    setState(() {
      //notYetList=widget.restedTasks;
      getnotYet("New Rtv Tasks", rtvNotYetList);
      getnotYet("New Inventory Tasks", inventoryNotYetList);
      getnotYet("New Availability Tasks", availabilityNotYetList);
      getListNotYet("New Share Of Shelves", shareNotYetList);
      getListNotYet("New Pricing Tasks", pricingNotYetList);
      notYetList = rtvNotYetList.length +
          inventoryNotYetList.length +
          availabilityNotYetList.length +
          shareNotYetList.length +
          pricingNotYetList.length;
      newTasks = notYetList;
      setState(() {
        doneTasks = completeInventoryTasks.length +
            completeAvailabilityTasks.length +
            completeOffersTasks.length +
            completeRtvTasks.length;
        restTasks = newTasks - doneTasks;
      });
      setState(() {
        print(completeInventoryTasks.length +
            completeAvailabilityTasks.length +
            completeOffersTasks.length +
            completeRtvTasks.length);
      });
      // pageController = PageController(initialPage: tabIndex);
    });
    super.initState();
    setState(() {
      selectedPos = widget.tab_index;
      _tabIndex = widget.tab_index;
      tabIndex = widget.tab_index;
      _navigationController =
          new CircularBottomNavigationController(selectedPos);
      pageController = PageController(initialPage: tabIndex);
    });
  }

  int notYetList = 0;

  int newTasks = 0, doneTasks = 0, restTasks = 0;

  Future refreshFun() async {
    getnotYet("New Rtv Tasks", rtvNotYetList);
    getnotYet("New Inventory Tasks", inventoryNotYetList);
    getnotYet("New Availability Tasks", availabilityNotYetList);
    getListNotYet("New Share Of Shelves", shareNotYetList);
    getListNotYet("New Pricing Tasks", pricingNotYetList);
    newTasks = notYetList;
    setState(() {
      doneTasks = completeInventoryTasks.length;
      completeShareTasks.length +
          completeRtvTasks.length +
          completeOffersTasks.length +
          completeAvailabilityTasks.length;
      restTasks = newTasks - doneTasks;
    });
  }

  List<String> pricingNotYetList = [],
      rtvNotYetList = [],
      shareNotYetList = [],
      inventoryNotYetList = [],
      availabilityNotYetList = [];
  Future getListNotYet(String collection, List<String> array) async {
    await FirebaseFirestore.instance
        .collection(collection)
        .where("merchandiser", whereIn: [widget.username, "Any Merchandiser"])
        // .where("merchandiser",isEqualTo: widget.username,)
        //.where("status", isEqualTo: taskCase)
        .where('status', isEqualTo: "not yet")
        .get()
        .then((snapshot) {
          snapshot.docs.forEach((element) {
            FirebaseFirestore.instance
                .collection(collection)
                .doc(element.reference.id)
                .get()
                .then((value) {
              Map<String, dynamic> data = value.data() as Map<String, dynamic>;
              // array=[];
              if (!(array.contains(data['branch']))) {
                array.add(data['branch']);
                print(array.length);
                setState(() {
                  if (array.length > 0)
                    notYetList = notYetList + (array.length);
                });
              }
              //.length= pricingNotYetList.length+1;
              // notYetList.add(data['name']);
            });
          });
        });
  }

//int notYetList =0;
  Future getnotYet(String collection, List<String> array) async {
    await FirebaseFirestore.instance
        .collection(collection)
        .where("merchandiserList",
            arrayContainsAny: [widget.username, "Any Merchandiser"])
        .where('status', isEqualTo: "not yet")
        .get()
        .then((snapshot) {
          snapshot.docs.forEach((element) {
            FirebaseFirestore.instance
                .collection(collection)
                .doc(element.reference.id)
                .get()
                .then((value) {
              Map<String, dynamic> data = value.data() as Map<String, dynamic>;
              //array=[];
              if (!(array.contains(data['branch']))) {
                array.add(data['branch']);
                print(array.length);
                setState(() {
                  if (array.length > 0)
                    notYetList = notYetList + (array.length);
                });
              }
            });
            // print(array.length);
          });
        });
  }

  int _tabIndex = 0;
  //
  int get tabIndex => _tabIndex;

  set tabIndex(int v) {
    setState(() {
      _tabIndex = v;
    });
  }
  late PageController pageController;

  int selectedPos = 0;
  double bottomNavBarHeight = 50;

  List<TabItem> tabItems = List.of([
    TabItem(
      Icons.home,
      "Home".tr,
      Colors.white,
      circleStrokeColor: kprimaryColor,
      labelStyle: TextStyle(
          color: Colors.white, fontSize: 8.sp, fontWeight: FontWeight.bold),
    ),
    TabItem(
      Icons.alarm,
      "New Tasks".tr,
      Colors.white,
      circleStrokeColor: kprimaryColor,
      labelStyle: TextStyle(
          color: Colors.white, fontSize: 8.sp, fontWeight: FontWeight.bold),
    ),
    TabItem(
      Icons.history,
      "Daily Tasks".tr,
      Colors.white,
      circleStrokeColor: kprimaryColor,
      labelStyle: TextStyle(
          color: Colors.white, fontSize: 8.sp, fontWeight: FontWeight.bold),
    ),
    TabItem(
      Icons.edit_calendar,
      "History".tr,
      Colors.white,
      circleStrokeColor: kprimaryColor,
      labelStyle: TextStyle(
          color: Colors.white, fontSize: 8.sp, fontWeight: FontWeight.bold),
    ),
    TabItem(
      Icons.person,
      "Profile".tr,
      Colors.white,
      circleStrokeColor: kprimaryColor,
      labelStyle: TextStyle(
          color: Colors.white, fontSize: 8.sp, fontWeight: FontWeight.bold),
    ),

    // Column()
  ]);

  // List<TabItem> normalItems = List.of([
  //
  //
  //             Column(
  //           children: [
  //             TabItem(
  //               Icons.person,
  //               "".tr,
  //               Colors.white,
  //               circleStrokeColor: kprimaryColor,
  //               labelStyle: TextStyle(
  //                   color: Colors.white, fontSize: 8.sp, fontWeight: FontWeight.bold),
  //             ),
  //             Text("Home".tr,style: TextStyle(color:  Colors.white,fontSize: 8.0),),
  //           ],
  //         ),
  //
  //         Column(
  //           children: [
  //             Icon( Icons.food_bank_outlined, color: Colors.white,),
  //             Text("New Tasks".tr,style: TextStyle(color: Colors.white,fontSize: 8.0),),
  //           ],
  //         ),
  //         Column(
  //           children: [
  //             Icon(Icons.history, color:  Colors.white,),
  //             Text("Daily Tasks".tr,style: TextStyle(color:  Colors.white,fontSize: 8.0),),
  //           ],
  //         ),
  //         Column(
  //           children: [
  //             Icon(Icons.comment, color:  Colors.white,),
  //             Text("History".tr,style: TextStyle(color:  Colors.white,fontSize: 8.0),),
  //           ],
  //         ),
  //         // Icon(Icons.comment, color:  Colors.white),
  //         Column(
  //           children: [
  //             Icon(Icons.person, color:  Colors.white,),
  //             Text( "Profile".tr,style: TextStyle(color:  Colors.white,fontSize: 8.0),),
  //           ],
  //         ),
  //
  //
  //
  //   // Column()
  // ]);
  late CircularBottomNavigationController _navigationController;

  @override
  Widget build(BuildContext context) {
    // return GetBuilder<NavigationBarContt>(
    //     builder: (context){

    double width=MediaQuery.of(context).size.width;
    double hieght=MediaQuery.of(context).size.height;



    return Scaffold(
      // extendBody: true,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kprimaryColor,
          title: MerchAppBar(
            // appBar: MerchAppBar(
            title: (_tabIndex == 0)
                ? "Home"
                : (_tabIndex == 1)
                    ? "New Tasks"
                    : (_tabIndex == 2)
                        ? "Daily Tasks"
                        : (_tabIndex == 3)
                            ? "History"
                            : "Profile",
            manegerName: widget.manegerName,
            phone: widget.phone,
            market: widget.market,
            marketImage: widget.marketImage,
            branch: widget.branch,
            username: widget.username,
            profileImage: widget.profileImage,
          )),
      body: bodyContainer(tabIndex),
      bottomNavigationBar: CircularBottomNavigation(
        barHeight:bottomNavBarHeight,
        barBackgroundColor: kprimaryColor,
        selectedIconColor: Colors.black,
        normalIconColor: Colors.white,
        allowSelectedIconCallback: true,
        circleStrokeWidth: 0.9,
        //selectedPos: widget.tab_index,
        //circleSize: 50,
        //(tabIndex==selectedPos)?
        tabItems,
        //normalItems.cast<TabItem>() ,
        controller: _navigationController,
         selectedCallback: (position) {
          setState(() {
            tabIndex = position!;
            selectedPos=position;
            pageController.jumpToPage(tabIndex);
            //
          });
        },
      ),
    );
  }

  Widget bodyContainer(int index) {
    return (index == 0)
        ? HomeDetails(
            manegerName: widget.manegerName,
            merchPhone: widget.phone,
            id: widget.id,
            nationality: widget.nationality,
            branch: widget.branch,
            rtvNotYetList: rtvNotYetList,
            inventoryNotYetList: inventoryNotYetList,
            availabilityNotYetList: availabilityNotYetList,
            shareNotYetList: shareNotYetList,
            pricingNotYetList: pricingNotYetList,
            completeTasks: doneTasks,
            restedTasks: notYetList - doneTasks,
            notYetList: notYetList,
            userName: widget.username,
            // todaysTasks: notYetList,
            market: widget.market,
            userImage: widget.profileImage,
            mangerPhone: widget.mangerphone,
            marketImage: widget.marketImage,
          )
        : (index == 1)
            ? NewTaskList(
                conditionList: [widget.username, "Any Merchandiser"],
                managerPhone: widget.mangerphone,
                // myCollection: [],
                nationality: widget.nationality,
                manegerName: widget.manegerName,
                id: widget.id,
                phone: widget.phone,
                marketImage: widget.marketImage,
                profileImage: widget.profileImage,
                username: widget.username,
                branch: widget.branch,
                market: widget.market,
                //city: widget.city,
              )
            : (index == 2)
                ? AndroidDailyTasksScreen(
                    manegerName: widget.manegerName,
                    adminPhone: widget.mangerphone,
                    nationality: widget.nationality,
                    //marketDetails: widget.marketDetails,
                    id: widget.id,
                    phone: widget.phone,
                    marketImage: widget.marketImage,
                    profileImage: widget.profileImage,
                    username: widget.username,
                    branch: widget.branch,
                    market: widget.market,
                  )
                : (index == 3)
                    ?
                    // History :
                    MyTasksHistory(
                        managerPhone: widget.mangerphone,
                        nationality: widget.nationality,
                        manegerName: widget.manegerName,
                        id: widget.id,
                        phone: widget.phone,
                        marketImage: widget.marketImage,
                        profileImage: widget.profileImage,
                        username: widget.username,
                        branch: widget.branch,
                        market: widget.market,
                      )
                    : ProfileBody(
                        mangerPhone: widget.mangerphone,
                        nationality: widget.nationality,
                        //marketDetails: widget.marketDetails,
                        id: widget.id,
                        phone: widget.phone,
                        marketImage: widget.marketImage,
                        profileImage: widget.profileImage,
                        username: widget.username,
                        branch: widget.branch,
                        market: widget.market,
                      );

  }
}
