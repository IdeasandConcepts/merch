import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/view/screens/reports/pricing/pricing_pdf_report.dart';
import 'package:arrow_merchandising/models/pricing_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:arrow_merchandising/const.dart';
import '../../splash/indicator.dart';
import '../../super_visor/super_app_bar.dart';

class AndroidPricingReport extends StatefulWidget {
  final PricingTask pricingTaskModel;

  final int id, phone;
  final String profileImage,
      username,
      role,
      branch,
      market,
      marketImage,
      nationality;

  const AndroidPricingReport({
    super.key,
    required this.pricingTaskModel,
    required this.id,
    required this.phone,
    required this.marketImage,
    required this.username,
    required this.branch,
    required this.market,
    required this.nationality,
    required this.profileImage,
    required this.role,
  });

  @override
  State<AndroidPricingReport> createState() => _AndroidPricingReportState();
}

class _AndroidPricingReportState extends State<AndroidPricingReport> {
  var _sellectedIndex = 0;

  bool startAnimation = false;

  double screenHieght = 0.0;

  double screenWidth = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHieght = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kprimaryColor,
          title: SuperAppBar(
            comeFrom: "report",
            title: "Offers Report",
            phone: widget.phone,
            market: widget.market,
            marketImage: widget.marketImage,
            branch: widget.branch,
            username: widget.username,
            profileImage: widget.profileImage,
          )),
      body: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30, top: 5),
          child: Container(
            width: 330,
            decoration: BoxDecoration(
                color: kprimaryColor.withOpacity(0.45),
                borderRadius: BorderRadius.circular(15)),
            child: DataTable(
                dataTextStyle:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                columns: [
                  DataColumn(
                      label: Text(
                    'Market'.tr.toUpperCase(),
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                  )),
                  DataColumn(
                      label: Text(
                    widget.pricingTaskModel.market,
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                  )),
                ],
                rows: [
                  DataRow(cells: <DataCell>[
                    DataCell(Text(
                      'Branch'.tr.toUpperCase(),
                      style:
                          const TextStyle(fontSize: 13, color: Colors.black87),
                    )),
                    DataCell(Text(
                      widget.pricingTaskModel.branch,
                      style:
                          const TextStyle(fontSize: 13, color: Colors.black87),
                    )),
                  ]),
                  DataRow(cells: <DataCell>[
                    DataCell(Text(
                      'Task Type'.tr.toUpperCase(),
                      style: TextStyle(fontSize: 13.sp, color: Colors.black87),
                    )),
                    DataCell(Text(
                      widget.pricingTaskModel.taskType,
                      style: TextStyle(fontSize: 13.sp, color: Colors.black87),
                    )),
                  ]),
                  if (widget.pricingTaskModel.taskType == "New Task")
                    DataRow(cells: <DataCell>[
                      DataCell(Text(
                        'Order By'.tr.toUpperCase(),
                        style:
                            TextStyle(fontSize: 13.sp, color: Colors.black87),
                      )),
                      DataCell(Text(
                        widget.pricingTaskModel.orderBy,
                        style:
                            TextStyle(fontSize: 13.sp, color: Colors.black87),
                      )),
                    ]),
                ]),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30, top: 5),
          child: Container(
            height: 180,
            decoration: BoxDecoration(
                color: kprimaryColor.withOpacity(0.45),
                borderRadius: BorderRadius.circular(15)),
            child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    _sellectedIndex = value;
                  });
                },
                itemCount: widget.pricingTaskModel.pricingProduct.length,
                itemBuilder: (context, index) {
                  var _scale = _sellectedIndex == index ? 1.0 : 0.8;
                  return TweenAnimationBuilder(
                    duration: const Duration(milliseconds: 3500),
                    //kAnimationDuration,
                    tween: Tween(begin: _scale, end: _scale),
                    curve: Curves.ease,
                    builder: (context, value, child) {
                      return Transform.scale(scale: value, child: child);
                    },
                    child: Container(
                      child: Image.network(
                        widget.pricingTaskModel.pricingProduct[index]
                            .images[index],
                      ),
                    ),
                  );
                }),
          ),
        ),
        // Image.network( widget.pricingTaskModel.pricingProduct[index].images[index]),
        Padding(
          padding: EdgeInsets.only(top: 15, bottom: 15),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ...List.generate(
                widget.pricingTaskModel.pricingProduct[0].images.length,
                (index) =>
                    Indicator(isActive: _sellectedIndex == index ? true : false)
                // buildDot(index: index),
                ),
          ]),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30, top: 5),
          child: Divider(
            color: Colors.black,
          ),
        ),
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
                  //padding: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: kprimaryColor.withOpacity(0.45),
                      borderRadius:
                          // border: BorderRadius.circular(15)
                          // border
                          BorderRadius.circular(15)),
                  child: DataTable(
                      dataTextStyle:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      //showBottomBorder: true,
                      //border: TableBorder.all(),
                      //columnSpacing: 12,
                      columns: [
                        DataColumn(
                            label: Text(
                          'Place'.tr.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                            label: Text(
                          widget.pricingTaskModel.place,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        )),
                      ],
                      rows: [
                        DataRow(cells: <DataCell>[
                          DataCell(Text(
                            'Product'.tr.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 13, color: Colors.black87),
                          )),
                          DataCell(Text(
                            widget.pricingTaskModel.pricingProduct[0].product,
                            style: const TextStyle(
                                fontSize: 13, color: Colors.black87),
                          )),
                        ]),
                        //   rows: [
                        DataRow(cells: <DataCell>[
                          DataCell(Text(
                            'Price'.tr.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 13, color: Colors.black87),
                          )),
                          DataCell(Text(
                            '${widget.pricingTaskModel.pricingProduct[0].price}',
                            style: const TextStyle(
                                fontSize: 13, color: Colors.black87),
                          )),
                        ]),
                        DataRow(cells: <DataCell>[
                          DataCell(Text(
                            'Details'.tr.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 13, color: Colors.black87),
                          )),
                          DataCell(Text(
                            '${widget.pricingTaskModel.pricingProduct[0].details}',
                            style: const TextStyle(
                                fontSize: 13, color: Colors.black87),
                          )),
                        ]),
                      ]),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 330,
                  //padding: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: kprimaryColor.withOpacity(0.45),
                      borderRadius: BorderRadius.circular(15)),
                  child: DataTable(
                      //dataTextStyle: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
                      dataTextStyle:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      columns: [
                        DataColumn(
                            label: Text(
                          'Done By'.tr.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                            label: Text(
                          widget.pricingTaskModel.madeBy,
                          style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        )),
                      ],
                      rows: [
                        DataRow(cells: <DataCell>[
                          DataCell(Text(
                            'Task Date'.tr.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 13, color: Colors.black87),
                          )),
                          DataCell(Text(
                            widget.pricingTaskModel.taskDate,
                            style: const TextStyle(
                                fontSize: 13, color: Colors.black87),
                          )),
                        ]),
                        DataRow(cells: <DataCell>[
                          DataCell(Text(
                            'Time'.tr.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 13, color: Colors.black87),
                          )),
                          DataCell(Text(
                            widget.pricingTaskModel.taskTime,
                            style: const TextStyle(
                                fontSize: 13, color: Colors.black87),
                          )),
                        ]),
                      ]),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),

        // SizedBox(height: 10,),
      ]),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        child: MaterialButton(
          onPressed: () {
            Get.to(() => AndroidPricingTaskPdfReports(
                  repoortMadeBy: widget.username,
                  pricingTask: widget.pricingTaskModel,
                ));
          },
          child: DefualtButton(
            selected: true,
            text: 'Create a Pdf'.tr,
          ),
        ),
      ),
      //floatingActionButton:
    );
  }
}
