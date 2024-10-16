

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AndroidMerchandiserContainer extends StatelessWidget {
  final int id, phone,managerPhone;
  final String username,
      marketImage,
  branch,
      profileImage,
      market,
     // marketDetails,
      nationality;
  const AndroidMerchandiserContainer({
    super.key,
    required this.branch,
    required this.market,
    required this.username,
    required this.marketImage,
    required this.profileImage,
    required this.id,
    required this.phone,
   // required this.marketDetails,
    required this.nationality,
    required this.managerPhone
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:10.0,right:10.0,bottom: 10.0),
      child: Container(
        // decoration: BoxDecoration(
        //    // border: Border.all(),
        //     color: kprimaryColor,
        //     borderRadius: BorderRadius.only(
        //       topLeft: Radius.circular(55.0),
        //       topRight: Radius.circular(5.0),
        //       bottomRight: Radius.circular(5.0),
        //       bottomLeft: Radius.circular(55.0),
        //     ),
        //   ),
        child:
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
              // border: Border.all(),
              //color: kprimaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(55.0),
                topRight: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0),
                bottomLeft: Radius.circular(55.0),
              ),
            ),
            child: Image.asset(
"assets/images/merch.jpeg",
             // profileImage,

               height: 141.h,
              // width: 330,
             // cacheWidth: 50,
            ),
          ),
        ),
      ),
    );
  }
}
