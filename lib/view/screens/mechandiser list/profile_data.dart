


import 'package:arrow_merchandising/view/screens/add_task/add_task.dart';
import 'package:arrow_merchandising/view/screens/mechandiser%20list/expired_tasks.dart';
import 'package:arrow_merchandising/view/screens/mechandiser%20list/merch_data.dart';
import 'package:arrow_merchandising/view/screens/mechandiser%20list/new_tasks.dart';
import 'package:arrow_merchandising/view/screens/mechandiser%20list/run_tasks.dart';
import 'package:arrow_merchandising/view/screens/super_visor/super_app_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:arrow_merchandising/const.dart';
import 'done_tasks.dart';

class AndroidProfileData extends StatefulWidget {

//  final Merchandiser merchandiser;
  final String merchName,
      merchNationality,
      merchcarDetails,merchProfileImage;
  final int merchPhone,merchNatId;
  // final Merchandiser merchandiser;

  final int id, phone;

  final String  profileImage,city,marketImage, branch, nationality;
  final String market, role,name;
  //final List<String> mycollection;
  const AndroidProfileData(
      {super.key,
      required this.merchName,
      required this.merchNationality,
      required this.merchcarDetails,
      required this.merchProfileImage,
      required this.merchPhone,
      required this.merchNatId,
      required this.city,
      required this.market,
      required this.name,
      required this.role,
        required this.marketImage,
      required this.profileImage,
      required this.branch,
      required this.id,
      required this.phone,
     // required this.marketDetails,
      required this.nationality,
     // required this.merchandiser
      });

  @override
  State<AndroidProfileData> createState() => _AndroidProfileDataState();
}

class _AndroidProfileDataState extends State<AndroidProfileData> with TickerProviderStateMixin {

 // TabController _tabController =
  //TabController controller = TabController(length: 2, vsync: this);

  List<String>category=["Details","Done","Run","New","Expired",];
  List<int>categoriesDay=[0,1,2,3,4,];
  int FullIndex=0;
  // TextEditingController fullNameCon = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {

    TabController controller = TabController(length: 5, vsync: this);



    // @override
    // Widget build(BuildContext context) {
      for(int i=0;i<category.length;i++)
        if(category[i]==categoriesDay)
        {
          FullIndex=i;
        }

