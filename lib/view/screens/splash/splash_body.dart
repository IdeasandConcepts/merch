import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/models/amdinpriv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arrow_merchandising/const.dart';
import 'indicator.dart';
import 'login.dart';

class AndroidSplashBody extends StatefulWidget {
  @override
  _AndroidSplashBodyState createState() => _AndroidSplashBodyState();
}

class _AndroidSplashBodyState extends State<AndroidSplashBody>
    with TickerProviderStateMixin {
  var _sellectedIndex = 0;
  bool startAnimation = false;
  double screenHieght = 0.0;
  double screenWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 450,
            child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    _sellectedIndex = value;
                  });
                },
                itemCount: splasData.length,
                itemBuilder: (context, index) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // SizedBox(height: 80,),
                        // Spacer(),
                        Text(
                          'Shelf Pro'.tr,
                          style: TextStyle(
                            fontSize: 36,
                            color: kprimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          splasData[index]["text"],
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        Image.network(
                          splasData[index]["image"],
                          height: 200,
                          width: 235,
                        ),

                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                              splasData.length,
                              (index) => Indicator(
                                  isActive:
                                      _sellectedIndex == index ? true : false
                                  // isActive: isActive
                                  )),
                        ),
                      ]);
                }),
          ),
          InkWell(
            onTap: () {
              {
                Get.offAll(
                  () => LoginScreen(),
                );
              }
            },
            child: DefualtButton(selected: true, text: 'Start'.tr),
          ),
          //Spacer(),
        ],
      ),
    );
  }
}
