
import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/view/screens/super_visor/super_app_bar.dart';
import 'package:arrow_merchandising/models/inventory_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:arrow_merchandising/const.dart';
import 'inventory_report_pdf.dart';

class AndroidInventoryReport extends StatefulWidget {
  final InventoryTask inventoryTask;
  final int id, phone;
  final String profileImage,
      username,
      branch,
      market,
      marketImage,
      nationality,
      role;
  const AndroidInventoryReport(
      {super.key,

      required this.profileImage,
      required this.username,
      required this.branch,
      required this.market,
      required this.id,
      required this.phone,
      required this.nationality,
      required this.marketImage,
      required this.role,
      required this.inventoryTask});

  @override
  State<AndroidInventoryReport> createState() => _AndroidInventoryReportState();
}

class _AndroidInventoryReportState extends State<AndroidInventoryReport>
    with TickerProviderStateMixin {
  var _sellectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    //  TabController controller = TabController(length: 2, vsync: this);
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kprimaryColor,
          title: SuperAppBar(
            comeFrom: "report",
            // appBar: MerchAppBar(
            title: "Inventory Report",
            //manegerName: widget.manegerName,
            phone: widget.phone,
            market: widget.market,
            marketImage: widget.marketImage,
            branch: widget.branch,
            username: widget.username,
            profileImage: widget.profileImage,
          )),
      body: ListView(shrinkWrap: true, children: <Widget>[
        SizedBox(height: 10.h),
        // here is our code :-
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              right: 15.w,
              left: 15.w,
            ),
            child: Column(
              children: [
                Container(
                  width: 330.w,
                  //padding: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: kprimaryColor.withOpacity(0.45),
                      borderRadius:
                          // border: BorderRadius.circular(15)
                          // border
                          BorderRadius.circular(15)),
                  child: DataTable(
                      dataTextStyle:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      //showBottomBorder: true,
                      //border: TableBorder.all(),
                      //columnSpacing: 12,
                      columns: [
                        DataColumn(
                            label: Text(
                          'Market'.tr.toUpperCase(),
                          //   style: const TextStyle(fontSize: 18,color: Colors.black87),
                        )),
                        DataColumn(
                            label: Text(
                          widget.inventoryTask.market,
                          // style: const TextStyle(fontSize: 18,color: Colors.black87),
                        )),
                      ],
                      rows: [
                        DataRow(cells: <DataCell>[
                          DataCell(Text(
                            'Branch'.tr.toUpperCase(),
                            style: TextStyle(
                                fontSize: 13.sp, color: Colors.black87),
                          )

                              // Text(merchandiserName)
                              ),
                          DataCell(Text(
                            widget.inventoryTask.branch,
                            style: TextStyle(
                                fontSize: 13.sp, color: Colors.black87),
                          )),
                        ]),
                        DataRow(cells: <DataCell>[
                          DataCell(Text(
                            'Task Type'.tr.toUpperCase(),
                            style: TextStyle(
                                fontSize: 13.sp, color: Colors.black87),
                          )

                              // Text(merchandiserName)
                              ),
                          DataCell(Text(
                            widget.inventoryTask.taskType,
                            style: TextStyle(
                                fontSize: 13.sp, color: Colors.black87),
                          )),
                        ]),
                        if (widget.inventoryTask.taskType == "New Task")
                          DataRow(cells: <DataCell>[
                            DataCell(Text(
                              'Order By'.tr.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 13.sp, color: Colors.black87),
                            )

                                // Text(merchandiserName)
                                ),
                            DataCell(Text(
                              widget.inventoryTask.orderBy,
                              style: TextStyle(
                                  fontSize: 13.sp, color: Colors.black87),
                            )),
                          ]),
                      ]),
                ),

                SizedBox(
                  height: 10.h,
                ),
                //  for(int i=0; i<widget.inventoryTask.inventoryProduct.length; i++)
                Container(
                  width: 330.w,
                  //padding: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: kprimaryColor.withOpacity(0.45),
                      borderRadius:
                          // border: BorderRadius.circular(15)
                          // border
                          BorderRadius.circular(15)),
                  child: DataTable(
                      dataTextStyle: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.bold),
                      columns: [
                        DataColumn(
                            label: Text(
                          'Product'.tr.toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.sp,
                              color: Colors.black87),
                        )),
                        DataColumn(
                            label: Text(
                          'Quantity'.tr.toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.sp,
                              color: Colors.black87),
                        )),
                      ],
                      rows: [
                        for (int i = 0;
                            i < widget.inventoryTask.inventoryProduct.length;
                            i++)
                          DataRow(cells: <DataCell>[
                            DataCell(Text(
                              '${widget.inventoryTask.inventoryProduct[i].product}'
                                  .toUpperCase(),
                              style: TextStyle(
                                  fontSize: 13.sp, color: Colors.black87),
                            )),
                            DataCell(Text(
                              '${widget.inventoryTask.inventoryProduct[i].prAmount}' +
                                  '\t' +
                                  'Item'.tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp,
                                  color: Colors.black87),
                            )),
                          ]),
                        DataRow(cells: <DataCell>[
                          DataCell(Text(
                            'products'.tr.toUpperCase(),
                            style: TextStyle(
                                fontSize: 13.sp, color: Colors.black87),
                          )),
                          DataCell(Text(
                            '${widget.inventoryTask.inventoryProduct.length}' +
                                '\t' +
                                'Item'.tr,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp,
                                color: Colors.black87),
                          )),
                        ]),
                      ]),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 5.h),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  width: 330.w,
                  decoration: BoxDecoration(
                      color: kprimaryColor.withOpacity(0.45),
                      borderRadius: BorderRadius.circular(15)),
                  child: DataTable(
                      dataTextStyle: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.bold),
                      columns: [
                        DataColumn(
                            label: Text(
                          'Done By'.tr.toUpperCase(),
                          //   style: const TextStyle(fontSize: 18,color: Colors.black87),
                        )),
                        DataColumn(
                            label: Text(
                          widget.inventoryTask.madeBy,
                          // style: const TextStyle(fontSize: 18,color: Colors.black87),
                        )),
                      ],
                      rows: [
                        DataRow(cells: <DataCell>[
                          DataCell(Text(
                            'Date'.tr.toUpperCase(),
                            style: TextStyle(
                                fontSize: 13.sp, color: Colors.black87),
                          )),
                          DataCell(Text(
                            widget.inventoryTask.taskDate,
                            style: TextStyle(
                                fontSize: 13.sp, color: Colors.black87),
                          )),
                        ]),
                        DataRow(cells: <DataCell>[
                          DataCell(Text(
                            'Time'.tr.toUpperCase(),
                            style: TextStyle(
                                fontSize: 13.sp, color: Colors.black87),
                          )),
                          DataCell(Text(
                            widget.inventoryTask.taskTime,
                            style: TextStyle(
                                fontSize: 13.sp, color: Colors.black87),
                          )),
                        ]),
                      ]),
                ),
                // SizedBox(height: 20.h,),
              ],
            ),
          ),
        )
      ]),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        child: MaterialButton(
          onPressed: () {
            Get.to(() => AndroidinventoryPdfReports(
                  reportMadeBy: widget.username,
                  inventoryTask: widget.inventoryTask,
                ));
          },
          child: DefualtButton(
            selected: true,
            text: 'Create a Pdf'.tr,
          ),
        ),
      ),
    );
  }
}
