import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/merch_nav_bar.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/profile/branch_appbar.dart';
import 'package:arrow_merchandising/const.dart';
import 'package:arrow_merchandising/models/pricing_model.dart';
import 'package:arrow_merchandising/models/pricing_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class OfferReview extends StatefulWidget {
//final List<PricingProduct> offers;
  // OfferReview({super.key});
  final int id, phone, adminPhone;
  final String marketImage,
      profileImage,
      username,
      // title,
      branch,
      managerName,
      market,
      nationality;
  //marketDetails;
  final String taskType,orderBy,place;
  const OfferReview(
      {super.key,
      required this.managerName,
      required this.orderBy,
      required this.marketImage,
      required this.profileImage,
      required this.username,
      required this.branch,
      required this.market,
      required this.id,
      required this.phone,
      required this.nationality,
      // required this.marketDetails,
      required this.adminPhone,
        required this.taskType, required this.place});

  @override
  State<OfferReview> createState() => _OfferReviewState();
}

class _OfferReviewState extends State<OfferReview> {
  Color primaryColor = Colors.teal.shade900;

  Color BgroundColor = Colors.grey.shade300;

  @override
  Widget build(BuildContext context) {
    // //final Controller c = Get.put(Controller());
    // double height = MediaQuery.sizeOf(context).height;
    // double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar:AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kprimaryColor,
          title:
          MerchAppBar(
            // appBar: MerchAppBar(
            title: "Review Offers",
            manegerName: widget.managerName,
            phone: widget.phone,
            market: widget.market,
            marketImage: widget.marketImage,
            branch: widget.branch,
            username: widget.username,
            profileImage: widget.profileImage,
          ) ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: offersTaskDetails.length,
                    itemBuilder: (context, index) {
                      return getCardContainer(offersTaskDetails[index]);
                    })),


          ],
        ),
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.only(left:15.h,right:15.h,),
        child: InkWell(
            onTap: () {
             // if(doneTask==false)
              createOffersTask(PricingTask(
                place: widget.place,
               taskType: widget.taskType,
             orderBy: widget.orderBy,
                  pricingProduct: offersTaskDetails,
                  market: widget.market,
                  branch: widget.branch,
                  madeBy: widget.username,
                  taskDate: (DateFormat('yyyy-MM-dd')
                      .format(DateTime.now())
                      .toString()),
                  taskTime: (DateFormat('kk:mm')
                      .format(DateTime.now())
                      .toString()),
                  status: 'done'));

            },
            child: DefualtButton(selected: true,text: "Confirm".tr,)),
      ),
    );
  }

  getCardContainer(PricingProduct product) {
    // var Title = ["shelf","Category", s];

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        width: 320,
        height: 150,
        margin: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(style: BorderStyle.solid)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Card(
              elevation: 5,
              child: Container(
                //  margin: EdgeInsets.all(8),
                width: 130,
                decoration: BoxDecoration(
                  //color: BgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                  child:Image.network(product.images[0])
                ),
              ),
            ),
            Expanded(
              child:
                  //ListView.builder(
                  // itemCount: Title.length,
                  // itemBuilder: (BuildContext context, int index) {
                  //   return
                  Padding(
                    padding:  EdgeInsets.only(left:15.h,right: 15.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                         // alignment: A,
                          width: 180,
                            height: 40,
                            padding: EdgeInsets.all(10.h),
                            decoration: BoxDecoration(
                             // border: Border.all(),
                               color: BgroundColor,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Text(product.category)),
                        SizedBox(height: 5.h,),
                        Container(
                            width: 180,
                            height: 40,
                            padding: EdgeInsets.all(10.h),
                            decoration: BoxDecoration(
                              // border: Border.all(),
                              color: BgroundColor,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Text(product.product)),
                        SizedBox(height: 5.h,),
                        Container(
                            width: 180,
                            height: 40,
                            padding: EdgeInsets.all(10.h),
                            decoration: BoxDecoration(
                              // border: Border.all(),
                              color: BgroundColor,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Text("${product.price}")),
                      ],
                    ),
                  ),
            ),
          ]),
        ),
      ),
    );
  }

  bool doneTask = false;
  Future createOffersTask(PricingTask capturePhotos) async {
    final photoslist = FirebaseFirestore.instance.collection("Offers").doc();
    final json = capturePhotos.toMap();
    await photoslist.set(json);
    setState(() {
      doneTask = true;
    });
    if (doneTask == true) {
      completeOffersTasks.add("u kjhklhn");
      setState(() {
        offersTaskDetails=[];
      });
      Get.offAll(MerchNavBar(
          tab_index: (widget.taskType=="New Task")?1:2,
          username: widget.username,
          marketImage: widget.marketImage,
          profileImage: widget.profileImage,
          branch: widget.branch,
          market: widget.market,
          id: widget.id,
          phone: widget.phone,
          manegerName: widget.managerName,
          nationality: widget.nationality,
          mangerphone: widget.adminPhone));
    }
    //  final
  }
}
