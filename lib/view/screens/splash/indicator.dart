import 'package:arrow_merchandising/const.dart';
import 'package:flutter/material.dart';






class Indicator extends StatelessWidget {
  final bool isActive;
  const Indicator({super.key, required this.isActive});
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      //kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: isActive ? 20 : 8,
      decoration: BoxDecoration(
        color: isActive ? kprimaryColor : Color.fromARGB(255, 168, 212, 218),
        borderRadius: BorderRadius.circular(3),
      ),
    );
    // throw UnimplementedError();
  }
}
