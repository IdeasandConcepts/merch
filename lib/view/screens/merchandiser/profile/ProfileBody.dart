import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileBody extends StatelessWidget {
  final String  marketImage, branch, market,
  nationality,
  username,
  profileImage;
  final int
  id,
  phone,
  mangerPhone;

  const ProfileBody(
      {super.key,

      required this.marketImage,
      required this.branch,
      required this.market,
  required this.nationality,
  required this.username,
  required this.profileImage,
  required this.id,
  required this.phone,
  required this.mangerPhone,});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        child: Container(
        child: ListView(
        shrinkWrap: true,
       // controller: _scrollController,
        children: [

               Container(
       padding: EdgeInsets.all(10.0),
       width: MediaQuery.of(context).size.width-10,
       // height: MediaQuery.of(context).size.height -560,
       //height: 300,
       // padding: EdgeInsets.only(top: 5),
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(15),
         //border: Border.all()
       ),
       child: Stack(
           children: <Widget>[
             Container(
               height: 50,
               width: 50,
               //color: kprimaryColor.withOpacity(0.5),
             ),
             // Positioned(
             //   bottom: 20,
             //   right: 150,
             //   //bottom: 500,
             //   left: 150,
             //   top: 20,
             //   child: Container(
             //     height: 50,
             //     // width: 200,
             //     decoration: BoxDecoration(
             //       borderRadius: BorderRadius.circular(25),
             //       // color: kTextColor.withOpacity(0.3)
             //     ),
             //   ),
             // ),
             Positioned(
               bottom: 20,
               left: 50,
               top: 20,
               right: 250,
               child: Container(
                 height: 80,
                 width: 80,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(25),
                   // color: kprimaryColor.withOpacity(.3)
                 ),
               ),
             ),

             //
             // Positioned(
             //   bottom: 120,
             //   right: 10,
             //   //bottom: 500,
             //   left: 120,
             //   top: 120,
             //   child: Container(
             //     height: 50,
             //     width: 100,
             //     decoration: BoxDecoration(
             //         borderRadius: BorderRadius.circular(25),
             //         //color: kTextColor.withOpacity(0.3)
             //     ),
             //     child:    ClipOval(
             //       //clipBehavior: Clip.hardEdge,
             //       child:
             //       Material(
             //         color: Colors.transparent,
             //         child: Ink.image(
             //           image: NetworkImage(profileImage),
             //           fit: BoxFit.cover,
             //           height: 50,
             //           width: 50,
             //           // ),
             //         ),
             //       ),
             //     ),
             //   ),
             // ),
             Container(
               height: 80,
               width: 80,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(25),
                 //color: kTextColor.withOpacity(0.3)
               ),
               child:    ClipOval(
                 //clipBehavior: Clip.hardEdge,
                 child:
                 Material(
                   color: Colors.transparent,
                   child: Ink.image(
                     image: NetworkImage(profileImage),
                     fit: BoxFit.cover,
                     height: 40,
                     width: 40,
                     // ),
                   ),
                 ),
               ),
             ),
             // Positioned(
             //   bottom: 20,
             //   left: 50,
             //   top: 20,
             //   right: 250,
             //   child: Container(
             //     height: 150,
             //     //width: 0,
             //     decoration: BoxDecoration(
             //       borderRadius: BorderRadius.circular(25),
             //        color: kprimaryColor.withOpacity(.3)
             //     ),
             //   ),
             // ),
           ]),
               ),
          ListTile(
            // leading: const Icon(Icons.person_pin_sharp),
            title: Text(
              username,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
          Divider(
            height: 0.1,
            color: Colors.black45,
          ),
          // Phone Number
          ListTile(
            // leading: GestureDetector(
            //       onTap: () {
            //       },
            //       child: const Icon(Icons.edit)),
            title: Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Id".tr.toUpperCase()+"\t\t"+":"+"\t\t\t",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                GestureDetector(
                  onTap: () {
                    // UrlLauncher.launch(
                    //     'tel:+ 966 ${widget.merchPhone.toString()}');
                    // launch("tel://21213123123"),
                  },
                  child: Text(
                    '${id}',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                )
              ],
            ),
          ),
          //           // labelText: 'id',
          Divider(
            height: 0.1,
            color: Colors.black45,
          ),
          ListTile(
            // leading: InkWell(
            //     onTap: () {
            //     },
            //     child: const Icon(Icons.account_balance)),
            title: Text(
              "Market".tr + " : " + market,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),

          Divider(
            height: 0.1,
            color: Colors.black45,
          ),   ListTile(
            // leading: InkWell(
            //     onTap: () {
            //     },
            //     child: const Icon(Icons.account_balance)),
            title: Text(
              "Branch".tr + " : " + branch,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),

          Divider(
            height: 0.1,
            color: Colors.black45,
          ),
          // Nationality
          ListTile(
            title: Text(
              "Nationality".tr +
                  " : " +
                  nationality,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),

          ),
          Divider(
            height: 0.1,
            color: Colors.black45,
          ),

               //  ],
               //),
             ],
          ),
          // SizedBox(height: 10,),
          // Container(
          //   height: 80,
          //   width: 60,
          //   child: ClipOval(
          //       child: Image.network(widget.merchProfileImage)),
          // ),
          //NetworkImage(widget.merchandiser.profileImage),
      //fit: BoxFit.cover,
          //height: 100,
      //width: 75,
          // ),
          //SizedBox(height: 10,),
          // ListTile(
          //  // leading: const Icon(Icons.person_pin_sharp),
          //   title: Text(
          //     username,
          //     style: TextStyle(
          //           color: Colors.black,
          //           fontWeight: FontWeight.bold,
          //           fontSize: 14),
          //   ),
          // ),
          // Divider(
          //   height: 0.1,
          //   color: Colors.black45,
          // ),
          // // Phone Number
          // ListTile(
          //   // leading: GestureDetector(
          //   //       onTap: () {
          //   //       },
          //   //       child: const Icon(Icons.edit)),
          //   title: Row(
          //     // mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //         Text(
          //           "Id".tr.toUpperCase()+"\t\t"+":"+"\t\t\t",
          //           style: TextStyle(
          //               color: Colors.black,
          //               fontWeight: FontWeight.bold,
          //               fontSize: 14),
          //         ),
          //         GestureDetector(
          //           onTap: () {
          //             // UrlLauncher.launch(
          //             //     'tel:+ 966 ${widget.merchPhone.toString()}');
          //             // launch("tel://21213123123"),
          //           },
          //           child: Text(
          //             '${id}',
          //             style: TextStyle(
          //                 color: Colors.blue,
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: 14),
          //           ),
          //         )
          //     ],
          //   ),
          // ),
          // //           // labelText: 'id',
          // Divider(
          //   height: 0.1,
          //   color: Colors.black45,
          // ),
          // ListTile(
          //   // leading: InkWell(
          //   //     onTap: () {
          //   //     },
          //   //     child: const Icon(Icons.account_balance)),
          //   title: Text(
          //     "Market".tr + " : " + market,
          //     style: TextStyle(
          //         color: Colors.black,
          //         fontWeight: FontWeight.bold,
          //         fontSize: 14),
          //   ),
          // ),
          //
          // Divider(
          //   height: 0.1,
          //   color: Colors.black45,
          // ),   ListTile(
          //   // leading: InkWell(
          //   //     onTap: () {
          //   //     },
          //   //     child: const Icon(Icons.account_balance)),
          //   title: Text(
          //     "Branch".tr + " : " + branch,
          //     style: TextStyle(
          //         color: Colors.black,
          //         fontWeight: FontWeight.bold,
          //         fontSize: 14),
          //   ),
          // ),
          //
          // Divider(
          //   height: 0.1,
          //   color: Colors.black45,
          // ),
          // // Nationality
          // ListTile(
          //   title: Text(
          //     "Nationality".tr +
          //           " : " +
          //           nationality,
          //     style: TextStyle(
          //           color: Colors.black,
          //           fontWeight: FontWeight.bold,
          //           fontSize: 14),
          //   ),
          //
          // ),
          // Divider(
          //   height: 0.1,
          //   color: Colors.black45,
          // ),

          // car serial number
          // ListTile(
          //   leading: GestureDetector(
          //       child: const Icon(Icons.car_rental_rounded)),
          //   title: Text(
          //     "Has a car".tr +
          //         " : " +
          //         widget.merchcarDetails,
          //     style: TextStyle(
          //         color: Colors.black,
          //         fontWeight: FontWeight.bold,
          //         fontSize: 14),
          //   ),
          // ),
      //   ],
      // ),

            ),
      ),
    );
  }
}
