
import 'package:flutter/material.dart';
import 'package:arrow_merchandising/const.dart';

class TitleWithIcon extends StatelessWidget {
  final String title;
  final Icon icon;
  const TitleWithIcon({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(children: <Widget>[
          SizedBox(
              height: 80,
              child: icon),
          // IconButton(
          //   icon: icon,
          //   color: kprimaryColor,
          //   iconSize: 48,
          //   onPressed: () {},
          // ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: kprimaryColor),
          )
        ]),
      ),
    );
  }
}
