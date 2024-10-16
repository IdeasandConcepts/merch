import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/view/screens/reports/share0fshelfs/share_of_shelfs_pdf_reports.dart';
import 'package:arrow_merchandising/view/screens/super_visor/super_app_bar.dart';
import 'package:arrow_merchandising/const.dart';
import 'package:arrow_merchandising/models/ai_share_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AndroidShareOfShelvesReport extends StatefulWidget {
  final AiShareModel shareOfShellTask;
  final int id, phone;
  final String profileImage,
      username,
      role,
      branch,
      market,
      marketImage,
      nationality;

  const AndroidShareOfShelvesReport({
    super.key,
    required this.shareOfShellTask,
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
  State<AndroidShareOfShelvesReport> createState() =>
      _AndroidShareOfShelvesReportState();
}

class _AndroidShareOfShelvesReportState
    extends State<AndroidShareOfShelvesReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kprimaryColor,
          title: SuperAppBar(
            comeFrom: "report",
            title: "Shelves Report",
            phone: widget.phone,
            market: widget.market,
            marketImage: widget.marketImage,
            branch: widget.branch,
            username: widget.username,
            profileImage: widget.profileImage,
          )),
      body: SingleChildScrollView(
          child: ListView(shrinkWrap: true, children: [
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
                      dataTextStyle:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      columns: [
                        DataColumn(
                            label: Text(
                          'Market'.tr.toUpperCase(),
                        )),
                        DataColumn(
                            label: Text(
                          widget.shareOfShellTask.market,
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
                            widget.shareOfShellTask.branch,
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
                            widget.shareOfShellTask.taskType,
                            style: TextStyle(
                                fontSize: 13.sp, color: Colors.black87),
                          )),
                        ]),
                        if (widget.shareOfShellTask.taskType == "New Task")
                          DataRow(cells: <DataCell>[
                            DataCell(Text(
                              'Order By'.tr.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 13.sp, color: Colors.black87),
                            )),
                            DataCell(Text(
                              widget.shareOfShellTask.orderBy,
                              style: TextStyle(
                                  fontSize: 13.sp, color: Colors.black87),
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
                  height: 10,
                ),
                Container(
                    width: 330.w,
                    decoration: BoxDecoration(
                        color: kprimaryColor.withOpacity(0.45),
                        borderRadius: BorderRadius.circular(15)),
                    child: Image.network(widget.shareOfShellTask.imagePath)),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    width: 330.w,
                    height: 40.h,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                        color: kprimaryColor.withOpacity(0.45),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Case",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            (widget.shareOfShellTask.degree < 50)
                                ? "Full Of Stock"
                                : "Empty Area" +
                                    '\t' +
                                    '${widget.shareOfShellTask.degree}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        ]),
                  ),
                ),
                SizedBox(
                  height: 10,
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
                          widget.shareOfShellTask.madeBy,
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
                            widget.shareOfShellTask.taskDate,
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
                            widget.shareOfShellTask.taskTime,
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
      ])),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        child: MaterialButton(
          onPressed: () {
            Get.to(() => AndroidShareSfShelfPdfReports(
                reportMadeBy: widget.username,
                shareOfShellTask: widget.shareOfShellTask));
            // Save Data ....
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
