import 'package:arrow_merchandising/view/screens/super_visor/super_drower.dart';
import 'package:arrow_merchandising/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SuperAppBar extends StatefulWidget {
  final String username,
      marketImage,
      profileImage,
      branch,
      comeFrom,
      title,
      market;

  final int phone;
  const SuperAppBar({
    super.key,
    required this.username,
    required this.marketImage,
    required this.profileImage,
    required this.branch,
    required this.market,
    required this.comeFrom,
    required this.phone,
    required this.title,
  });

  @override
  State<SuperAppBar> createState() => _SuperAppBarState();
}

class _SuperAppBarState extends State<SuperAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kprimaryColor,
      title: Text(
        widget.title.tr,
        style: TextStyle(color: Colors.white, fontSize: 20.sp),
      ),
      leading: IconButton(
          onPressed: () {
            Get.defaultDialog(
              title: "",
              content: SuperDrawerItems(
                comeFrom: widget.comeFrom,
                nationality: "",
                id: 0,
                role: "Super",
                branch: widget.branch,
                name: widget.username,
                // todaysTasks: notYetList,
                market: widget.market,
                marketImage: widget.marketImage,
                profileImage: widget.profileImage,
                phone: widget.phone,
              ),
            );
            // Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          )),
      centerTitle: true,
    );
  }
}
