
import 'package:arrow_merchandising/models/availability_products.dart';
import 'package:arrow_merchandising/models/inventory_products.dart';
import 'package:arrow_merchandising/models/share_products.dart';
import 'package:arrow_merchandising/view/screens/merchandiser/profile/profile_pic.dart';
import 'package:arrow_merchandising/const.dart';
import 'package:arrow_merchandising/controller/localization_and_theme/changelocal_and_theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:arrow_merchandising/models/pricing_product.dart';
import 'package:arrow_merchandising/models/rtv_product.dart';
import 'package:get/get.dart';



class MerchandiserAppBar extends GetView<LocaleAndThemeController> {
  const MerchandiserAppBar({
    super.key,
    required this.phone,
    required this.profileImage,
    required this.username,
  });

  final int phone;
  final String profileImage;
  final String username;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
     backgroundColor: kprimaryColor,
     // backgroundColor: Colors.transparent,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ProfilePic(
            imageAssets: profileImage,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top:10),
          //   child: Column(
          //     //crossAxisAlignment: CrossAxisAlignment.start,
          //     children: <Widget>[
          //
          //       Text(
          //         username,
          //         style: TextStyle(
          //           fontSize: 15, fontWeight: FontWeight.bold,
          //           // color: Colors.black
          //           //fontFamily: PdfGoogleFonts.alefBold()
          //         ),
          //       ),
          //       SizedBox(
          //         height: 8,
          //       ),
          //       Text(
          //         '${phone}',
          //         style: TextStyle(
          //           fontSize: 15,
          //           // color: Colors.black.withOpacity(0.7)
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          //
          // SizedBox(
          //     width:5
          // ),
          // if((
          //     workingOnRtv+
          //     workingOnInventory.length+
          //     workingOnRtv.length+
          //     workingOnShelve.length+
          //     workingOnPricing.length)>0)
          if(
          workingOnInventory.length>0
              ||
              workingOnAvailability.length>0
              ||
              workingOnShare.length>0
              ||
              workingOnOffers.length>0
              ||
              workingOnRtv.length>0
          )
            GestureDetector(
              onTap:(){
               // if(
               // workingOnPricing.length>0)
                 //  if(
                 // // workingOn.length>0
                 //  )
                Get.defaultDialog(
                  title:  'Details'.tr,
                  content: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 15,
                          left: 15,
                        ),
                        child: Container(
                          //padding: EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                                color: kprimaryColor.withOpacity(0.45),
                                borderRadius:
                                // border: BorderRadius.circular(15)
                                // border
                                BorderRadius.circular(15)),

                            child: DataTable(dataTextStyle: TextStyle(fontSize: 20),
                                //showBottomBorder: true,
                                //border: TableBorder.all(),
                                //columnSpacing: 12,
                                columns: [
                                  DataColumn(
                                      label: Text(
                                        'Task'.tr.toUpperCase(),
                                        style: const TextStyle(fontSize: 10,color: Colors.black87),
                                      )),
                                  DataColumn(
                                      label: Text(
                                        "",
                                        style: const TextStyle(fontSize: 10,color: Colors.black87),
                                      )),
                                ], rows: [
                                  if(workingOnRtv.length>0)
                                    DataRow(cells: <DataCell>[
                                      DataCell(Text(
                                        'RTV Section'.tr.toUpperCase(),
                                        style: const TextStyle(fontSize: 10,color: Colors.black87),
                                      )),
                                      DataCell(Text(
                                        '${''}',
                                        style: const TextStyle(fontSize: 10,color: Colors.black87),
                                      )),
                                    ]),
                                  if(workingOnInventory.length>0)
                                    DataRow(cells: <DataCell>[
                                      DataCell(Text(
                                        'Inventory'.tr.toUpperCase(),
                                        style: const TextStyle(fontSize: 10,color: Colors.black87),
                                      )),
                                      DataCell(Text(
                                        '${''}',
                                        style: const TextStyle(fontSize: 10,color: Colors.black87),
                                      )),
                                    ]),
                                  if(workingOnAvailability.length>0)
                                    DataRow(cells: <DataCell>[
                                      DataCell(Text(
                                        'Availability'.tr.toUpperCase(),
                                        style: const TextStyle(fontSize: 10,color: Colors.black87),
                                      )),
                                      DataCell(Text(
                                        '${''}',
                                        style: const TextStyle(fontSize: 10,color: Colors.black87),
                                      )),
                                    ]),
                                  if(workingOnShare.length>0)
                                    DataRow(cells: <DataCell>[
                                      DataCell(Text(
                                        'Share Of Shelves'.tr.toUpperCase(),
                                        style: const TextStyle(fontSize: 10,color: Colors.black87),
                                      )),
                                      DataCell(Text(
                                        '${''}',
                                        style: const TextStyle(fontSize: 10,color: Colors.black87),
                                      )),
                                    ]),
                                  if(workingOnOffers.length>0)
                                    DataRow(cells: <DataCell>[
                                      DataCell(Text(
                                        'Pricing'.tr.toUpperCase(),
                                        style: const TextStyle(fontSize: 10,color: Colors.black87),
                                      )),
                                      DataCell(Text(
                                        '${''}',
                                        style: const TextStyle(fontSize: 10,color: Colors.black87),
                                      )),
                                    ]),

                                  // )
                                ]
                            )
                        ),

                      )
                  ),
                );
              },
              child: Padding(
                  padding: const EdgeInsets.only(left:5.0,right: 5.0),
                  child:   Container(
                    margin: EdgeInsets.only(left: 35),
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                        //  color:task.status=="run"? Colors.amber:kprimaryColor.withOpacity(0.45),
                        //color:kprimaryColor,
                        border: Border.all(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 1.0
                        )

                    ),
                    child: Center(child: Text(
                        '${
                            workingOnAvailability.length+
                                workingOnInventory.length+
                                workingOnRtv.length+
                                workingOnShare.length+
                                workingOnOffers.length

                        }')),
                  )
              ),
            ),
          // SizedBox(width: 5,),
          // InkWell(
          //   onTap: (){
          //     refreshFun();
          //     Get.offAll(()=>
          //        MerchNavBar(
          //
          //            //username: username, marketImage: marketImage, profileImage: profileImage, branch: branch, market: market, id: id, phone: phone, nationality: nationality, mangerphone: mangerphone)
          //        // MerchandiserHome(
          //           username: widget.username,
          //           id: widget.id,
          //           phone: widget.phone,
          //           marketImage: widget.marketImage,
          //           profileImage: widget.profileImage,
          //           // city: city,
          //           //marketDetails: widget.marketDetails,
          //           nationality: widget.nationality,
          //           market: widget.market,
          //           // user: username,
          //           branch: "All Branches",
          //           mangerphone:widget.mangerphone,
          //         )
          //     );
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.only(top:10.0),
          //     child: Column(
          //       //crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Icon(Icons.home),
          //         // SizedBox(height: 8,),
          //         Text("Home".tr,
          //           style: TextStyle(
          //               fontSize: 15,
          //               color: Colors.black.withOpacity(0.7)
          //           ),),
          //       ],
          //     ),
          //   ),
          // ),
          SizedBox(
            width:10,
          ),
          // GestureDetector(
          //   child: Padding(
          //     padding: const EdgeInsets.only(top:10.0),
          //     child: Icon(Icons.language),
          //   ),
          //   onTap: () {
          //     Get.defaultDialog(title: "",
          //         content: Container(
          //           child:  Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //               Text("CHOOSE_LANGUAGE".tr,
          //               style: const TextStyle(
          //                   fontSize: 28, fontWeight: FontWeight.bold)),
          //             const SizedBox(height: 30),
          //             ElevatedButton(
          //                 onPressed: () {
          //                   controller.changLang("ar");
          //                   Navigator.of(context).pop();
          //                 },
          //                 child: Text("AR".tr,
          //                     style: const TextStyle(
          //                         fontSize: 24, fontWeight: FontWeight.bold))),
          //             ElevatedButton(
          //                 onPressed: () {
          //                   controller.changLang("en");
          //                   Navigator.of(context).pop();
          //                   Get.back();
          //                 },
          //                 child: Text("EN".tr,
          //                     style: const TextStyle(
          //                         fontSize: 24, fontWeight: FontWeight.bold))),
          //             // child: MaterialButton(
          //             //     onPressed: (){
          //             //       FirebaseAuth.instance.signOut();
          //             //       Get.offAll(AndroidAuthPage());
          //             //     },
          //             //     child:
          //             //     DefualtButton(text: ()?"log out".tr:"")
          //             // )
          //    ]  )   )
          //     );
          //     // FirebaseAuth.instance.signOut();
          //     // Get.offAll(AndroidAuthPage());
          //   },
          // ),
          // SizedBox(
          //   width:10,
          // ),
          // GestureDetector(
          //   child: Padding(
          //     padding: const EdgeInsets.only(top:10.0),
          //     child: Icon(Icons.logout_outlined),
          //   ),
          //   onTap: () {
          //     Get.defaultDialog(title: "",
          //         content: Container(
          //             child: MaterialButton(
          //                 onPressed: (){
          //                   FirebaseAuth.instance.signOut();
          //                   Get.offAll(AndroidAuthPage());
          //                 },
          //                 child:
          //                 DefualtButton(text: "log out".tr)
          //             )
          //         )
          //     );
          //     // FirebaseAuth.instance.signOut();
          //     // Get.offAll(AndroidAuthPage());
          //   },
          // ),
          SizedBox(
            width:10,
          ),
        ],
      ),
      centerTitle: true,
    );
  }
}
