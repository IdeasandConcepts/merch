import 'package:arrow_merchandising/const.dart';
import 'package:arrow_merchandising/models/rtv_product.dart';
import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class RTVProductWidget extends StatefulWidget {

 final  RTVProduct merchTask;

const  RTVProductWidget({
    required this.merchTask,
    Key? key,
  }) : super(key: key);

  @override
  State<RTVProductWidget> createState() => _RTVProductWidgetState();
}

class _RTVProductWidgetState extends State<RTVProductWidget> {

TextEditingController productAmountController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62.h,
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
          color: const Color(0xffEEEEEE),
          borderRadius: BorderRadius.circular(10.r)),
      child: Row(
        children: [
          Image.network(
widget.merchTask.image,
            height: 60.h,
            width: 55.w,
          ),
          const Spacer(flex: 2,),
          Text(
            widget.merchTask.product,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
                color: const Color(0xff7B7878)),
          ),
          const Spacer(),
          Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    widget.merchTask.prAmount--;
                    if( widget.merchTask.prAmount<0)
                      widget.merchTask.prAmount=1;
                  });
                },
                borderRadius: BorderRadius.circular(20.r),
                child: Container(
                  height: 30.h,
                  width: 30.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: Colors.white,
                  ),
                  child: const Icon(Icons.remove),
                ),
              ),
              SizedBox(width: 10.w),
              GestureDetector(
                onTap: (){
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
                                    labelText: 'Quantity'.tr,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Can't Be Empty".tr;
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    widget.merchTask.prAmount = int.parse(value);
                                    widget.merchTask.prAmount  =
                                        int.parse(productAmountController.text
                                            .trim());
                                  },
                                  onSaved: (newValue) {
                                    widget.merchTask.prAmount = int.parse(newValue!);
                                    widget.merchTask.prAmount  =
                                        int.parse(productAmountController.text
                                            .trim());
                                  }),
                              Divider(
                                color: Colors.black,
                              ),
                              InkWell(
                                child: DefualtButton(selected:true,text: "Update".tr),
                                onTap: () async {
                                  setState(() {

                                    widget.merchTask.prAmount  =
                                        int.parse(productAmountController.text
                                            .trim());
                                  });
                                  productAmountController.clear();
                                  Get.back();
                                },
                              )
                            ],
                          ));
                },
                child: Text(
                  ( widget.merchTask.prAmount==1)?"1":'${ widget.merchTask.prAmount}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              InkWell(
                onTap: () {
                setState(() {
                  widget.merchTask.prAmount++;
                });
                },
                borderRadius: BorderRadius.circular(20.r),
                child: Container(
                  height: 30.h,
                  width: 30.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: Colors.white,
                  ),
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}