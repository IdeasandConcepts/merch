import 'package:arrow_merchandising/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DefualtButton extends StatelessWidget {
  final String text;
  final bool selected;
  const DefualtButton({
    super.key,
    required this.text,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: EdgeInsets.only(top:5.h,right: 5.h,left: 5.h,bottom: 10.h),
      child: Container(
         padding: EdgeInsets.only(top:5.h,right: 5.h,left: 5.h,bottom: 10.h),
        decoration: BoxDecoration(
            color: (selected==true)?kprimaryColor:null,
            border: (selected==false)?Border.all():null,
            borderRadius: BorderRadius.circular(10)),
        width: double.infinity,
        height: 60,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color:(selected==true)? Colors.white:Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
