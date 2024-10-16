import 'package:arrow_merchandising/const.dart';
import 'package:arrow_merchandising/models/inventory_products.dart';
import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class InventoryProductWidget extends StatefulWidget {

  final  InventoryProduct merchTask;

  const  InventoryProductWidget({
    required this.merchTask,
    Key? key,

  }) : super(key: key);

  @override
  State<InventoryProductWidget> createState() => _InventoryProductWidgetState();
}

class _InventoryProductWidgetState extends State<InventoryProductWidget> {

  TextEditingController productCount_Controller = TextEditingController();
  late int productCounts;
//  int lastCount=1;

@override
  void initState() {
    // TODO: implement initState
  imageSrc=widget.merchTask.image;
  readImageFromFirebase(widget.merchTask.weight,widget.merchTask.product);
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 364.w,
      height: 62.h,
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
          color: const Color(0xffEEEEEE),
          borderRadius: BorderRadius.circular(10.r)),
      child: Row(

        children: [
          Image.network(
            imageSrc,
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
    onTap:(){
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
    labelText: 'Quantity'.tr,
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
    widget.merchTask.prAmount=productCounts;

    });
    productCount_Controller.clear();
    Get.back();
    },
    )
    ],
    ));
    },
                child: Text(
                  ( widget.merchTask.prAmount>0)?'${ widget.merchTask.prAmount}':"1",
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
  late String imageSrc;
 Future<String> readImageFromFirebase(int weight,String product) async{
   await FirebaseFirestore.instance
       .collection("arrow_products")
   .where("weight",isEqualTo: weight)
   .where("product_name",isEqualTo: product)
      // .orderBy("id", descending: false)
       .limit(700)
       .get()
       .then((snapshot) {
     snapshot.docs.forEach((element) {
       FirebaseFirestore.instance
           .collection("arrow_products")
       //.where(field)
           .doc(element.reference.id)
           .get()
           .then((value) {
         Map<String, dynamic> data = value.data() as Map<String, dynamic>;
         // for (int i = 0; i < data.length; i++) {

           setState(() {
             imageSrc=(data['photo']);
           });
           //  });
        // }
         // }
       });
     });
   });
    return imageSrc;
  }
}