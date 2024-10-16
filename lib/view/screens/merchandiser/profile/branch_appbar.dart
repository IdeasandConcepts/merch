import 'package:arrow_merchandising/view/screens/merchandiser/profile/profile_screen.dart';
import 'package:arrow_merchandising/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MerchAppBar extends StatefulWidget {
  final String username,manegerName, marketImage,
         profileImage, branch, title, market;
  final int  phone;
  const MerchAppBar(
      {super.key,
        required this.username,
        required this.marketImage,
        required this.profileImage,
        required this.branch,
        required this.market,
        required this.phone,
        required this.manegerName,
        required this.title,
      });

  @override
  State<MerchAppBar> createState() => _MerchAppBarState();
}

class _MerchAppBarState extends State<MerchAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kprimaryColor,
      title:  Text(widget.title.tr.toUpperCase(),style: TextStyle(color: Colors.white,fontSize: 20.sp),),
      leading:
      IconButton(
          onPressed: (){
            Get.defaultDialog(
              title: "",
              content: MerchDrawerItems(
              branch: widget.branch,
              name: widget.username,
              market: widget.market,
              profileImage: widget.profileImage,
              phone: widget.phone,
                        ),
            );
          },
          icon:Icon(Icons.menu,color: Colors.white,)
      ),

      centerTitle: true,
    );
  }
}
