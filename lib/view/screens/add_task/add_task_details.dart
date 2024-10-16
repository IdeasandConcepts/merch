import 'dart:math';

import 'package:arrow_merchandising/models/new_task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:arrow_merchandising/const.dart';
import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/view/screens/splash/auth_page.dart';
import 'package:intl/intl.dart';



class RtvTaskDetails extends StatefulWidget {
  final String comeFrom;
  final int id, phone;
  final String profileImage;
  final String userName, marketImage, product, market, branch;
  final String detail, selectedMarket, selectedBranch, title;
  final DateTime taskDate;
  final String merchandiser;
  const RtvTaskDetails({
    super.key,
    required this.detail,
    required this.title,
    required this.profileImage,
    required this.branch,
    required this.userName,
    required this.taskDate,
    required this.id,
    required this.phone,
    required this.market,
    required this.product,
    required this.selectedBranch,
    required this.comeFrom,
    required this.marketImage,
    required this.merchandiser,
    required this.selectedMarket,
  });

  @override
  State<RtvTaskDetails> createState() => _RtvTaskDetailsState();
}

class _RtvTaskDetailsState extends State<RtvTaskDetails> {
  ScrollController _scrollController = ScrollController();
  List<String> branchesList = [];
  List<int> customerCodesList = [];

  Future getBranchesId(String market) async {
    await FirebaseFirestore.instance
        .collection(market)
        //.orderBy('branch_id')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection(market)
            .doc(element.reference.id)
            .get()
            .then((value) {
          Map<String, dynamic> data = value.data() as Map<String, dynamic>;

          branchesList.add(data['branch_name']);
          customerCodesList.add(data['branch_id']);
        });
      });
    });
    print("All Data Added");
    print(branchesList.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kprimaryColor,
          title: Text(
            widget.title.tr.toUpperCase(),
            style: TextStyle(color: Colors.white, fontSize: 20.sp),
          ),
          leading: IconButton(
              onPressed: () {
                Get.offAll(AndroidAuthPage());
              },
              icon: Icon(
                Icons.home,
                color: Colors.white,
              )),
          centerTitle: true,
        ),
        body: ListView(
          shrinkWrap: true,
          controller: _scrollController,
          children: <Widget>[
            const SizedBox(height: 15.0),
            Padding(
              padding: EdgeInsets.only(
                  left: 20.w, right: 20.w, top: 10.h, bottom: 10.h),
              child: Container(
                height: 50,
                width: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.2)),
                child: Center(
                  child: Text(
                    "Review".tr.toUpperCase(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                // padding: EdgeInsets.only(left: 20.w,right: 20.w),
                width: 330.w,
                height: 90.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 10.w, right: 10.w),
                      width: 330.w,
                      height: 40.h,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Market'.tr,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            Text(widget.selectedMarket,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                          ]
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.w, right: 10.w),
                      width: 330.w,
                      height: 40.h,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Branch'.tr,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            Text(widget.selectedBranch,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                          ]),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
              child: Container(
                width: 330.w,
                height: 90.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(left: 10.h, right: 10.h),
                        width: 330.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Merchandiser'.tr,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold)),
                            Text(widget.merchandiser,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold))
                          ],
                        )),
                    Container(
                        height: 40,
                        width: 330,
                        padding: EdgeInsets.only(left: 10.h, right: 10.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Order By'.tr,
                              style: TextStyle(
                                  fontSize: 15.sp, fontWeight: FontWeight.bold),
                            ),
                            Text(widget.userName,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                          ],
                          // rows: [
                          //
                          // ]
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: Container(
                width: 330.w,
                height: 90.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(),
                ),
                child: Column(children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    width: 330.w,
                    height: 40.h,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Task Date'.tr,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Text(DateFormat('yyyy-MM-dd').format(widget.taskDate),
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold))
                        ]),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    width: 330.w,
                    height: 40.h,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Display'.tr,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Text(widget.product.tr,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                        ]),
                  ),
                ]
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.h, right: 20.h),
              child: Container(
                  padding: EdgeInsets.only(left: 20.h, right: 20.h),
                  height: 200,
                  width: 330,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:<Widget> [
                      Text('Details'.tr,
                          style: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.bold)),
                      Text(widget.detail,
                          style: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.bold))
                    ],
                  )),
            ),
            SizedBox(
              height: 30.h,
            ),
            MaterialButton(
              onPressed: () {
                createNewTask(NewAllTask(
                    taskIndex: Random().nextInt(17565777).toInt(),
                    title: widget.title,
                    place: widget.product,
                    details: widget.detail,
                    status: "not yet",
                    madeBy: widget.userName,
                    branch: widget.selectedBranch,
                    date: widget.taskDate,
                    market: widget.selectedMarket,
                    merchandiser: widget.merchandiser));
                Get.offAll(() => AndroidAuthPage());
              },
              child: DefualtButton(
                selected: true,
                text: 'Confirm'.tr,
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ));
  }

  Future createNewTask(NewAllTask task) async {
    final taskData = FirebaseFirestore.instance.collection('New Tasks').doc();
    final json = task.tojson();
    await taskData.set(json);
  }
}
