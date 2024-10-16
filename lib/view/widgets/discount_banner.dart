import 'package:arrow_merchandising/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      height: 100,
      width: //180,
          double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              colors: [
                kTextColor,
                // kActiveIconColor,
                kprimaryColor,
              ])),
      child: Text.rich(TextSpan(
          text: "SummerCuts".tr + "\n",
          style: TextStyle(color: Colors.white),
          children: [
            TextSpan(
                text: '30% cuts'.tr,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
          ])),
    );
  }
}
