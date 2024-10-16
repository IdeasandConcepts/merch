
import 'package:arrow_merchandising/const.dart';
import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  final String imageAssets;
  const ProfilePic({
    super.key,
    required this.imageAssets,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: [
        buildImage(),
        Positioned(bottom: 45, right: 4, child: buildEditIcon(kprimaryColor)),
        //Positioned(bottom: 45, right: 4, child: buildCircle(kprimaryColor)),

      ]),

      //buildImage()
    );
  }

  Widget buildEditIcon(Color color) =>

        // color: kprimaryColor,
        // // Colors.white,
        // all: 3,
       // child:
  Container(
          child: Icon(
            Icons.edit,
            size:12,
         // ),
         // all: 3,
         // color: Colors.white,
        ),
      );

  // Widget buildCircle({
  //   //required Widget child,
  //  // required double all,
  //   //required Color color,
  // }) =>
  //     ClipOval(
  //       child: Container(
  //         padding: EdgeInsets.all(all),
  //         child: child,
  //         color: color,
  //       ),
  //     );

  Widget buildImage() {
    return ClipOval(
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: Colors.transparent,
       // child: Image.network(
          //imageAssets,
          // File
          //   File(),
       //  width:70,
         //double.maxFinite-400,
         //  height: 50,
         //  width: 50,
         // fit: BoxFit.cover,
          child: Ink.image(
            image: NetworkImage(imageAssets),
            fit: BoxFit.cover,
            height: 40,
            width: 40,
          // ),
        ),
      ),
    );
  }
}
