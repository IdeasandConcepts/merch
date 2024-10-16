import 'package:arrow_merchandising/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WaitingScreen extends StatefulWidget {
  final String username;
  const WaitingScreen({Key? key, required this.username}) : super(key: key);
  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image(
                    image: AssetImage(
                      "assets/images/wt3.jpeg",
                    ),
                    height: size * 0.5),
                Text("Your request is under processing".tr +
                    "\n" +
                    "just wait".tr),
                CircularProgressIndicator(
                  color: kprimaryColor,
                ),
                SizedBox(
                  height: 80,
                )
              ],
            ))
      ]),
    );
  }
}
