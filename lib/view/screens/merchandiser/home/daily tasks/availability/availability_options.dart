//
//
// import 'package:arrow_merchandising/Android/components/default_button.dart';
// import 'package:arrow_merchandising/Android/splash/auth_page.dart';
// import 'package:arrow_merchandising/android/merchandiser/home/daily%20tasks/availability/availability_ai.dart';
// import 'package:arrow_merchandising/android/merchandiser/profile/profile_menu.dart';
// import 'package:arrow_merchandising/const.dart';
// import 'package:arrow_merchandising/models/availability_products.dart';
// import 'package:arrow_merchandising/models/inventory_products.dart';
// import 'package:arrow_merchandising/models/share_products.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'package:arrow_merchandising/android/merchandiser/profile/profile_pic.dart';
// import 'package:arrow_merchandising/const.dart';
// import 'package:flutter/material.dart';
//
//
// import 'package:arrow_merchandising/models/pricing_product.dart';
// import 'package:arrow_merchandising/models/rtv_product.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
//
//
// import 'all_availbility.dart';
//
// class AvailabilityOptions extends StatelessWidget {
//   final id, phone,managerPhone;
//   final String username,manegerName,
//       marketImage,
//       profileImage,
//       branch,
//       market,
//       nationality;
//   final String place;
//   const AvailabilityOptions(
//       {super.key,
//         required this.managerPhone,
//         required this.username,
//         required this.marketImage,
//         required this.profileImage,
//         required this.branch,
//         required this.market,
//         required this.id,
//         required this.phone,
//         required this.nationality, required this.place, required this.manegerName,
//       });
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:PreferredSize(
//           preferredSize: const Size.fromHeight(60),
//           child:
//           MerchandiserAppBar(
//               phone: phone,
//               profileImage: profileImage,
//               username: username
//           )),
//       body: Container(
//         child: Center(
//           child: Column(
//             children: [
//
//                Spacer(),
//           //Padding(padding: const EdgeInsets.only(left:10.0,right: 10.0,top: 200.0)),
//               MaterialButton(
//                 onPressed: (){
//                   Get.to(()=>AvailabilityWithAi(
//                   //  manegerName,manegerName,
//                     place:place,
//                     managerPhone: managerPhone,
//                     nationality: nationality,
//                     //marketDetails: widget.marketDetails,
//                     branch:branch,
//                     market:market,
//                     username:username,
//                     id: id,
//                     phone: phone,
//                     marketImage: marketImage,
//                     profileImage: profileImage, manegerName: manegerName,
//                   )
//                   );
//                 },
//                 child: Container(
//                   height: 240,
//                   width: 300,
//                   decoration: BoxDecoration(
//                       color: kprimaryColor.withOpacity(0.4),
//                       border: Border.all(),
//                       borderRadius: BorderRadius.circular(25)),
//                   child: Column(
//                     children: [
//                       Padding(padding: const EdgeInsets.only(left:10.0,right: 10.0,top: 10),
//                         child: Container(
//                           //  padding: EdgeInsets.only(top:7),
//                           height: 150,
//                           // width: 280,
//                           // decoration: BoxDecoration(
//                           //   // border: Border.all(),
//                           //     borderRadius: BorderRadius.circular(25)),
//                           child: Image.asset("assets/images/ai.jpg",
//                             height: 150,
//                             width: 280,
//                             // widget.marketImage
//                           ),
//                           //),
//                         ),
//                       ),
//
//                       Padding(
//                         padding: const EdgeInsets.only(left:20.0,right: 20.0,top: 20),
//                         child:DefualtButton(text:"Availability With AI".tr,
//                           //style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               Padding(padding: const EdgeInsets.only(left:50.0,right: 25.0,top: 40.0)),
//          // Spacer(),
//         MaterialButton(
//           onPressed: (){
//             Get.to(()=>AndroidAllAvailabilityScreen(
//               place:place,
//               managerPhone: managerPhone,
//               nationality: nationality,
//               //marketDetails: widget.marketDetails,
//               branch:branch,
//               market:market,
//               username:username,
//               id: id,
//               phone: phone,
//               marketImage: marketImage,
//               profileImage: profileImage,
//             )
//             );
//           },
//                 child: Container(
//                   height: 240,
//                   width: 300,
//                   decoration: BoxDecoration(
//                     color: kprimaryColor.withOpacity(0.4),
//                       border: Border.all(),
//                       borderRadius: BorderRadius.circular(25)),
//                   child: Column(
//                     children: [
//                       Padding(padding: const EdgeInsets.only(left:10.0,right: 10.0,top: 10),
//                         child: Container(
//                           //  padding: EdgeInsets.only(top:7),
//                         height: 150,
//                            // width: 280,
//                           // decoration: BoxDecoration(
//                           //   // border: Border.all(),
//                           //     borderRadius: BorderRadius.circular(25)),
//                           child: Image.asset("assets/images/normal av.jpeg",
//                             height: 150,
//                              width: 280,
//                             // widget.marketImage
//                           ),
//                           //),
//                         ),
//                       ),
//
//                         Padding(
//                           padding: const EdgeInsets.only(left:20.0,right: 20.0,top: 20),
//                         child:DefualtButton(text:"Normal Availability".tr,
//                             //style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//                Spacer(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
