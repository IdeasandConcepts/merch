


import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/const.dart';
import 'package:arrow_merchandising/models/availability_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';


class CartItemCard extends StatefulWidget {
  const CartItemCard({
    Key? key,
    required this.merchTask,
    required this.comefrom,
  }) : super(key: key);

  final AvailabilityProduct merchTask;
  final String comefrom;
  //final int index;

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  TextEditingController productAmountController=TextEditingController();
  int productAmount=0;
   String  status="", Available= "Available",LowStock= "Low Stock",HighStock="High Stock";
  //   "High Stock",
  //   "Low Stock", = "";
  // var items = [
  //   "Available",
  //   "High Stock",
  //   "Low Stock",
  // ];
  //
  // bool switchValue = false;
  //
  // orderByChange(String orderByStr) {
  //   setState(() {
  //     orderBy = orderByStr;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height:95.h,

      // padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        //Colors.green,
        borderRadius: BorderRadius.circular(10.h),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SizedBox(
          //   width: 10.h,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(top:10.h),
                          child: Image.network(
                            widget.merchTask.image,
                            width: 60.h,
                            height: 46.h,
                          ),
                        ),
                        Text(widget.merchTask.product)
                      ],
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top:5.h),
                      child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                         // crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                           Row(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Padding(
                                 padding:  EdgeInsets.only(left:10.h,right: 10.h),
                                 child: GestureDetector(
                                   onTap: () {
                                     Get.defaultDialog(
                                         title: "",
                                         content: Column(
                                           children: <Widget>[
                                             TextFormField(
                                                 controller: productAmountController,
                                                 keyboardType: TextInputType.numberWithOptions(
                                                     decimal: false, signed: false),
                                                 decoration: InputDecoration(
                                                   border: OutlineInputBorder(
                                                     borderRadius: BorderRadius.circular(20),
                                                     borderSide: BorderSide(color: kTextColor),
                                                     // floatingLabelBehavior: FloatingLabelBehavior.always,
                                                   ),
                                                   labelText: 'Status'.tr,
                                                 ),
                                                 validator: (value) {
                                                   if (value!.isEmpty) {
                                                     return "Can't Be Empty".tr;
                                                   }
                                                   return null;
                                                 },
                                                 onChanged: (value) {
                                                   setState(() {
                                                     productAmount=int.parse(value);
                                                     status = "High Stock";
                                                   });
                                                   //   widget.merchTask.status = '${productAmountController.text}';

                                                 },
                                                 onSaved: (newValue) {
                                                   setState(() {
                                                     productAmount=int.parse(newValue!);
                                                     status = "High Stock";
                                                   });

                                                   //   widget.merchTask.status = '${productAmountController.text}';

                                                 }),
                                             Divider(
                                               color: Colors.black,
                                             ),
                                             InkWell(
                                               child: DefualtButton(selected:true,text: "Update".tr),
                                               onTap: () async {
                                                 setState(() {
                                                   if(productAmount>5) {
                                                     status = "High Stock";
                                                     widget.merchTask.prAmount =productAmount;
                                                     productAmountController.clear();
                                                   }
                                                   else{}
                                                 });

                                                 Get.back();
                                               },
                                             )
                                           ],
                                         ));
                                     // setState(() {
                                     //
                                     //   widget.merchTask.status= "High Stock";
                                     // });

                                     // c.isSelectCat[0]=!c.isSelectCat[0];
                                   },
                                   child: Container(
                                     height: 30.h,
                                     width: (widget.comefrom!="AI")?90.w:140,
                                     decoration: BoxDecoration(
                                         border: Border.all(
                                             style: BorderStyle.solid),
                                         borderRadius:
                                         BorderRadius.circular(5),
                                         color: (widget.merchTask.prAmount>5)
                                             ? kprimaryColor
                                             : Colors.white),
                                     child: Center(
                                         child: Text(
                                           // (status ==
                                            //    "High Stock".tr,
                                           (widget.merchTask.prAmount>5)?
                                           "${widget.merchTask.prAmount}":"High Stock",
                                           style: TextStyle(
                                               fontSize: 12.sp,color:  (widget.merchTask.prAmount  >5)? Colors.white:Colors.black),
                                         )),

                                   ),
                                 ),
                               ),
                               Padding(
                                 padding:  EdgeInsets.only(left:10.h,right: 10.h),
                                 child: GestureDetector(
                                   onTap: () {
                                     Get.defaultDialog(
                                         title: "",
                                         content: Column(
                                           children: <Widget>[
                                             TextFormField(
                                                 controller: productAmountController,
                                                 keyboardType: TextInputType.numberWithOptions(
                                                     decimal: false, signed: false),
                                                 decoration: InputDecoration(
                                                   border: OutlineInputBorder(
                                                     borderRadius: BorderRadius.circular(20),
                                                     borderSide: BorderSide(color: kTextColor),
                                                     // floatingLabelBehavior: FloatingLabelBehavior.always,
                                                   ),
                                                   labelText: 'Status'.tr,
                                                 ),
                                                 validator: (value) {
                                                   if (value!.isEmpty) {
                                                     return "Can't Be Empty".tr;
                                                   }
                                                   return null;
                                                 },
                                                 onChanged: (value) {
                                                   // widget.merchTask.status = '${productAmountController.text}';
                                                   productAmount=int.parse(value);
                                                 },
                                                 onSaved: (newValue) {
                                                   productAmount=int.parse(newValue!);

                                                 }),
                                             Divider(
                                               color: Colors.black,
                                             ),
                                             InkWell(
                                               child: DefualtButton(selected:true,text: "Update".tr),
                                               onTap: () async {
                                                 setState(() {
                                                   if(productAmount<=5&&productAmount>0) {
                                                     status = "Low Stock";
                                                     widget.merchTask.prAmount = productAmount;
                                                     //'${productAmountController.text}';

                                                     productAmountController.clear();
                                                   }
                                                   else{
                                                     productAmountController.clear();
                                                   }
                                                 });

                                                 Get.back();
                                               },
                                             )
                                           ],
                                         ));
                                     // setState(() {
                                     //   status="Low Stock";
                                     //   widget.merchTask.status= "Low Stock";
                                     // });
                                   },
                                   child: Container(
                                     height: 30.h,
                                     width: (widget.comefrom!="AI")?90.w:140,
                                     child: Center(
                                         child:
                                         Text(
                                           // (status ==
                                              // "Low Stock",
                                           (widget.merchTask.prAmount<=5
                                             //  ||widget.merchTask.prAmount<5
                                           )
                                               && status=="Low Stock"
                                               ?"${widget.merchTask.prAmount}":"Low Stock",
                                           style: TextStyle(fontSize: 12.sp,color:
                                           (widget.merchTask.prAmount<=5)
                                               && status=="Low Stock"
                                              ?  Colors.white:Colors.black),
                                         )),
                                     decoration: BoxDecoration(
                                         border: Border.all(
                                             style: BorderStyle.solid),
                                         borderRadius:
                                         BorderRadius.circular(5),
                                         color: (widget.merchTask.prAmount<=5&&status=="Low Stock")
                                             //&& status=="Low Stock"
                                             ? kprimaryColor
                                             : Colors.white

                                       //c.isSelectCat[1]?primaryColor:Colors.white,
                                     ),
                                   ),
                                 ),
                               ),
                             ],
                           ),
                            if(widget.comefrom!="AI")
                            Padding(
                              padding:  EdgeInsets.only(left:10.h,right: 10.h),
                              child: GestureDetector(
                                onTap: () {
                               //   '${(widget.availability.availabilityProduct[i].prAmount>5)?
                                 // "High Stock":"Low Stock"}',
                                  setState(() {
                                    status="Not Available";
                                    widget.merchTask.prAmount=0;
                                      // {
                                      //   status= "Not Available";
                                      // }
                                  });
                                },
                                child: Container(
                                  height: 30.h,
                                  width: 90.w,
                                  child: Center(
                                      child: Text(
                                        "Not Available",
                                        style: TextStyle(fontSize: 12.sp,color:
    (status  ==
    "Not Available")?  Colors.white:Colors.black),),
                                      ),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          style: BorderStyle.solid),
                                      borderRadius:
                                      BorderRadius.circular(5),
                                      color: (status ==
                                          "Not Available")
                                          ? kprimaryColor
                                          : Colors.white),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ]),
              // Center(
              //   child: Text("Category".tr+":"+'${widget.merchTask.prCategory}',
              //       style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),
              //
              //   )
              // //),
              // ),
            ],
          )
        ],
      ),
    );
  }
}
