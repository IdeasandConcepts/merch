

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:arrow_merchandising/const.dart';
import 'package:arrow_merchandising/view/widgets/custom_dropdown.dart';
import 'package:arrow_merchandising/models/new_task.dart';
import 'package:intl/intl.dart';


class AndroidMerchExpiredTasks extends StatefulWidget {
  final String merchandiser;
  const AndroidMerchExpiredTasks({Key? key, required this.merchandiser}) : super(key: key);

  @override
  State<AndroidMerchExpiredTasks> createState() => _AndroidMerchExpiredTasksState();
}

class _AndroidMerchExpiredTasksState extends State<AndroidMerchExpiredTasks> {

  ScrollController _scrollController = ScrollController();

  List<String> taskName = [
    "RTV",
    "Inventory",
    "Availability",
    "Share Of Shelves",
    "Visits",
    "Offers",
    "Planogram",
  ];

  String tName = "All Tasks";
  @override
  Widget build(BuildContext context) {
    return   SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 15.h),
            child: Column(children: [
              ///  Filter
              Container(
                  padding:  EdgeInsets.only(left:10.w,right: 10.w),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height-200,
                  child: ListView(
                      controller: _scrollController,
                      children: [
                        Container(
                            height: 60.h,
                            width: 378.w,
                            decoration: BoxDecoration(
                                border: Border.all(width: 1.w),
                                borderRadius: BorderRadius.circular(10.r)),
                            child: CustomDropdownButton(
                                onChanged: (value) {},
                                onTap: () {},
                                hintText: tName.tr,
                                items: List.generate(
                                  taskName.length,
                                      (index) => DropdownMenuItem(
                                      onTap: () {
                                        setState(() {
                                          tName = taskName[index];
                                        });
                                      },
                                      value: 1,
                                      child: Text("${taskName[index].tr}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp))),
                                )
                            )
                        ),
                        (tName=="RTV")?
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: StreamBuilder<List<NewAllTask>>(
                              stream: readAllTask("RTV", ),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text(
                                      ' Error ya Hantop :: ${snapshot.error}');
                                } else if (snapshot.hasData) {
                                  final task = snapshot.data!;
                                  return ListView(
                                    controller: _scrollController,
                                    shrinkWrap: true,
                                    children:
                                    //[Text("ghhg")]
                                    task.map(buildNewTasks).toList(),
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              }),
                        ):
                        (tName=="Availability")?
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Container(
                            decoration: BoxDecoration(
                              //color: kprimaryColor.withOpacity(0.1),
                                borderRadius:
                                BorderRadius.circular(25)),
                            child: StreamBuilder<List<NewAllTask>>(
                                stream: readAllTask("Availability", ),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text(
                                        ' Error ya Hantop :: ${snapshot.error}');
                                  } else if (snapshot.hasData) {
                                    final task = snapshot.data!;
                                    return ListView(
                                      controller: _scrollController,
                                      shrinkWrap: true,
                                      children:
                                      //[Text("ghhg")]
                                      task.map(buildNewTasks).toList(),
                                    );
                                  } else {
                                    return Center(
                                      child:
                                      CircularProgressIndicator(),
                                    );
                                  }
                                }),
                          ),
                        ):
                        (tName=="Inventory")?
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Container(
                            decoration: BoxDecoration(
                                color: kprimaryColor
                                    .withOpacity(0.1),
                                borderRadius:
                                BorderRadius.circular(25)),
                            child: StreamBuilder<List<NewAllTask>>(
                                stream: readAllTask("Inventory", ),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text(
                                        ' Error ya Hantop :: ${snapshot.error}');
                                  } else if (snapshot.hasData) {
                                    final task = snapshot.data!;
                                    return ListView(
                                      controller: _scrollController,
                                      shrinkWrap: true,
                                      children:
                                      //[Text("ghhg")]
                                      task.map(buildNewTasks).toList(),
                                    );
                                  } else {
                                    return Center(
                                      child:
                                      CircularProgressIndicator(),
                                    );
                                  }
                                }),
                          ),
                        ):
                        (tName=="Share Of Shelves")?
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: StreamBuilder<List<NewAllTask>>(
                              stream: readAllTask("Share of shelves",),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text(
                                      ' Error ya Hantop :: ${snapshot.error}');
                                } else if (snapshot.hasData) {
                                  final task = snapshot.data!;
                                  return ListView(
                                    controller: _scrollController,
                                    shrinkWrap: true,
                                    children:
                                    //[Text("ghhg")]
                                    task.map(buildNewTasks).toList(),
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              }),
                        ):
                        (tName=="Planogram")?
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: StreamBuilder<List<NewAllTask>>(
                              stream: readAllTask("Planogram",),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text(
                                      ' Error ya Hantop :: ${snapshot.error}');
                                } else if (snapshot.hasData) {
                                  final task = snapshot.data!;
                                  return ListView(
                                    controller: _scrollController,
                                    shrinkWrap: true,
                                    children:
                                    //[Text("ghhg")]
                                    task.map(buildNewTasks).toList(),
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              }),
                        ):
                        (tName=="Offers")?
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: StreamBuilder<List<NewAllTask>>(
                              stream: readAllTask("Offers", ),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text(
                                      ' Error ya Hantop :: ${snapshot.error}');
                                } else if (snapshot.hasData) {
                                  final task = snapshot.data!;
                                  return ListView(
                                    controller: _scrollController,
                                    shrinkWrap: true,
                                    children:
                                    //[Text("ghhg")]
                                    task.map(buildNewTasks).toList(),
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              }),
                        ) :
                        Container(height: 20,)
                      ]
                  )
              )
            ]
            )
          // )]
          // )
        )
    );
  }


  // Widget buildInventoryTask(NewInventoryTaskModel task) => InkWell(
  //   onTap: () {
  //     Get.defaultDialog(
  //       title:  'Details'.tr,
  //       content: SingleChildScrollView(
  //           child: Padding(
  //             padding: const EdgeInsets.only(
  //               right: 15,
  //               left: 15,
  //             ),
  //             child: Container(
  //               //padding: EdgeInsets.only(top: 20),
  //                 decoration: BoxDecoration(
  //                     color: kprimaryColor.withOpacity(0.45),
  //                     borderRadius:
  //                     // border: BorderRadius.circular(15)
  //                     // border
  //                     BorderRadius.circular(15)),
  //                 child: DataTable(dataTextStyle: TextStyle(fontSize: 20),
  //                     //showBottomBorder: true,
  //                     //border: TableBorder.all(),
  //                     //columnSpacing: 12,
  //                     columns: [
  //                       DataColumn(
  //                           label: Text(
  //                             'Order By'.tr.toUpperCase(),
  //                             style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                           )),
  //                       DataColumn(
  //                           label: Text(
  //                             task.branch,
  //                             style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                           )),
  //                     ], rows: [
  //                       DataRow(cells: <DataCell>[
  //                         DataCell(Text(
  //                           'Branch'.tr.toUpperCase(),
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                         DataCell(Text(
  //                           task.branch,
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                       ]),
  //
  //                       DataRow(cells: <DataCell>[
  //                         DataCell(Text(
  //                           'Market'.tr.toUpperCase(),
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                         DataCell(Text(
  //                           task.market,
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                       ]),
  //                       DataRow(cells: <DataCell>[
  //                         DataCell(Text(
  //                           'Date'.tr.toUpperCase(),
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                         DataCell(Text(
  //                           task.taskDate,
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                       ]),
  //
  //                       DataRow(cells: <DataCell>[
  //                         DataCell(Text(
  //                           'Details'.tr.toUpperCase(),
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                         DataCell(Text(
  //                           task.details,
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                       ]),
  //                       // )
  //                     ]
  //                 )
  //             ),
  //
  //           )
  //       ),
  //     );
  //
  //   },
  //
  //   child: Padding(
  //     padding: const EdgeInsets.only(left:15.0,right:15),
  //     child: Column(
  //       children: [
  //         Container(
  //           height: 40,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(20),
  //             color: kprimaryColor.withOpacity(0.45),
  //           ),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: <Widget>[
  //
  //       Padding(
  //         padding:  EdgeInsets.only(right:5.w,left: 5.w),
  //         child: Container(
  //           width:MediaQuery.of(context).size.width / 5,
  //
  //
  //           child: Text("Inventory".tr,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
  //               ),
  //   ),
  //   Padding(
  //     padding:  EdgeInsets.only(right:5.w,left: 5.w),
  //     child: Container(
  //       width:MediaQuery.of(context).size.width / 5,
  //
  //
  //       child: Text(task.taskDate,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold
  //
  //                 ),),
  //               ),
  //   ),
  //   Padding(
  //     padding:  EdgeInsets.only(right:5.w,left: 5.w),
  //     child: Container(
  //       width:MediaQuery.of(context).size.width / 5,
  //
  //
  //       child: Text(task.market,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
  //               ),
  //   ),
  //   Padding(
  //     padding:  EdgeInsets.only(right:5.w,left: 5.w),
  //     child: Container(
  //       width:MediaQuery.of(context).size.width / 5,
  //
  //
  //       child: Text((task.branch.length<=10)?task.branch.tr:task.branch.substring(0,10),style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold
  //       ),),
  //     )  ),
  //             ],
  //           ),
  //         ),
  //         Divider()
  //       ],
  //     ),
  //   ),
  // );
  // Widget buildAvailabilityTask(NewAvailabilityTaskModel task) => InkWell(
  //   onTap: () {
  //     Get.defaultDialog(
  //       title: 'Details'.tr,
  //       content: SingleChildScrollView(
  //           child: Padding(
  //             padding: const EdgeInsets.only(
  //               right: 15,
  //               left: 15,
  //             ),
  //             child: Container(
  //               //padding: EdgeInsets.only(top: 20),
  //                 decoration: BoxDecoration(
  //                     color: kprimaryColor.withOpacity(0.45),
  //                     borderRadius:
  //                     // border: BorderRadius.circular(15)
  //                     // border
  //                     BorderRadius.circular(15)),
  //                 child: DataTable(dataTextStyle: TextStyle(fontSize: 20),
  //                     //showBottomBorder: true,
  //                     //border: TableBorder.all(),
  //                     //columnSpacing: 12,
  //                     columns: [
  //                       DataColumn(
  //                           label: Text(
  //                             'Order By'.tr.toUpperCase(),
  //                             style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                           )),
  //                       DataColumn(
  //                           label: Text(
  //                             task.madeBy,
  //                             style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                           )),
  //                     ], rows: [
  //                       DataRow(cells: <DataCell>[
  //                         DataCell(Text(
  //                           'Branch'.tr.toUpperCase(),
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                         DataCell(Text(
  //                           task.branch,
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                       ]),
  //
  //                       DataRow(cells: <DataCell>[
  //                         DataCell(Text(
  //                           'Market'.tr.toUpperCase(),
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                         DataCell(Text(
  //                           task.market,
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                       ]),
  //                       DataRow(cells: <DataCell>[
  //                         DataCell(Text(
  //                           'Date'.tr.toUpperCase(),
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                         DataCell(Text(
  //                           task.taskDate,
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                       ]),
  //
  //                       DataRow(cells: <DataCell>[
  //                         DataCell(Text(
  //                           'Details'.tr.toUpperCase(),
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                         DataCell(Text(
  //                           task.details,
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                       ]),
  //                       // )
  //                     ]
  //                 )
  //             ),
  //
  //           )
  //       ),
  //     );
  //
  //   },
  //   child: Padding(
  //     padding: const EdgeInsets.only(left:15.0,right:15),
  //     child: Column(
  //       children: [
  //         Container(
  //           height: 40,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(20),
  //             color: kprimaryColor.withOpacity(0.45),
  //           ),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: <Widget>[
  //
  //           Padding(
  //             padding:  EdgeInsets.only(right:5.w,left: 5.w),
  //             child: Container(
  //               width:MediaQuery.of(context).size.width / 5,
  //
  //
  //               child: Text("Availability".tr,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
  //               ),
  //     ),
  //     Padding(
  //       padding:  EdgeInsets.only(right:5.w,left: 5.w),
  //       child: Container(
  //         width:MediaQuery.of(context).size.width / 5,
  //
  //
  //         child: Text(task.taskDate,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold
  //
  //                 ),),
  //               ),
  //     ),
  //     Padding(
  //       padding:  EdgeInsets.only(right:5.w,left: 5.w),
  //       child: Container(
  //         width:MediaQuery.of(context).size.width / 5,
  //
  //
  //         child: Text(task.market,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
  //               ),
  //     ),
  //     Padding(
  //       padding:  EdgeInsets.only(right:5.w,left: 5.w),
  //       child: Container(
  //         width:MediaQuery.of(context).size.width / 5,
  //
  //
  //         child: Text((task.branch.length<=10)?task.branch.tr:task.branch.substring(0,10),style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold
  //         ),),
  //       ) ),
  //             ],
  //           ),
  //         ),
  //         Divider()
  //       ],
  //     ),
  //   ),
  //   // leading: Container(
  //   //   height: 40,
  //   //   width: 120,
  //   //   decoration: BoxDecoration(
  //   //       color: Colors.white, borderRadius: BorderRadius.circular(10)),
  //   //   child: Center(child: Text("Availability".tr.toUpperCase())),
  //   // ),
  //   // title: Text(task.display),
  //   // subtitle: Text(task.taskDate),
  // );
  //
  //
  // Widget buildRTVTask(NewRTVTaskModel task) => InkWell(
  //   onTap: () {
  //     Get.defaultDialog(
  //       title:  'Details'.tr,
  //       content: SingleChildScrollView(
  //           child: Padding(
  //             padding: const EdgeInsets.only(
  //               right: 15,
  //               left: 15,
  //             ),
  //             child: Container(
  //               //padding: EdgeInsets.only(top: 20),
  //                 decoration: BoxDecoration(
  //                     color: kprimaryColor.withOpacity(0.45),
  //                     borderRadius:
  //                     // border: BorderRadius.circular(15)
  //                     // border
  //                     BorderRadius.circular(15)),
  //                 child: DataTable(dataTextStyle: TextStyle(fontSize: 20),
  //                     //showBottomBorder: true,
  //                     //border: TableBorder.all(),
  //                     //columnSpacing: 12,
  //                     columns: [
  //                       DataColumn(
  //                           label: Text(
  //                             'Order By'.tr.toUpperCase(),
  //                             style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                           )),
  //                       DataColumn(
  //                           label: Text(
  //                             task.madeBy,
  //                             style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                           )),
  //                     ], rows: [
  //                       DataRow(cells: <DataCell>[
  //                         DataCell(Text(
  //                           'Branch'.tr.toUpperCase(),
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                         DataCell(Text(
  //                           task.branch,
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                       ]),
  //
  //                       DataRow(cells: <DataCell>[
  //                         DataCell(Text(
  //                           'Market'.tr.toUpperCase(),
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                         DataCell(Text(
  //                           task.market,
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                       ]),
  //                       DataRow(cells: <DataCell>[
  //                         DataCell(Text(
  //                           'Date'.tr.toUpperCase(),
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                         DataCell(Text(
  //                           task.taskDate,
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                       ]),
  //
  //                       DataRow(cells: <DataCell>[
  //                         DataCell(Text(
  //                           'Details'.tr.toUpperCase(),
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                         DataCell(Text(
  //                           task.details,
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                       ]),
  //                       // )
  //                     ]
  //                 )
  //             ),
  //
  //           )
  //       ),
  //     );
  //
  //   },
  //   child: Padding(
  //     padding:  EdgeInsets.only(right:15.w,left: 15.w),
  //     child: Column(
  //       children: [
  //         Container(
  //           height: 40,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(20),
  //             color: kprimaryColor.withOpacity(0.45),
  //           ),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: <Widget>[
  //
  //       Padding(
  //         padding:  EdgeInsets.only(right:5.w,left: 5.w),
  //         child: Container(
  //             width:MediaQuery.of(context).size.width / 5,
  //
  //                     child: Text("RTV Section".tr,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),)),
  //               ),
  //
  //     Padding(
  //       padding:  EdgeInsets.only(right:5.w,left: 5.w),
  //       child: Container(
  //         width:MediaQuery.of(context).size.width / 5,
  //
  //
  //         child: Text(task.taskDate,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold
  //
  //                 ),),
  //               ),
  //     ),
  //       Padding(
  //         padding:  EdgeInsets.only(right:5.w,left: 5.w),
  //         child: Container(
  //           width:MediaQuery.of(context).size.width / 5,
  //
  //
  //           child: Text(task.market,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
  //         )),
  //
  //     Padding(
  //       padding:  EdgeInsets.only(right:5.w,left: 5.w),
  //       child: Container(
  //         width:MediaQuery.of(context).size.width / 5,
  //
  //
  //         child: Text((task.branch.length<=10)?task.branch.tr:task.branch.substring(0,10),style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold
  //                 ),),
  //               ),
  //     )              ],
  //           ),
  //         ),
  //         Divider()
  //       ],
  //     ),
  //   ),
  // );
  // Widget buildShareTask(NewShareOfShelve task) =>
  //     //  decoration: BoxDecoration(color: kprimaryColor.withOpacity(0.5)),
  // InkWell(
  //   onTap: () {
  //     Get.defaultDialog(
  //       title:  'Details'.tr,
  //       content: SingleChildScrollView(
  //           child: Padding(
  //             padding: const EdgeInsets.only(
  //               right: 15,
  //               left: 15,
  //             ),
  //             child: Container(
  //               //padding: EdgeInsets.only(top: 20),
  //                 decoration: BoxDecoration(
  //                     color: kprimaryColor.withOpacity(0.45),
  //                     borderRadius:
  //                     // border: BorderRadius.circular(15)
  //                     // border
  //                     BorderRadius.circular(15)),
  //                 child: DataTable(dataTextStyle: TextStyle(fontSize: 20),
  //                     //showBottomBorder: true,
  //                     //border: TableBorder.all(),
  //                     //columnSpacing: 12,
  //                     columns: [
  //                       DataColumn(
  //                           label: Text(
  //                             'Order By'.tr.toUpperCase(),
  //                             style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                           )),
  //                       DataColumn(
  //                           label: Text(
  //                             task.madeBy,
  //                             style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                           )),
  //                     ], rows: [
  //                       DataRow(cells: <DataCell>[
  //                         DataCell(Text(
  //                           'Branch'.tr.toUpperCase(),
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                         DataCell(Text(
  //                           task.branch,
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                       ]),
  //
  //                       DataRow(cells: <DataCell>[
  //                         DataCell(Text(
  //                           'Market'.tr.toUpperCase(),
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                         DataCell(Text(
  //                           task.market,
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                       ]),
  //                       DataRow(cells: <DataCell>[
  //                         DataCell(Text(
  //                           'Date'.tr.toUpperCase(),
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                         DataCell(Text(
  //                           task.date,
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                       ]),
  //
  //                       DataRow(cells: <DataCell>[
  //                         DataCell(Text(
  //                           'Details'.tr.toUpperCase(),
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                         DataCell(Text(
  //                           task.details,
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                       ]),
  //                       // )
  //                     ]
  //                 )
  //             ),
  //
  //           )
  //       ),
  //     );
  //
  //   },
  //   child: Padding(
  //     padding: const EdgeInsets.only(left:15.0,right:15),
  //     child: Column(
  //       children: [
  //         Container(
  //           height: 40,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(20),
  //             color: kprimaryColor.withOpacity(0.45),
  //           ),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: <Widget>[
  //           Padding(
  //             padding:  EdgeInsets.only(right:5.w,left: 5.w),
  //             child: Container(
  //               width:MediaQuery.of(context).size.width / 5,
  //
  //
  //               child: Text("Share Of Shelf".tr,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
  //               ),
  //     ),
  //
  //     Padding(
  //       padding:  EdgeInsets.only(right:5.w,left: 5.w),
  //       child: Container(
  //         width:MediaQuery.of(context).size.width / 5,
  //
  //
  //         child: Text((task.date.length<=10)?task.date.tr:task.date.substring(3),style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold
  //
  //                 ),),
  //               ),
  //     ),
  //
  //     Padding(
  //       padding:  EdgeInsets.only(right:5.w,left: 5.w),
  //       child: Container(
  //         width:MediaQuery.of(context).size.width / 5,
  //
  //
  //         child: Text((task.market.length<=10)?task.market.tr:task.market.substring(3),style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
  //               ),
  //     ),
  //
  //     Padding(
  //       padding:  EdgeInsets.only(right:5.w,left: 5.w),
  //       child: Container(
  //         width:MediaQuery.of(context).size.width / 5,
  //
  //         child: Text((task.branch.length<=10)?task.branch.tr:task.branch.substring(0,10),style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold
  //         ),),
  //               ),)
  //             ],
  //           ),
  //         ),
  //         Divider()
  //       ],
  //     ),
  //   ),
  //
  // );
  // Widget buildPricing(NewOffersTaskModel task) =>
  //     //  decoration: BoxDecoration(color: kprimaryColor.withOpacity(0.5)),
  // InkWell(
  //   onTap: () {
  //     Get.defaultDialog(
  //       title: 'Details'.tr,
  //       content: SingleChildScrollView(
  //           child: Padding(
  //             padding: const EdgeInsets.only(
  //               right: 15,
  //               left: 15,
  //             ),
  //             child: Container(
  //               //padding: EdgeInsets.only(top: 20),
  //                 decoration: BoxDecoration(
  //                     color: kprimaryColor.withOpacity(0.45),
  //                     borderRadius:
  //                     // border: BorderRadius.circular(15)
  //                     // border
  //                     BorderRadius.circular(15)),
  //                 child: DataTable(dataTextStyle: TextStyle(fontSize: 20),
  //                     //showBottomBorder: true,
  //                     //border: TableBorder.all(),
  //                     //columnSpacing: 12,
  //                     columns: [
  //                       DataColumn(
  //                           label: Text(
  //                             'Order By'.tr.toUpperCase(),
  //                             style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                           )),
  //                       DataColumn(
  //                           label: Text(
  //                             task.madeBy,
  //                             style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                           )),
  //                     ], rows: [
  //                       DataRow(cells: <DataCell>[
  //                         DataCell(Text(
  //                           'Branch'.tr.toUpperCase(),
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                         DataCell(Text(
  //                           task.branch,
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                       ]),
  //
  //                       DataRow(cells: <DataCell>[
  //                         DataCell(Text(
  //                           'Market'.tr.toUpperCase(),
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                         DataCell(Text(
  //                           task.market,
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                       ]),
  //                       DataRow(cells: <DataCell>[
  //                         DataCell(Text(
  //                           'Date'.tr.toUpperCase(),
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                         DataCell(Text(
  //                           task.taskDate,
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                       ]),
  //
  //                       DataRow(cells: <DataCell>[
  //                         DataCell(Text(
  //                           'Details'.tr.toUpperCase(),
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                         DataCell(Text(
  //                           task.details,
  //                           style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                         )),
  //                       ]),
  //                       // )
  //                     ]
  //                 )
  //             ),
  //
  //           )
  //       ),
  //     );
  //
  //   },
  //   child:Padding(
  //     padding: const EdgeInsets.only(left:15.0,right:15),
  //     child: Column(
  //       children: [
  //         Container(
  //           height: 40,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(20),
  //             color: kprimaryColor.withOpacity(0.45),
  //           ),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: <Widget>[
  //
  //           Padding(
  //           padding:  EdgeInsets.only(right:5.w,left: 5.w),
  //       child: Container(
  //         width:MediaQuery.of(context).size.width / 5,
  //
  //                 child: Text("Offers".tr,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
  //       ) ),
  //               Padding(
  //                 padding:  EdgeInsets.only(right:5.w,left: 5.w),
  //                 child: Container(
  //                   width:MediaQuery.of(context).size.width / 5,
  //
  //
  //                   child: Text((task.taskDate.length<=10)?task.taskDate.tr:task.taskDate.substring(3),style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold
  //
  //                   ),),
  //                 ),
  //               ),
  //
  //               Padding(
  //                 padding:  EdgeInsets.only(right:5.w,left: 5.w),
  //                 child: Container(
  //                   width:MediaQuery.of(context).size.width / 5,
  //
  //
  //                   child: Text((task.market.length<=10)?task.market.tr:task.market.substring(3),style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
  //                 ),
  //               ),
  //
  //               Padding(
  //                 padding:  EdgeInsets.only(right:5.w,left: 5.w),
  //                 child: Container(
  //                   width:MediaQuery.of(context).size.width / 5,
  //
  //                   child: Text((task.branch.length<=10)?task.branch.tr:task.branch.substring(0,10),style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold
  //                   ),),
  //                 ),)
  //             ],
  //           ),
  //         ),
  //         Divider()
  //       ],
  //     ),
  //   ),
  //
  // );
  //
  //
  // // planogram
  // Widget buildPlanogramTask(NewPlanogramModel task) => InkWell(
  //  onTap: (){
  //    Get.defaultDialog(
  //      title: 'Details'.tr,
  //      content: SingleChildScrollView(
  //          child: Padding(
  //            padding: const EdgeInsets.only(
  //              right: 15,
  //              left: 15,
  //            ),
  //            child: Container(
  //              //padding: EdgeInsets.only(top: 20),
  //                decoration: BoxDecoration(
  //                    color: kprimaryColor.withOpacity(0.45),
  //                    borderRadius:
  //                    // border: BorderRadius.circular(15)
  //                    // border
  //                    BorderRadius.circular(15)),
  //                child: DataTable(dataTextStyle: TextStyle(fontSize: 20),
  //                    //showBottomBorder: true,
  //                    //border: TableBorder.all(),
  //                    //columnSpacing: 12,
  //                    columns: [
  //                      DataColumn(
  //                          label: Text(
  //                            'Order By'.tr.toUpperCase(),
  //                            style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                          )),
  //                      DataColumn(
  //                          label: Text(
  //                            task.madeBy,
  //                            style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                          )),
  //                    ], rows: [
  //                      DataRow(cells: <DataCell>[
  //                        DataCell(Text(
  //                          'Branch'.tr.toUpperCase(),
  //                          style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                        )),
  //                        DataCell(Text(
  //                          task.branch,
  //                          style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                        )),
  //                      ]),
  //
  //                      DataRow(cells: <DataCell>[
  //                        DataCell(Text(
  //                          'Market'.tr.toUpperCase(),
  //                          style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                        )),
  //                        DataCell(Text(
  //                          task.market,
  //                          style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                        )),
  //                      ]),
  //                      DataRow(cells: <DataCell>[
  //                        DataCell(Text(
  //                          'Date'.tr.toUpperCase(),
  //                          style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                        )),
  //                        DataCell(Text(
  //                          task.date,
  //                          style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                        )),
  //                      ]),
  //
  //                      DataRow(cells: <DataCell>[
  //                        DataCell(Text(
  //                          'Details'.tr.toUpperCase(),
  //                          style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                        )),
  //                        DataCell(Text(
  //                          task.details,
  //                          style: const TextStyle(fontSize: 10,color: Colors.black87),
  //                        )),
  //                      ]),
  //                      // )
  //                    ]
  //                )
  //            ),
  //
  //          )
  //      ),
  //    );
  //  },
  //   child: Padding(
  //     padding: const EdgeInsets.only(left:15.0,right:15),
  //     child: Container(
  //       height: 40,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(20),
  //         color: kprimaryColor.withOpacity(0.45),
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: <Widget>[
  //
  //       Padding(
  //         padding:  EdgeInsets.only(right:5.w,left: 5.w),
  //         child: Container(
  //           width:MediaQuery.of(context).size.width / 5,
  //
  //
  //           child: Text("Planogram".tr,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
  //           ),
  //     ),
  //     Padding(
  //       padding:  EdgeInsets.only(right:5.w,left: 5.w),
  //       child: Container(
  //         width:MediaQuery.of(context).size.width / 5,
  //
  //
  //         child: Text(task.date,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold
  //
  //             ),),
  //           ),
  //     ),
  //     Padding(
  //       padding:  EdgeInsets.only(right:5.w,left: 5.w),
  //       child: Container(
  //         width:MediaQuery.of(context).size.width / 5,
  //
  //
  //         child: Text(task.market,style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
  //           ),
  //     ),
  //     Padding(
  //       padding:  EdgeInsets.only(right:5.w,left: 5.w),
  //       child: Container(
  //         width:MediaQuery.of(context).size.width / 5,
  //
  //
  //         child: Text((task.branch.length<=10)?task.branch.tr:task.branch.substring(0,10),style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold
  //         ),),
  //       )   ),
  //         ],
  //       ),
  //     ),
  //   ),
  // );
  Widget buildNewTasks(NewAllTask task) =>  Column
    (
      children:<Widget> [
        Material(
          elevation: 10,
          color: backgroundColor2,
          borderRadius: BorderRadius.circular(10.r),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            // onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 15.h),
              height: 82.h,
              width:MediaQuery.of(context).size.width-20,
              //344.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetails("Market".tr+"\t",
                          task.market),
                      titleAndDetails("Order By".tr+"\t", task.madeBy),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetails("Branch".tr+"\t",task.branch),

                      titleAndDetails('Date'.tr+"\t",     DateFormat('yyyy-MM-dd')
                          .format(task.date)),
                    ],
                  ),

                ],
              ),
            ),
          ),),
        SizedBox(height: 10.h,)
      ]
  );
  Widget titleAndDetails(String title, String details) {
    return
      //SizedBox(
      // height: 44.h,
      //  child:
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width:
            //(title.length<=6)?(MediaQuery.of(context).size.width /6.5).w:
            (MediaQuery.of(context).size.width /5.5).w,
           // color: kprimaryColor,
            child: Text(
                (title.length<=10)?title:title.substring(0,4)+"...",
                //+"..",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.sp)),
          ),
          SizedBox(width: 5.w),
          GestureDetector(
            onTap: (details.length>10)?(){
              Get.defaultDialog(
                title: "",
                content: Text(details),
              );
            }:(){ },
            // width: 200.w,
            child: Container(
              width: MediaQuery.of(context).size.width / 4.1,
              // color: kprimaryColor,
              child: Text((details.length<=10)?details:details.substring(0,10)+"...",
                  // softWrap: true,
                  style: TextStyle(
                      color: fontgrey,
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp)),
            ),
          ),
        ],
        // ),
      );
  }
  Stream<List<NewAllTask>> readAllTask(String title,) =>
      FirebaseFirestore.instance
          .collection('New Tasks')
      .where("merchandiser",isEqualTo :widget.merchandiser)
      .where("title",isEqualTo: title)
      .where('date',isLessThan:DateTime.parse(
          DateFormat('yyyy-MM-dd').format((DateTime.now()))
      ))
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => NewAllTask.fromJson(doc.data()))
          .toList());

}
