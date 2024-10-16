import 'package:arrow_merchandising/view/screens/super_visor/home/supervisor_markets.dart';
import 'package:arrow_merchandising/view/screens/super_visor/super_app_bar.dart';
import 'package:arrow_merchandising/controller/localization_and_theme/changelocal_and_theme_controller.dart';
import 'package:arrow_merchandising/models/supermarketsModel.dart';
import 'package:arrow_merchandising/view/screens/add_task/add_task.dart';
import 'package:arrow_merchandising/controller/services/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:arrow_merchandising/const.dart';
import 'package:intl/intl.dart';

class AndroidSuperVisorScreen extends StatefulWidget {
  final int id, phone;
  final String profileImage, role, nationality;
  final String name;
  const AndroidSuperVisorScreen(
      {Key? key,
      required this.role,
      required this.id,
      required this.phone,
      required this.profileImage,
      required this.nationality,
      required this.name})
      : super(key: key);

  @override
  State<AndroidSuperVisorScreen> createState() =>
      _AndroidSuperVisorScreenState();
}

class _AndroidSuperVisorScreenState extends State<AndroidSuperVisorScreen> {
  ScrollController _scrollController = ScrollController();

  TextEditingController searchController = TextEditingController();
  String searchResult = "";
  List<String> marketsList = [], customerImage = [], images = [];
  List<String> markets = [];
  String selectedMarketImage = "";
  Future getMarketImage(String market) async {
    await FirebaseFirestore.instance
        .collection('Super_markets')
        .where('customer_name', isEqualTo: market)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection('Super_markets')
            .doc(element.reference.id)
            .get()
            .then((value) {
          Map<String, dynamic> data = value.data() as Map<String, dynamic>;
          {
            selectedMarketImage = data["market_image"];
            //}
          }
        });
      });
    });
    print("All Markets Added");
    print(marketsList.length);
  }

  Future getMarkets() async {
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
          Map<String, dynamic> data = value.data() as Map<String, dynamic>;
          {
            if (!marketsList.contains(data['market_name'].toUpperCase())) {
              customerImage.add(data["market_image"]);
              marketsList.add(data['market_name'].toUpperCase());
              print(data['market_name']);
              selectedMarketImage = data["market_image"];
            }
          }
        });
      });
    });
    print("All Markets Added");
    print(marketsList.length);
  }

  List<String> category = [
    "Saturday",
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday"
  ];
  DateTime dt1 = DateTime.now();
  String dateFormat = "";

  LocaleAndThemeController controller = Get.put(LocaleAndThemeController());
  MyServices myServices = Get.find();
  String? sharedlang;
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    sharedlang = myServices.sharedPreferences.getString("lang");
    dateFormat = DateFormat('EEEE').format(dt1);
    print(dateFormat);
    getMarkets();
    setState(() {
      getMarkets();
    });
  }

  bool closeBranch = false;
  List<int> categoriesDay = [0, 1, 2, 3, 4, 5, 6];
  int FullIndex = 0;
  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < category.length; i++)
      if (category[i] == dateFormat) {
        FullIndex = i;
      }
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kprimaryColor,
          title: SuperAppBar(
            comeFrom: "All Markets",
            title: "Home",
            phone: widget.phone,
            market: "All Markets",
            marketImage: "",
            branch: "All Branches",
            username: widget.name,
            profileImage: widget.profileImage,
          )),
      floatingActionButton: IconButton(
          onPressed: () {
            Get.defaultDialog(
              title: "Select Your Task".tr,
              content: Container(
                height: MediaQuery.of(context).size.height - 500,
                child: Wrap(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.broken_image),
                      title: Text("RTV Section".tr),
                      onTap: () {
                        Navigator.of(context).pop();
                        Get.to(() => AddTaskScreen(
                              taskTitle: "RTV Section",
                              comeFrom: "Full Tasks",
                              selectedMarketImage: "",
                              id: widget.id,
                              phone: widget.phone,
                              selectedMarket: "All Markets",
                              userName: widget.name,
                              profileImage: widget.profileImage,
                              selectedBranch: "All Branches",
                              selectedMerch: "",
                            ));
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.inventory),
                      title: Text("Inventory".tr),
                      onTap: () {
                        Navigator.of(context).pop();
                        Get.to(() => AddTaskScreen(
                              taskTitle: "Inventory",
                              comeFrom: "Full Tasks",
                              selectedMarketImage: "",
                              id: widget.id,
                              phone: widget.phone,
                              selectedMarket: "All Markets",
                              userName: widget.name,
                              profileImage: widget.profileImage,
                              selectedBranch: "All Branches",
                              selectedMerch: "",
                            ));
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.event_available),
                      title: Text("Availability".tr),
                      onTap: () {
                        Navigator.of(context).pop();
                        Get.to(() => AddTaskScreen(
                              taskTitle: "Availability",
                              comeFrom: "Full Tasks",
                              selectedMarketImage: "",
                              id: widget.id,
                              phone: widget.phone,
                              selectedMarket: "All Markets",
                              userName: widget.name,
                              profileImage: widget.profileImage,
                              selectedBranch: "All Branches",
                              selectedMerch: "",
                            ));
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.currency_exchange),
                      title: Text("Offers".tr),
                      onTap: () {
                        Navigator.of(context).pop();
                        Get.to(() => AddTaskScreen(
                              taskTitle: "Offers",
                              comeFrom: "Full Tasks",
                              selectedMarketImage: "",
                              id: widget.id,
                              phone: widget.phone,
                              selectedMarket: "All Markets",
                              userName: widget.name,
                              profileImage: widget.profileImage,
                              selectedBranch: "All Branches",
                              selectedMerch: "",
                            ));
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.dehaze),
                      title: Text("Planogram".tr),
                      onTap: () {
                        Navigator.of(context).pop();
                        Get.to(() => AddTaskScreen(
                              taskTitle: "Planogram",
                              comeFrom: "All Markets",
                              selectedMarketImage: "",
                              id: widget.id,
                              phone: widget.phone,
                              selectedMarket: "All Markets",
                              userName: widget.name,
                              profileImage: widget.profileImage,
                              selectedBranch: "All Branches",
                              selectedMerch: "",
                            ));
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.shelves),
                      title: Text("Share of Shelves".tr),
                      onTap: () {
                        Navigator.of(context).pop();
                        Get.to(() => AddTaskScreen(
                              taskTitle: "Share of Shelves",
                              comeFrom: "Full Tasks",
                              selectedMarketImage: "",
                              id: widget.id,
                              phone: widget.phone,
                              selectedMarket: "All Markets",
                              userName: widget.name,
                              profileImage: widget.profileImage,
                              selectedBranch: "All Branches",
                              selectedMerch: "",
                            ));
                      },
                    ),
                  ],
                ),
                // ),
              ),
            );
          },
          icon: Icon(
            color: kprimaryColor,
            Icons.add_circle,
            size: 60,
          )),
      body: ListView(
        shrinkWrap: true,
        controller: _scrollController,
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12.h, right: 12.h),
                  child: Text(
                    "Schedule".tr,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                //customSwith(status, switchVal, OnChangFun),

                Padding(
                  padding: EdgeInsets.only(left: 6.h, right: 6.h, top: 10.h),
                  child: Row(
                      children: List.generate(
                    category.length,
                    (index) => Container(
                      height: 34.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: (dateFormat == category[index])
                            ? kprimaryColor
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          (sharedlang == "ar")
                              ? category[index].tr
                              : category[index].substring(0, 3).tr,
                          style: TextStyle(
                              fontSize: 12,
                              color: (dateFormat == category[index])
                                  ? Colors.white
                                  : (categoriesDay[index] < FullIndex)
                                      ? Colors.red
                                      : Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )),
                )
              ]),
          SizedBox(height: 16.h),

          ///   Search Bar
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              child: Container(
                width: 300.w,
                height: 55.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: const Color(0xffEAE9E9),
                    borderRadius: BorderRadius.all(Radius.circular(10.r))),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: "Search".tr + "\t...\t",
                    hintStyle:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp),
                    prefixIcon: const Icon(Icons.search_sharp),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      getMarkets();
                      searchResult = value;
                      runFilter(value);
                      // searchResult=value;
                    });
                  },
                  onSubmitted: (newValue) {
                    setState(() {
                      getMarkets();
                      searchResult = newValue;
                      runFilter(newValue);
                      // searchResult=newValue;
                    });
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 5.h),

          (searchResult == "")
              ? Container(
                  height: MediaQuery.of(context).size.height - 150.h,
                  padding: EdgeInsets.only(bottom: 80),
                  child: StreamBuilder<List<SuperMarket>>(
                      stream: readSuperMarkets(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text(' Error ya Ahmed :: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final markets = snapshot.data!;
                          return GridView.count(
                              crossAxisCount: 2,
                              children:
                                  markets.map(buildSuperMarkets).toList());
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                )
              : Container(
                  height: 800,
                  child: ListView.builder(
                      key: ValueKey(marketsList[0].toString()),
                      itemCount: marketsList.length,
                      itemBuilder: (context, index) {
                        if ((marketsList[index]
                                .contains(searchResult.toUpperCase())) ||
                            (marketsList[index]
                                .startsWith(searchResult.toUpperCase()))) {
                          return ListTile(
                              leading: Container(
                                padding: EdgeInsets.only(
                                  left: 5,
                                  right: 12,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Image.network(
                                  selectedMarketImage,
                                ),
                              ),
                              title: Text(marketsList[index]),
                              subtitle: Text('${index}'),
                              onTap: () {
                                getMarketImage(marketsList[index]);
                                Get.to(() => AndroidMarketBranches(
                                      role: widget.role,
                                      nationality: widget.nationality,
                                      market: marketsList[index],
                                      name: widget.name,
                                      city: "Riyadh",
                                      marketImage: selectedMarketImage,
                                      profileImage: widget.profileImage,
                                      id: widget.id,
                                      phone: widget.phone,
                                    ));
                              });
                        }
                        return null;
                      }),
                ),
        ],
      ),
    );
  }

  Widget buildSuperMarkets(SuperMarket market) => GestureDetector(
        onTap: () {
          Get.to(() => AndroidMarketBranches(
                role: widget.role,
                market: market.customerName,
                name: widget.name,
                marketImage: market.photo,
                profileImage: widget.profileImage,
                city: "Riyadh",
                id: widget.id,
                phone: widget.phone,
                nationality: widget.nationality,
              ));
        },
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: SizedBox(
            height: 140,
            width: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  Container(
                    height: 150,
                    padding: EdgeInsets.only(
                        right: 10, left: 10, top: 20, bottom: 20),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Image.network(
                        market.photo,
                      ),
                    ),
                  ),
                  Container(
                    //width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          colors: [
                            Color(0xFF343434).withOpacity(0.4),
                            Color(0xFF3434343).withOpacity(0.15)
                          ]),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 80,
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 15,
                            right: 12,
                            top: 62.0,
                          ),
                          child: Text(market.customerName,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  void runFilter(String branch) {
    if (branch.isEmpty) {
      searchResult = "";
      markets = marketsList;
    } else {
      markets = marketsList
          .where(
              (market) => market.toUpperCase().contains(branch.toUpperCase()))
          .toList();
      images = customerImage
          .where((image) => image.toUpperCase().contains(branch.toUpperCase()))
          .toList();
    }
    setState(() {
      markets = marketsList;
      customerImage = images;
      selectedMarketImage = images[0];
    });
    if (marketsList.length == 0) {
      markets.add("");
    }
  }

  //}
  Stream<List<SuperMarket>> readSuperMarkets() => FirebaseFirestore.instance
      .collection('Super_markets')
      .orderBy('market_name')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => SuperMarket.fromJson(doc.data()))
          .toList());
}
