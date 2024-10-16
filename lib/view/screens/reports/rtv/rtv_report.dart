import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/view/screens/super_visor/super_app_bar.dart';
import 'package:arrow_merchandising/models/rtv_model.dart';
import 'package:arrow_merchandising/view/screens/reports/rtv/rtv_report_pdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:arrow_merchandising/const.dart';

class AndroidRtvReport extends StatefulWidget {
  final int id, phone;
  final String profileImage,
      username,
      role,
      branch,
      marketImage,
      market,
      nationality;

  final RTVTaskModel rtvTasks;
  const AndroidRtvReport({
    super.key,
    required this.rtvTasks,
    required this.role,
    required this.profileImage,
    required this.username,
    required this.branch,
    required this.market,
    required this.id,
    required this.phone,
    required this.nationality,
    required this.marketImage,
  });

  @override
  State<AndroidRtvReport> createState() => _AndroidRtvReportState();
}

class _AndroidRtvReportState extends State<AndroidRtvReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kprimaryColor,
          title: SuperAppBar(
            comeFrom: "report",
            title: "RTV Report",
            phone: widget.phone,
            market: widget.market,
            marketImage: widget.marketImage,
            branch: widget.branch,
            username: widget.username,
            profileImage: widget.profileImage,
          )),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            // here is our code :-
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 15,
                  left: 15,
                ),
                child: Column(
                  children: [
                    Container(
                      width: 330,
                      decoration: BoxDecoration(
                          color: kprimaryColor.withOpacity(0.45),
                          borderRadius: BorderRadius.circular(15)),
                      child: DataTable(
                          dataTextStyle: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                          columns: [
                            DataColumn(
                                label: Text(
                              'Market'.tr.toUpperCase(),
                            )),
                            DataColumn(
                                label: Text(
                              widget.rtvTasks.market,
                            )),
                          ],
                          rows: [
                            DataRow(cells: <DataCell>[
                              DataCell(Text(
                                'Branch'.tr.toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.black87),
                              )),
                              DataCell(Text(
                                widget.rtvTasks.branch,
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.black87),
                              )),
                            ]),
                            DataRow(cells: <DataCell>[
                              DataCell(Text(
                                'Task Type'.tr.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 13.sp, color: Colors.black87),
                              )),
                              DataCell(Text(
                                widget.rtvTasks.taskType,
                                style: TextStyle(
                                    fontSize: 13.sp, color: Colors.black87),
                              )),
                            ]),
                            if (widget.rtvTasks.taskType == "New Task")
                              DataRow(cells: <DataCell>[
                                DataCell(Text(
                                  'Order By'.tr.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 13.sp, color: Colors.black87),
                                )),
                                DataCell(Text(
                                  widget.rtvTasks.orderBy,
                                  style: TextStyle(
                                      fontSize: 13.sp, color: Colors.black87),
                                )),
                              ]),
                          ]),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Container(
                        child: Center(
                          child: Text(
                            "Returned products".tr.toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black87),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // for(int i=0; i<widget.rtvTasks.rtvProduct.length; i++)
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
                                i < widget.rtvTasks.rtvProduct.length;
                                i++)
                              DataRow(cells: <DataCell>[
                                DataCell(Text(
                                  '${widget.rtvTasks.rtvProduct[i].product}'
                                      .toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 13.sp, color: Colors.black87),
                                )),
                                DataCell(Text(
                                  '${widget.rtvTasks.rtvProduct[i].prAmount}' +
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
                                '${widget.rtvTasks.rtvProduct.length}' +
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
                      padding:
                          EdgeInsets.only(left: 30.w, right: 30.w, top: 5.h),
                      child: Divider(
                        color: Colors.black,
                      ),
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
                            )),
                            DataColumn(
                                label: Text(
                              widget.rtvTasks.madeBy,
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
                                widget.rtvTasks.taskDate,
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
                                widget.rtvTasks.taskTime,
                                style: TextStyle(
                                    fontSize: 13.sp, color: Colors.black87),
                              )),
                            ]),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        child: MaterialButton(
          onPressed: () {
            Get.to(() => AndroidRTVPdfReports(
                  rtvTask: widget.rtvTasks,
                  reportMadeBy: widget.username,
                ));
          },
          child: DefualtButton(
            selected: true,
            text: 'Create a pdf',
          ),
        ),
      ),
    );
  }
}
