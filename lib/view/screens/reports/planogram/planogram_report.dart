import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/view/screens/super_visor/super_app_bar.dart';
import 'package:arrow_merchandising/const.dart';
import 'package:arrow_merchandising/models/ai_planogram_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'plnogram_pdf_report.dart';

class AndroidPlanogramReport extends StatefulWidget {
  final AiPlanogramModel planogramModel;
  final int id, phone;
  final String profileImage,
      username,
      role,
      branch,
      market,
      marketImage,
      nationality;

  const AndroidPlanogramReport(
      {super.key,
      required this.profileImage,
      required this.username,
      required this.branch,
      required this.market,
      required this.id,
      required this.phone,
      required this.nationality,
      required this.planogramModel,
      required this.role,
      required this.marketImage});

  @override
  State<AndroidPlanogramReport> createState() => _AndroidPlanogramReportState();
}

class _AndroidPlanogramReportState extends State<AndroidPlanogramReport>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kprimaryColor,
          title: SuperAppBar(
            comeFrom: "report",
            title: "Planogram Report",
            phone: widget.phone,
            market: widget.market,
            marketImage: widget.marketImage,
            branch: widget.branch,
            username: widget.username,
            profileImage: widget.profileImage,
          )),
      body: ListView(children: <Widget>[
        Column(
          children: [
            SizedBox(
              height: 10,
            ),
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
                      widget.planogramModel.market,
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
                        widget.planogramModel.branch,
                        style: const TextStyle(
                            fontSize: 13, color: Colors.black87),
                      )),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(Text(
                        'Task Type'.tr.toUpperCase(),
                        style:
                            TextStyle(fontSize: 13.sp, color: Colors.black87),
                      )),
                      DataCell(Text(
                        widget.planogramModel.taskType,
                        style:
                            TextStyle(fontSize: 13.sp, color: Colors.black87),
                      )),
                    ]),
                    if (widget.planogramModel.taskType == "New Task")
                      DataRow(cells: <DataCell>[
                        DataCell(Text(
                          'Order By'.tr.toUpperCase(),
                          style:
                              TextStyle(fontSize: 13.sp, color: Colors.black87),
                        )),
                        DataCell(Text(
                          widget.planogramModel.orderBy,
                          style:
                              TextStyle(fontSize: 13.sp, color: Colors.black87),
                        )),
                      ]),
                  ]),
            ),
            Container(
              height: 260.h,
              width: 330.w,
              child: Image.network(widget.planogramModel.imagePath),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 30.w,
                right: 30.w,
              ),
              child: Divider(
                color: Colors.black,
              ),
            ),
            if (widget.planogramModel.degree == "Excellent")
              Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: Container(
                      decoration: BoxDecoration(
                          color: kprimaryColor.withOpacity(0.45),
                          borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.all(10),
                      height: 70,
                      width: double.maxFinite,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Result is".tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16.sp),
                              ),
                              Text(widget.planogramModel.degree),
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Degree is".tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16.sp),
                                ),
                                Text("90 - 100"),
                              ])
                        ],
                      ))),
            if (widget.planogramModel.degree == "Very Good")
              Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: Container(
                      decoration: BoxDecoration(
                          color: kprimaryColor.withOpacity(0.45),
                          borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.all(10),
                      height: 70,
                      //color: kprimaryColor,
                      width: double.maxFinite,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Result is".tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16.sp),
                              ),
                              Text(widget.planogramModel.degree),
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Degree is".tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16.sp),
                                ),
                                Text("70 - 90"),
                              ])
                        ],
                      ))),
            if (widget.planogramModel.degree == "Good")
              Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: Container(
                      decoration: BoxDecoration(
                          color: kprimaryColor.withOpacity(0.45),
                          borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.all(10),
                      height: 70,
                      //color: kprimaryColor,
                      width: double.maxFinite,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Result is".tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16.sp),
                              ),
                              Text(widget.planogramModel.degree),
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Degree is".tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16.sp),
                                ),
                                Text("50 - 70"),
                              ])
                        ],
                      ))),
            if (widget.planogramModel.degree == "Not Arranged")
              Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: Container(
                      decoration: BoxDecoration(
                          color: kprimaryColor.withOpacity(0.45),
                          borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.all(10),
                      height: 70,
                      //color: kprimaryColor,
                      width: double.maxFinite,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Result is".tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16.sp),
                              ),
                              Text(widget.planogramModel.degree),
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Degree is".tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 16.sp),
                                ),
                                Text("< 50"),
                              ])
                        ],
                      ))),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 5.h),
          child: Divider(
            color: Colors.black,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Container(
            width: 330.w,
            decoration: BoxDecoration(
                color: kprimaryColor.withOpacity(0.45),
                borderRadius: BorderRadius.circular(15)),
            child: DataTable(
                dataTextStyle:
                    TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
                columns: [
                  DataColumn(
                      label: Text(
                    'Done By'.tr.toUpperCase(),
                  )),
                  DataColumn(
                      label: Text(
                    widget.planogramModel.madeBy,
                  )),
                ],
                rows: [
                  DataRow(cells: <DataCell>[
                    DataCell(Text(
                      'Date'.tr.toUpperCase(),
                      style: TextStyle(fontSize: 13.sp, color: Colors.black87),
                    )),
                    DataCell(Text(
                      widget.planogramModel.taskDate,
                      style: TextStyle(fontSize: 13.sp, color: Colors.black87),
                    )),
                  ]),
                  DataRow(cells: <DataCell>[
                    DataCell(Text(
                      'Time'.tr.toUpperCase(),
                      style: TextStyle(fontSize: 13.sp, color: Colors.black87),
                    )),
                    DataCell(Text(
                      widget.planogramModel.taskTime,
                      style: TextStyle(fontSize: 13.sp, color: Colors.black87),
                    )),
                  ]),
                ]),
          ),
        )
      ]),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        child: MaterialButton(
          onPressed: () {
            Get.to(() => AndroidPlonogramPdfReports(
                  planogramModel: widget.planogramModel,
                  repoortMadeBy: widget.username,
                ));
            // Save Data ....
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
