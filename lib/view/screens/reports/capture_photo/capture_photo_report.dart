import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/view/screens/splash/indicator.dart';
import 'package:arrow_merchandising/view/screens/super_visor/super_app_bar.dart';
import 'package:arrow_merchandising/models/Visits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:arrow_merchandising/const.dart';
import 'capture-photo-pdf_reports.dart';

class AndroidCapturePhotoReport extends StatefulWidget {
  final FullVisit capturePhotos;

  final int id, phone;
  final String

      profileImage,
      username,
      role,
      branch,
      market,
      marketImage,
      nationality;


  const AndroidCapturePhotoReport(
      {super.key,

      required this.marketImage,
      // required this.secondphoto,
      required this.role,
      required this.profileImage,
      required this.username,
      required this.branch,
      required this.market,
      required this.id,
      required this.phone,
      required this.nationality,
      // required this.marketDetails,
      required this.capturePhotos});

  @override
  State<AndroidCapturePhotoReport> createState() =>
      _AndroidCapturePhotoReportState();
}

class _AndroidCapturePhotoReportState extends State<AndroidCapturePhotoReport>
    with TickerProviderStateMixin {
  var _sellectedIndex = 0;

  // bool startAnimation=false;
  // double screenHieght=0.0;
  // double screenWidth=0.0;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     setState(() {
  //
  //       startAnimation=true;
  //     });
  //   });
  // }
  List<String> categories = ["Before Ordering", "After Ordering"];
  @override
  Widget build(BuildContext context) {
    TabController controller =
        TabController(length: categories.length, vsync: this);
    // screenHieght=MediaQuery.of(context).size.height;
    // screenWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kprimaryColor,
          title: SuperAppBar(
            comeFrom: "report",
            // appBar: MerchAppBar(
            title: "Visit Report",
            //manegerName: widget.manegerName,
            phone: widget.phone,
            market: widget.market,
            marketImage: widget.marketImage,
            branch: widget.branch,
            username: widget.username,
            profileImage: widget.profileImage,
          )),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                right: (MediaQuery.of(context).size.height * 1 / 40).h,
                top: (MediaQuery.of(context).size.height * 1 / 160).h),
            child: Container(
              height: 50.h,

              // decoration: BoxDecoration(color: Colors.white),
              child: TabBar(
                  controller: controller,
                  //padding: EdgeInsets.all(1.h),
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  tabs: List.generate(
                    categories.length,
                    (index) => Container(
                      height: 80.h,
                      width: 140.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        //color:
                        // (dateFormat==
                        //     category[index])?
                        //kprimaryColor,
                        // :null,
                      ),
                      child: Center(
                        child: Text(
                          // (sharedlang=="ar")?
                          categories[index].tr,
                          //:category[index].substring(0,3).tr,
                          style: TextStyle(
                              fontSize: 15.sp,
                              color:
                                  // (dateFormat==category[index])?
                                  // whiteColor:
                                  // (categoriesDay[index]<FullIndex)?
                                  // redColor
                                  Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30, top: 5),
            child: Container(
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
                  columns: [
                    DataColumn(
                        label: Text(
                      'Market'.tr.toUpperCase(),
                      style:
                          const TextStyle(fontSize: 13, color: Colors.black87),
                    )),
                    DataColumn(
                        label: Text(
                      widget.capturePhotos.market,
                      style:
                          const TextStyle(fontSize: 13, color: Colors.black87),
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
                        widget.capturePhotos.branch,
                        style: const TextStyle(
                            fontSize: 13, color: Colors.black87),
                      )),
                    ]),
                    //DataRow(cells: <DataCell>[
                    DataRow(cells: <DataCell>[
                      DataCell(Text(
                        'Task Type'.tr.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 13, color: Colors.black87),
                      )),
                      DataCell(Text(
                        widget.capturePhotos.orderBy == "Daily Task"
                            ? "Daily Task"
                            : "New Task",
                        style: const TextStyle(
                            fontSize: 13, color: Colors.black87),
                      )),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(Text(
                        'Done By'.tr.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 13, color: Colors.black87),
                      )),
                      DataCell(Text(
                        widget.capturePhotos.madeBy,
                        style: const TextStyle(
                            fontSize: 13, color: Colors.black87),
                      )),
                    ]),
                  ]),
            ),
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
          Container(
              height: (MediaQuery.of(context).size.height / 1.35).h,
              child: TabBarView(

                  controller: controller, children: [
                Column(children: [
                  Container(

                   //padding: EdgeInsets.only(top: 10),
                    //width: 330,
                    height: 200,
                    child: PageView.builder(
                        onPageChanged: (value) {
                          setState(() {
                            _sellectedIndex = value;
                          });
                        },
                        itemCount: widget.capturePhotos.before.length,
                        itemBuilder: (context, index) {
                          var _scale = _sellectedIndex == index ? 1.0 : 0.8;
                          return TweenAnimationBuilder(
                            duration: const Duration(milliseconds: 3500),
                            //kAnimationDuration,
                            tween: Tween(begin: _scale, end: _scale),
                            curve: Curves.ease,
                            builder: (context, value, child) {
                              return Transform.scale(
                                  scale: value, child: child);
                            },
                            child: Container(
                                //width: 330.w,
                                //padding: EdgeInsets.only(top: 20),
                                decoration: BoxDecoration(
                                    color: kprimaryColor.withOpacity(0.45),
                                    borderRadius:
                                        // border: BorderRadius.circular(15)
                                        // border
                                        BorderRadius.circular(15)),
                                child: Image.network(widget
                                    .capturePhotos.before[0].images[index])),
                            // Container(
                            //
                            // padding: EdgeInsets.all(10),
                            //
                            // child: Image.network( widget.capturePhotos.before[0].images[index]),
                            // ),
                          );
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...List.generate(
                              widget.capturePhotos.before[0].images.length,
                              (index) => Indicator(
                                  isActive:
                                      _sellectedIndex == index ? true : false
                                  // isActive: isActive
                                  )
                              // buildDot(index: index),
                              ),
                        ]),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30.0, right: 30, top: 5),
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                        right: 15,
                        left: 15,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
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
                                dataTextStyle: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                                //showBottomBorder: true,
                                //border: TableBorder.all(),
                                //columnSpacing: 12,
                                columns: [
                                  DataColumn(
                                      label: Text(
                                    'Place'.tr.toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    widget.capturePhotos.before[0].place,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
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
                                      widget.capturePhotos.before[0].product,
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
                                      widget.capturePhotos.before[0].taskTime,
                                      style: const TextStyle(
                                          fontSize: 13, color: Colors.black87),
                                    )),
                                  ]),
                                ]),
                          ),
                        ],
                      )),
                ]),
                Column(children: [
                  Container(
                    padding: EdgeInsets.only(top: 10),
                  //  width: 330,
                    height: 200,
                    child: PageView.builder(
                        onPageChanged: (value) {
                          setState(() {
                            _sellectedIndex = value;
                          });
                        },
                        itemCount: widget.capturePhotos.after.length,
                        itemBuilder: (context, index) {
                          var _scale = _sellectedIndex == index ? 1.0 : 0.8;
                          return TweenAnimationBuilder(
                            duration: const Duration(milliseconds: 3500),
                            //kAnimationDuration,
                            tween: Tween(begin: _scale, end: _scale),
                            curve: Curves.ease,
                            builder: (context, value, child) {
                              return Transform.scale(
                                  scale: value, child: child);
                            },
                            child: Container(
                                width: 330.w,
                                //padding: EdgeInsets.only(top: 20),
                                decoration: BoxDecoration(
                                    color: kprimaryColor.withOpacity(0.45),
                                    borderRadius:
                                        // border: BorderRadius.circular(15)
                                        // border
                                        BorderRadius.circular(15)),
                                child: Image.network(
                                  widget.capturePhotos.after[0].images[index],
                                )),
                            // child: Image.network(
                            //     widget.capturePhotos.after[0].images[index],
                            //   width: 330.w,
                            // ),
                            //  ),
                          );
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...List.generate(
                              widget.capturePhotos.after[0].images.length,
                              (index) => Indicator(
                                  isActive:
                                      _sellectedIndex == index ? true : false
                                  // isActive: isActive
                                  )
                              // buildDot(index: index),
                              ),
                        ]),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30.0, right: 30, top: 5),
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                        right: 15,
                        left: 15,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
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
                                dataTextStyle: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                                //showBottomBorder: true,
                                //border: TableBorder.all(),
                                //columnSpacing: 12,
                                columns: [
                                  DataColumn(
                                      label: Text(
                                    'Place'.tr.toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    widget.capturePhotos.after[0].place,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
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
                                      widget.capturePhotos.after[0].product,
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
                                      widget.capturePhotos.after[0].taskTime,
                                      style: const TextStyle(
                                          fontSize: 13, color: Colors.black87),
                                    )),
                                  ]),
                                ]),
                          ),
                        ],
                      )),
                ])
              ])),
        ],
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        child: MaterialButton(
          onPressed: () {
            Get.to(() => AndroidCapturePhotoPdfReports(
                  reportMadeBy: widget.username,
                  capturePhotos: widget.capturePhotos,
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
