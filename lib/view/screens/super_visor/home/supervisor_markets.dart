import 'package:arrow_merchandising/view/screens/add_task/add_task.dart';
import 'package:arrow_merchandising/view/screens/branches_tasks/sellected_branch_tasks.dart';
import 'package:arrow_merchandising/view/screens/super_visor/super_app_bar.dart';
import 'package:arrow_merchandising/models/branch_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arrow_merchandising/const.dart';

class AndroidMarketBranches extends StatefulWidget {
  final id, phone;
  final String marketImage, profileImage, nationality;
  final String market, city, role, name;

  const AndroidMarketBranches({
    super.key,
    required this.id,
    required this.phone,
    required this.role,
    required this.marketImage,
    required this.profileImage,
    required this.city,
    required this.nationality,
    required this.market,
    required this.name,
  });

  @override
  State<AndroidMarketBranches> createState() => _AndroidMarketBranchesState();
}

class _AndroidMarketBranchesState extends State<AndroidMarketBranches> {
  /// from fire base
  List<String> branchesList = [];

  /// for search
  List<String> branches = [];
  List<int> customerCodesList = [];
  List<int> customerCodes = [];

  Future getBranchesId() async {
    await FirebaseFirestore.instance
        .collection(widget.market)
        //.orderBy('branch_id')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection(widget.market)
            .doc(element.reference.id)
            .get()
            .then((value) {
          Map<String, dynamic> data = value.data() as Map<String, dynamic>;
          {
            if ((!branchesList.contains(data['branch_name'])) &&
                (!customerCodesList.contains(data['branch_id']))) {
              branchesList.add(data['branch_name']);
              customerCodesList.add(data['branch_id']);
            }
          }
        });
      });
    });
    if (branchesList.length > 0) print("All Data Added");
    print(branchesList.length);
  }

  TextEditingController searchController = TextEditingController();
  String searchResult = "";
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _scrollController = ScrollController();
      getBranchesId();
      branches = branchesList;
      print(widget.market);
      print(branches.length);
    });
    getBranchesId();
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
            title: SuperAppBar(
              title: widget.market,
              comeFrom: widget.market,
              phone: widget.phone,
              market: widget.market,
              marketImage: widget.marketImage,
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
                                comeFrom: widget.market,
                                selectedMarketImage: widget.marketImage,
                                id: widget.id,
                                phone: widget.phone,
                                selectedMarket: widget.market,
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
                                comeFrom: widget.market,
                                selectedMarketImage: widget.marketImage,
                                id: widget.id,
                                phone: widget.phone,
                                selectedMarket: widget.market,
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
                                comeFrom: widget.market,
                                selectedMarketImage: widget.marketImage,
                                id: widget.id,
                                phone: widget.phone,
                                selectedMarket: widget.market,
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
                                comeFrom: widget.market,
                                selectedMarketImage: widget.marketImage,
                                id: widget.id,
                                phone: widget.phone,
                                selectedMarket: widget.market,
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
                                selectedMarket: widget.market,
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
                                comeFrom: widget.market,
                                selectedMarketImage: widget.marketImage,
                                id: widget.id,
                                phone: widget.phone,
                                selectedMarket: widget.market,
                                userName: widget.name,
                                profileImage: widget.profileImage,
                                selectedBranch: "All Branches",
                                selectedMerch: "",
                              ));
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
            icon: Icon(
              color: kprimaryColor,
              Icons.add_circle,
              size: 60,
            )),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: ListView(
                  shrinkWrap: true,
                  controller: _scrollController,
                  children: [
                    (searchResult == "")
                        ? SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Container(
                              child: StreamBuilder<List<Branch>>(
                                  stream: readSuperMarkets(widget.market),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Text(
                                          ' Error ya Ahmed :: ${snapshot.error}');
                                    } else if (snapshot.hasData) {
                                      final markets = snapshot.data!;
                                      return ListView(
                                          shrinkWrap: true,
                                          controller: _scrollController,
                                          children: markets
                                              .map(build_branches)
                                              .toList());
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  }),
                            ),
                          )
                        : SizedBox(
                            height: 320,
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height - 100,
                                child: ListView.builder(
                                    key: ValueKey(branches[0].toString()),
                                    itemCount: branches.length,
                                    itemBuilder: (context, index) {
                                      {
                                        return Column(
                                          children: [
                                            ListTile(
                                                leading: Container(
                                                  padding: EdgeInsets.only(
                                                    left: 5,
                                                    right: 12,
                                                  ),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: Image.network(
                                                    widget.marketImage,
                                                  ),
                                                ),
                                                title: Text(branches[index]),
                                                subtitle: Text(
                                                    '${customerCodesList[index]}'),
                                                onTap: () {
                                                  Get.to(() =>
                                                      AndroidBranchTasksScreen(
                                                        branch:
                                                            branchesList[index],
                                                        role: widget.role,
                                                        nationality:
                                                            widget.nationality,
                                                        market: widget.market,
                                                        username: widget.name,
                                                        marketImage:
                                                            widget.marketImage,
                                                        profileImage:
                                                            widget.profileImage,
                                                        id: widget.id,
                                                        phone: widget.phone,
                                                      ));
                                                }),
                                            Divider(),
                                          ],
                                        );
                                      }
                                    })),
                          ),
                  ]),
            ),
          ),
        ));
  }

  void runFilter(String branch) {
    if (branch.isEmpty) {
      searchResult = "";
    } else {
      branches = branchesList
          .where((branchesList) =>
              branchesList.toLowerCase().contains(branch.toLowerCase()))
          .toList();
    }
  }

  Widget build_branches(Branch branch) {
    return Column(
      children: [
        ListTile(
            leading: Image.network(widget.marketImage, fit: BoxFit.contain),
            title: Text(branch.customerName),
            subtitle: Text("Customer Code".tr + '${branch.marketId}'),
            onTap: () {
              Get.to(() => AndroidBranchTasksScreen(
                    //codesLists: customerCodesList,
                    role: widget.role,
                    market: widget.market,
                    username: widget.name,
                    marketImage: widget.marketImage,
                    profileImage: widget.profileImage,
                    id: widget.id,
                    phone: widget.phone,
                    nationality: widget.nationality,
                    branch: branch.customerName,
                  ));
            }),
        Divider(),
      ],
      // ),
    );
  }

  Stream<List<Branch>> readSuperMarkets(String market) => FirebaseFirestore
      .instance
      .collection(market)
      .orderBy('branch_id')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Branch.fromJson(doc.data())).toList());
}