      return Scaffold(
//backgroundColor: Colors.grey,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: kprimaryColor,
            title: SuperAppBar(
              // appBar: MerchAppBar(
              title: widget.merchName,
              comeFrom: "Merchandisers",
              phone: widget.phone,
              market: "All Markets",
              marketImage: "",
              branch:"All Branches",
              username: widget.name,
              profileImage: widget.profileImage,
            )),
        floatingActionButton: IconButton(
            onPressed: () {
              Get.defaultDialog(
                title: "Select Your Task".tr,
                content: Container(
                  height: MediaQuery.of(context).size.height-500,
                  child: Wrap(
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.broken_image),
                        title: Text("RTV Section".tr),
                        onTap: () {
                          Navigator.of(context).pop();
                          Get.to(() => AddTaskScreen(
                            taskTitle: "RTV Section",
                            comeFrom: "Merchandisers",
                            selectedMarketImage:widget.marketImage,
                            id:widget. id,
                            phone:widget. phone,
                            selectedMarket:widget.market,
                            userName:widget. name,
                            profileImage:widget. profileImage,
                            selectedBranch:widget.branch,
                            selectedMerch: widget.merchName,
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
                            comeFrom: "Merchandisers",
                            selectedMarketImage:widget.marketImage,
                            id:widget. id,
                            phone:widget. phone,
                            selectedMarket:widget.market,
                            userName:widget. name,
                            profileImage:widget. profileImage,
                            selectedBranch:widget.branch,
                            selectedMerch: widget.merchName,
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
                            comeFrom: "Merchandisers",
                            selectedMarketImage:widget.marketImage,
                            id:widget. id,
                            phone:widget. phone,
                            selectedMarket:widget.market,
                            userName:widget. name,
                            profileImage:widget. profileImage,
                            selectedBranch:widget.branch,
                            selectedMerch: widget.merchName,
                          ));

                        },
                      ),

                      ListTile(
                        leading: const Icon(Icons.currency_exchange),
                        title: Text("Pricing".tr),
                        onTap: () {
                          Navigator.of(context).pop();
                          Get.to(() => AddTaskScreen(
                            taskTitle: "Pricing",
                            comeFrom: "Merchandisers",
                            selectedMarketImage:widget.marketImage,
                            id:widget. id,
                            phone:widget. phone,
                            selectedMarket:widget.market,
                            userName:widget. name,
                            profileImage:widget. profileImage,
                            selectedBranch:widget.branch,
                            selectedMerch: widget.merchName,
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
                            comeFrom: "Merchandisers",
                            selectedMarketImage:widget.marketImage,
                            id:widget. id,
                            phone:widget. phone,
                            selectedMarket:widget.market,
                            userName:widget. name,
                            profileImage:widget. profileImage,
                            selectedBranch:widget.branch,
                            selectedMerch: widget.merchName,
                          ));
                        },
                      ),     ListTile(
                        leading: const Icon(Icons.shelves),
                        title: Text("Planogram".tr),
                        onTap: () {
                          Navigator.of(context).pop();
                          Get.to(() => AddTaskScreen(
                            taskTitle: "Planogram",
                            comeFrom: "Merchandisers",
                            selectedMarketImage:widget.marketImage,
                            id:widget. id,
                            phone:widget. phone,
                            selectedMarket:widget.market,
                            userName:widget. name,
                            profileImage:widget. profileImage,
                            selectedBranch:widget.branch,
                            selectedMerch: widget.merchName,
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
              color: kprimaryColor,Icons.add_circle,size: 60,)),

    body: Container(
      height: MediaQuery.of(context).size.height-20,
      child: Column(
        children: [
          //   Padding(
          //     padding: const EdgeInsets.only(top:10.0,bottom: 10.0),
          //     child: Container(
          //       height: 180,
          //       width: 160,
          //       child: Image.network(widget.merchProfileImage),
          //     ),
          //   ),
          // Divider(
          //   height: 0.1,
          //   color: Colors.black45,
          // ),
          //
          Padding(
            padding:  EdgeInsets.only(left:6.h,right: 6.h,top: 10.h),
            child:    TabBar(
              controller: controller,
              padding: EdgeInsets.all(1.h),
              //  indicator: category[index],
              // indicatorColor: Colors.transparent,
              // labelColor: Colors.black,
              // unselectedLabelColor: Colors.grey.withOpacity(0.6),
              isScrollable: true,
              tabAlignment: TabAlignment.start,
                tabs:
                List.generate(category.length,

                      (index) =>
                      Container(
                        height: 34.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: (categoriesDay[0]==category[index])?kprimaryColor:null,
                        ),
                        child: Center(
                          child: Text(
                           // (sharedlang=="ar")?
                            category[index].tr,
                                //:category[index].substring(0,3).tr,
                            style: TextStyle(
                                fontSize: 12,
                                color:
                                (categoriesDay[index]==category[index])?
                                Colors.white:
                                (categoriesDay[index]<FullIndex)?
                                Colors.red
                                    :Colors.black.withOpacity(0.6),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                )
            ),
          ),
            // Container(
            //   decoration: const BoxDecoration(
            //       //color: kprimaryColor
            //   ),
            //   child: TabBar(controller: controller, tabs: [
            //     // Tab(text: "Branches".tr),
            //     //  Tab(text: "Merchandisers".tr),
            //     Tab(text: "Details".tr),
            //     Tab(text: "Run".tr),
            //     Tab(text: "Done".tr),
            //     Tab(text: "New".tr),
            //     Tab(text: "Expired".tr),
            //   ]),
            // ),
            Container(
             // padding: EdgeInsets.only(bottom: 20),
              height: MediaQuery.of(context).size.height-120,
              child: TabBarView(
                controller: controller,
              children: [
                AndroidMerchData(
                 merchName:   widget.merchName,
                 merchNationality:  widget.merchNationality,
                 carDetails:  widget.merchcarDetails,
                 merchProfileImage:  widget.merchProfileImage ,
                 merchPhone:  widget.merchPhone,
                 merchNatId:  widget.merchNatId,
                  market: widget.market,
                  // merchandiser: widget.merchandiser
               ),
                AndroidMerchTasks(
                    merchandiser:widget.merchName,
                    marketImage:widget.marketImage,
                    role:widget.role,
                    city: widget.city,
                   // merchandiser: merchandiser,
                    branch: "All Branches",
                    nationality: widget.nationality,
                    //marketDetails: widget.marketDetails,
                    id: widget.id,
                    phone: widget.phone,
                    market: widget.market,
                    username: widget.name,
                    // marketImage: widget.marketImage,
                    profileImage: widget.profileImage
                ),
                AndroidMerchRunningTasks(merchandiser: widget.merchName,),
                AndroidMerchNewTasks(merchandiser: widget.merchName,),
                AndroidMerchExpiredTasks(
                  merchandiser:widget.merchName,
                ),
                    ],
                  ),
                  // Image.asset(imageassets),
                ),

              ],

            ),
    )
  //],
//),

   //   ],
    //),
    );

  }



}

