//
//
// import 'package:arrow_merchandising/Android/components/default_button.dart';
// import 'package:arrow_merchandising/android/merchandiser/home/daily%20tasks/availability/availability_ai.dart';
// import 'package:arrow_merchandising/android/merchandiser/home/daily%20tasks/shareofshalfs/sh_with_ai.dart';
// import 'package:arrow_merchandising/android/merchandiser/home/daily%20tasks/shareofshalfs/share_of_shalfs.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
//
// class ShareOfShelvesOptions extends StatelessWidget {
//   final id, phone,managerPhone;
//   final String username,
//       marketImage,
//       profileImage,
//       branch,
//       market,
//       nationality;
//   final String place;
//   const ShareOfShelvesOptions(
//       {super.key,
//         required this.managerPhone,
//         required this.username,
//         required this.marketImage,
//         required this.profileImage,
//         required this.branch,
//         required this.market,
//         required this.id,
//         required this.phone,
//         required this.nationality, required this.place,
//       });
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Container(
//           //height: 400,
//           child: Center(
//             child: Column(
//               children: [
//                 Spacer(),
//                 GestureDetector(
//                   onTap: (){
//                     Get.to(()=>ShareWithAi(
//                       product:"All Products",
//                       adminPhone: managerPhone,
//                       nationality: nationality,
//                       //marketDetails: widget.marketDetails,
//                       branch:branch,
//                       market:market,
//                       username:username,
//                       id: id,
//                       phone: phone,
//                       marketImage: marketImage,
//                       profileImage: profileImage,
//                     )
//                     );
//                   },
//                   child: DefualtButton(text: ("Share Of Shelves With AI")),
//                 ),
//                 Spacer(),
//
//                 MaterialButton(
//                     onPressed: (){
//                       Get.to(()=>ShareOfShelves(
//                         product:"All Products",
//                         adminPhone: managerPhone,
//                         nationality: nationality,
//                         //marketDetails: widget.marketDetails,
//                         branch:branch,
//                         market:market,
//                         username:username,
//                         id: id,
//                         phone: phone,
//                         marketImage: marketImage,
//                         profileImage: profileImage,
//                       )
//                       );
//                     },
//                     child: DefualtButton(text: "Normal Share Of Shelves")),
//                 Spacer(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
