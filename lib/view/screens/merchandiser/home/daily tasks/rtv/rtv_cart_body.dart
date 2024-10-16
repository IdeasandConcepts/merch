

import 'package:arrow_merchandising/models/rtv_product.dart';
import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:arrow_merchandising/const.dart';


class AndroidCartItemCard extends StatefulWidget {


  const AndroidCartItemCard({
    Key? key,
    required this.merchTask,
    required this.index,

  }) : super(key: key);

  final RTVProduct merchTask;
  final int index;


  @override
  State<AndroidCartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<AndroidCartItemCard> {

  TextEditingController productCount_Controller = TextEditingController();
  late int productCounts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productCounts = widget.merchTask.prAmount;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  // final String place;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
      decoration: BoxDecoration(
        color: kprimaryColor,
        //Colors.green,
        borderRadius: BorderRadius.circular(26),

      ),
      child: Row(
        children: [
          // SizedBox(
          //   width: 88,
          //   child: AspectRatio(
          //       aspectRatio: 0.88,
          //       child: Container(
          //         decoration: BoxDecoration(
          //             color: Color(0xFFF5F6F9),
          //             borderRadius: BorderRadius.circular(15)),
          //         child: Image.asset(merchTask.imagAssets),
          //       )),
          // ),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.merchTask.product,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
                maxLines: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Get.defaultDialog(
                          title: "",
                          content: Column(
                            children: <Widget>[
                              TextFormField(
                                  controller: productCount_Controller,
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: false, signed: false),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(color: kTextColor),
                                      // floatingLabelBehavior: FloatingLabelBehavior.always,
                                    ),
                                    labelText: 'Rtv Quantity'.tr,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Can't Be Empty".tr;
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    //productCounts = int.parse(value);
                                    productCounts =
                                        int.parse(productCount_Controller.text
                                            .trim());
                                  },
                                  onSaved: (newValue) {
                                    //productCounts = int.parse(newValue!);
                                    productCounts =
                                        int.parse(productCount_Controller.text
                                            .trim());
                                    // productCount_Controller =p;
                                    //avaliable = !avaliable;
                                  }),
                              Divider(
                                color: Colors.black,
                              ),
                              InkWell(
                                child: DefualtButton( selected: true,text: "Update".tr),
                                onTap: () async {
                                  setState(() {
                                   // if(rTVTaskDetails)

                                    if (!rTVTaskDetails.contains(
                                        RTVProduct(
                                          rType: widget.merchTask.rType,
                                            barCode: widget.merchTask.barCode,
                                            prCategory: widget.merchTask.prCategory,
                                            product: widget.merchTask.product,
                                            prAmount: widget.merchTask.prAmount,
                                            image: widget.merchTask.image
                                        ))) {
                                      rTVTaskDetails.removeAt(widget.index);
                                      rTVTaskDetails.add(RTVProduct(
                                       // image:
                                         rType:  widget.merchTask.rType,
                                          barCode: widget.merchTask.barCode,
                                          prCategory: widget.merchTask
                                              .prCategory,
                                          product: widget.merchTask.product,
                                          prAmount: productCounts,
                                          image: widget.merchTask.image
                                      ));
                                    }

                                  });

                                  productCount_Controller.clear();
                                  Get.back();
                                },
                              )
                            ],
                          ));
                    },
                    child: Text.rich(TextSpan(
                        text: "Return Quantity".tr+":"+"\t${productCounts}"+"\t\t\t",
                        style: TextStyle(color: Colors.amber,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        children: [
                          TextSpan(
                            text:  "Category".tr+":"+"\t" + widget.merchTask
                                .prCategory,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          )
                        ])),
                  ),
                ),
              )
              //    )
            ],
          )
        ],
      ),
    );
  }

}
