//
// import 'package:arrow_merchandising/models/availability_products.dart';
// import 'package:arrow_merchandising/models/products.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import '../../../../components/default_button.dart';
// import 'package:arrow_merchandising/const.dart';
//
//
//
// class AndroidPieceDetailsScreenBody extends StatefulWidget {
//   final int id, phone,managerPhone;
//   final String username,
//       marketImage,
//       profileImage,
//       branch,
//       market,
//       nationality;
//   final ProductsByPiece ProductByPiece;
//   final String place;
//   const AndroidPieceDetailsScreenBody({
//     super.key,
//     required this.username,
//     required this.marketImage,
//     required this.profileImage,
//     required this.branch,
//     required this.market,
//     required this.managerPhone,
//     required this.id,
//     required this.phone,
//     required this.nationality,
//     required this.ProductByPiece,
//     required this.place,
//
//   });
//
//   //final Products products;
//
//   @override
//   State<AndroidPieceDetailsScreenBody> createState() => _AndroidPieceDetailsScreenBodyState();
// }
//
// class _AndroidPieceDetailsScreenBodyState extends State<AndroidPieceDetailsScreenBody> {
//
//   bool doneTask=false;
//   int counter=1;
//   _increaseCounter(){
//     counter++;
//   }
//   _decreaseCounter(){
//     if(counter>0)
//     counter--;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return  Scaffold(
//       backgroundColor: Colors.grey.withOpacity(0.9),
//       //backgroundColor: kprimaryColor,
//       appBar: AppBar(leading: IconButton(
//         onPressed: (){
//           Get.back();
//         },
//         icon: Icon(Icons.arrow_back_ios),
//         color: Colors.white,
//       ),
//           //backgroundColor: Colors.grey,
//           backgroundColor: kprimaryColor,
//          // backgroundColor: Colors.transparent,
//           elevation: 0.0,
//           title: Text('Details'.tr,
//             style: TextStyle(fontSize: 18.0,
//                 color:Colors.white
//             ),
//
//           ),
//           centerTitle: true,
//           actions:<Widget>[
//             IconButton(
//                 icon:Icon(Icons.more_horiz),
//                 color: Colors.white,
//                 onPressed: (){}),
//           ]
//       ),
//
//       body: Container(
//         //padding: EdgeInsets.only(top:10,bottom:10,left:10.0,right: 10),
//         child: ListView(
//           shrinkWrap: true,
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   height: MediaQuery.of(context).size.height - 202,
//                   width: MediaQuery.of(context).size.width,
//                 // color: Colors.grey,
//                   //backgroundColor: kprimaryColor,
//                   color: Colors.transparent,
//                 ),
//                 Positioned(
//                     child: Container(
//                       //padding: EdgeInsets.only(top:10,bottom:10,left:10.0,right: 10),
//                       decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(75.0),
//                         bottomRight: Radius.circular(75.0),
//                       ),
//                       color: Colors.white
//                   ),
//                   height: MediaQuery.of(context).size.height - 160,
//                   width: MediaQuery.of(context).size.width,
//                 )),
//                 Positioned(
//                   top: 10,
//                   right: 0,
//                   left: 0,
//                   //(MediaQuery.of(context).size.width / 2) - 100.0,
//                   child: Container(
//                    //color: Colors.grey,
//                     //backgroundColor: kprimaryColor,
//                     decoration: BoxDecoration(
//                       color: Colors.grey,
//                       //backgroundColor: kprimaryColor,
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(75.0),
//                           bottomRight: Radius.circular(75.0),
//                         ),
//                        // color: Colors.grey
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Container(
//
//
//                           //     Image.asset("assets/images/ava.jpeg")
//                           // ),
//                               decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                       image: NetworkImage(widget.ProductByPiece.photo),
//                                       //fit: BoxFit.cover
//                                   )
//                               ),
//                          height: 150.0,
//                          width: 120.0,
//                             ),
//                          SizedBox(height: 10,),
//                         Text(widget.ProductByPiece.productDetails,
//                           style: TextStyle(fontSize: 16.0,
//                               fontWeight: FontWeight.w200
//                           ),
//                         ),
//                          SizedBox(height: 10,),
//                         Container(
//                           height: 35,
//                           //width: 10,
//                           //width: 80,
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15),
//
//                               color: kprimaryColor.withOpacity(0.6)
//                             //Color(0xFF7A9BEE),
//                             //Colors.lightBlue
//                           ),
//                           //  width: 130,
//                           child: Text(
//                             widget.ProductByPiece.productItemCode,
//                             style: TextStyle(
//                                 fontSize: 15.0,
//                                 fontWeight: FontWeight.bold
//                             ),
//                             //  '$counter'
//                           ),
//                         ),
//                          SizedBox(height: 10,),
//                         Text(widget.ProductByPiece.productName,
//                           style: TextStyle(fontSize: 18.0,
//                               fontWeight: FontWeight.bold
//                           ),
//                         ),
//                        SizedBox(height: 10,),
//                       ],
//                     ),
//                   ),
//
//                   //tag: widget.,
//                 ),
//
//                // SizedBox(height: 30,),
//                 // Positioned(
//                 //   top: 340,
//                 //   left: (MediaQuery.of(context).size.width / 2) - 170.0,
//                 //   right: (MediaQuery.of(context).size.width / 2) - 170.0,
//                 //   child: Column(
//                 //     children: [
//                 //
//                 //     ],
//                 //   ),
//                 //
//                 //
//                 //   //tag: widget.,
//                 // ),
//                 Positioned(
//                   top: 270,
//                   left: 25,
//                   right: 25,
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                        // Container(
//                        //   padding: EdgeInsets.only(left: 10,right: 10),
//                        //   decoration: BoxDecoration(
//                        //
//                        //       color: Colors.grey,
//                        //       borderRadius: BorderRadius.only(
//                        //         bottomLeft: Radius.circular(75.0),
//                        //         bottomRight: Radius.circular(75.0),
//                        //       ),
//                        //    // borderRadius: BorderRadius.circular(20),
//                        //    // color: kprimaryColor.withOpacity(0.5)
//                        //   ),
//                        //   child:  Column(
//                        //     mainAxisAlignment: MainAxisAlignment.start,
//                        //     crossAxisAlignment: CrossAxisAlignment.start,
//                        //     children: [
//                        //       // Text(widget.ProductByPiece.productDetails,
//                        //       //   style: TextStyle(fontSize: 18.0,
//                        //       //       fontWeight: FontWeight.w200
//                        //       //   ),
//                        //       // ),
//                        //
//                        //       // Container(height: 20.0,
//                        //       //   color: Colors.grey,
//                        //       //   width: 1.0,
//                        //       //   //  child: Text('|'),
//                        //       //   //decoration: BoxDecoration,
//                        //       // ),
//                        //
//                        //       //SizedBox(height: 20.0,),
//                        //       // Container(
//                        //       //
//                        //       //   //width: 80,
//                        //       //   padding: EdgeInsets.all(10),
//                        //       //   decoration: BoxDecoration(
//                        //       //       borderRadius: BorderRadius.circular(20),
//                        //       //
//                        //       //       color: kprimaryColor.withOpacity(0.6)
//                        //       //     //Color(0xFF7A9BEE),
//                        //       //     //Colors.lightBlue
//                        //       //   ),
//                        //       //   //  width: 130,
//                        //       //   child: Center(
//                        //       //     child: Text(
//                        //       //       widget.ProductByPiece.productItemCode,
//                        //       //       style: TextStyle(
//                        //       //           fontSize: 20.0,
//                        //       //           fontWeight: FontWeight.bold
//                        //       //       ),
//                        //       //       //  '$counter'
//                        //       //     ),
//                        //       //   ),
//                        //       // )
//                        //
//                        //     ],
//                        //   ),
//                        // ),
//                          SizedBox(height: 10.0,),
//                   Container(
//                     padding: EdgeInsets.only(left: 10,right: 10),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: kprimaryColor.withOpacity(0.5)
//                   ),
//                          child: Column(
//                            children: <Widget>[
//                          Padding(
//                            padding: const EdgeInsets.only(top:10.0),
//                            child: Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                              children: <Widget>[
//                                Text(
//                                  "Status".tr,
//                                  style: TextStyle(
//                                      fontSize: 20.0,
//                                      fontWeight: FontWeight.w800,
//                                      fontFamily: 'Roboto',
//                                      color: Colors.black),
//                                ),
//                                SizedBox(width: 10,),
//                                Text(
//                                  status.tr,
//                                  style: TextStyle(
//                                      fontSize: 20.0,
//                                      fontWeight: FontWeight.w800,
//                                      fontFamily: 'Roboto',
//                                      color: Colors.black),
//                                ),
//                               ]),
//                          ),
//                              Divider(),
//                              //if((switchVal==true)&&(overStock==false)&&(lowStock==false))
//                              customSwith("Available", avilableVal,),
//                              //SizedBox(height: 10.0,),
//                             // customSwith(status, switchVal, "Available"),
//                             // if((switchVal==true)&&(overStock==false))
//                              customSwith("Over Stock", overStock,),
//                              //SizedBox(height: 10.0,),
//                             // if((switchVal==true)&&(overStock==false))
//                              customSwith("Low Stock", lowStock,),
//
//                            ],
//                          ),
//                        ),
//                         SizedBox(height: 10.0,),
//                         SingleChildScrollView(
//                           physics: BouncingScrollPhysics(),
//                           scrollDirection: Axis.horizontal,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(20),
//                                   border: Border.all(
//                                       width: 1.0,
//                                       color: Colors.grey
//                                   )
//                                 //color: Colors.,
//                                 //Colors.lightBlue
//                               ),
//                                 width: 130,
//                                 height: 170,
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(top:10.0,bottom: 10),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: <Widget>[
//
//
//                                       Container(decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(20),
//                                         //color: Color(0xFF7A9BEE),
//                                         //Colors.lightBlue
//                                       ),
//                                         width: 90,
//                                         height: 26,
//                                         child: Text('Category'.tr,
//                                           style: TextStyle(
//                                               fontSize: 20.0,
//                                               //color: Colors.white,
//                                               fontWeight: FontWeight.bold
//                                           ),
//                                         ),
//                                       ),
//
//                                       Container(decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(20),
//                                         //color: Color(0xFF7A9BEE),
//                                         //Colors.lightBlue
//                                       ),
//                                         width: 80,
//                                         height: 27,
//                                         child: Text(
//                                           widget.ProductByPiece.productCategory,
//                                           style: TextStyle(fontSize: 15.0,
//                                               //color: Colors.grey,
//                                               fontWeight: FontWeight.bold
//                                           ),),
//                                       ),
//
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 10,),
//                               Container(decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(20),
//                                   border: Border.all(
//                                       width: 1.0,
//                                       color: Colors.grey
//                                   )
//
//                               ),
//                                 width: 130,
//                                 height: 170,
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(top:10.0,bottom: 10),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: <Widget>[
//                                       Container(decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(20),
//
//                                       ),
//                                         width: 90,
//                                         height: 50,
//                                         child: Text('Product'.tr,
//
//                                           style: TextStyle( fontSize: 20.0,
//                                               //color: Colors.white,
//                                               fontWeight: FontWeight.bold
//                                           ),
//                                         ),
//                                       ),
//                                       // SizedBox(height: 20,),
//                                       SizedBox(height: 10,),
//                                       Container(decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(20),
//
//                                       ),
//                                         width: 90,
//                                         height: 80,
//                                         child: Text(
//                                           widget.ProductByPiece.productDetails,
//                                           style: TextStyle( fontSize: 15.0,
//                                               //color: Colors.white,
//                                               fontWeight: FontWeight.bold
//                                           ),),
//                                       ),
//
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 10,),
//
//                               Container(decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(20), border: Border.all(width: 1.0, color: Colors.grey)
//     //color: Colors.,
//     //Colors.lightBlue
//
//                               ),
//                                 width: 130,
//                                 height: 170,
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(top:10.0,bottom: 10),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: <Widget>[
//
//
//                                       Container(
//                                         decoration: BoxDecoration(
//
//                                        // borderRadius: BorderRadius.circular(20),
//                                         //color: Color(0xFF7A9BEE),
//                                         //Colors.lightBlue
//                                       ),
//                                         //width: 90,
//                                         height: 26,
//                                         child: Text('Weight'.tr,
//
//                                           style: TextStyle(
//                                               fontSize: 20.0,
//                                               //color: Colors.white,
//                                               fontWeight: FontWeight.bold
//                                           ),
//                                         ),
//                                       ),
//
//                                       Column(
//                                         children: [
//                                           Container(decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(20),
//                                             //color: Color(0xFF7A9BEE),
//                                             //Colors.lightBlue
//                                           ),
//                                             width: 80,
//                                             height: 27,
//                                             child: Text(
//                                               '${widget.ProductByPiece.productSize}'+ "\t"+'Gm'.tr
//                                               //'$widget.ProductByPiece.productSize}'
//                                               ,
//                                               style: TextStyle(fontSize: 20.0,
//                                                   //color: Colors.white,
//                                                   fontWeight: FontWeight.w500
//                                               ),
//                                             ),
//                                           ),
//
//                                         ],
//                                       ),
//                                       // IconButton(onPressed: (){},
//                                       //   icon: Icon(Icons.add_circle),
//                                       //   color: Colors.white,
//                                       // ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//
//                         // const SizedBox(
//                         //   height: 15,
//                         // ),
//
//
//                       ]
//                     //  ],
//                   ),
//                 ),
//
//
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             MaterialButton(
//               onPressed: () async {
//                 if(!selectedAvailabilityProducts.contains(widget.ProductByPiece.productName))
//                 {
//                   setState(() {
//                     selectedAvailabilityProducts.add(widget.ProductByPiece.productName,);
//                     //  setState(() {
//
//
//                     availabilityTaskDetails.add(AvailabilityProduct(
//                         place: widget.place,
//                         aStatus: status,
//                         product: widget.ProductByPiece.productName,
//                         //prAmount:counter,
//                         prCategory: widget.ProductByPiece.productCategory)
//                     );
//                     Fluttertoast.showToast(
//                         msg: "This Product has been added SuccessFully".tr,
//                         backgroundColor: kprimaryColor,
//                         toastLength: Toast.LENGTH_LONG,
//                         fontSize: 20, gravity:ToastGravity.CENTER);
//
//                   });
//
//                 }  else{
//                   Fluttertoast.showToast(
//                       msg: "This Product has already been added".tr,
//                       backgroundColor: Colors.grey,
//                       toastLength: Toast.LENGTH_LONG,
//                       fontSize: 20,
//                       gravity:ToastGravity.CENTER
//                   );
//                 }
//                 if(availabilityTaskDetails.length>0)
//                   // Navigator.of(context).pop();
//                     {
//                   Get.back();
//                 }
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 25.0),
//                 child: DefualtButton(text: 'Add To List'.tr),
//               ),
//             ),
//           ],
//         ),
//       ),
//
//     );
//   }
//
//   Widget customSwith(String text, bool myValue,) {
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: <Widget>[
//         Text(
//           text.tr,
//           style: TextStyle(
//               fontSize: 20.0,
//               fontWeight: FontWeight.w800,
//               fontFamily: 'Roboto',
//               color: Colors.black),
//         ),
//         SizedBox(width: 10,),
//         CupertinoSwitch(
//             trackColor: Colors.red,
//             activeColor: Colors.green,
//             value: myValue,
//             onChanged:
//                 (newValue) {
//               if(text== "Available") {
//                 OnChangFun(newValue);
//               }else if(text=="Over Stock") {
//                 OnOverChangFun(newValue);
//               }else if(text=="Low Stock") {
//                 OnLowChangFun(newValue);
//               }else
//               if(myValue==false)
//               counter=0;
//               //  onchange();
//               //switchVal = !switchVal;
//             }
//
//             )
//       ],
//     );
//   }
//
//   OnChangFun(bool val) {
//     setState(() {
//       avilableVal = val;
//       if (avilableVal == false)
//         setState(() {
//           status = "Not Available";
//         });
//       else
//         setState(() {
//           status = "Available";
//           lowStock=false;
//           overStock=false;
//         });
//
//       // v
//     });
//   }
// //
//   OnOverChangFun(bool val) {
//     setState(() {
//       overStock = val;
//       if (overStock == false)
//         setState(() {
//           status = status;
//         });
//       else
//         setState(() {
//           status = "Over Stock";
//           lowStock=false;
//           avilableVal=false;
//         });
//
//       // v
//     });
//   }
//   //
//   OnLowChangFun(bool val) {
//     setState(() {
//       lowStock = val;
//       if (lowStock == false)
//         setState(() {
//           status = status;
//         });
//       else
//         setState(() {
//           status = "Low Stock";
//           overStock=false;
//           avilableVal=false;
//         });
//
//       // v
//     });
//   }
//   bool avilableVal = true;
//   bool lowStock=false,
//   overStock=false;
//   String status = "Available";
//
//   // Future createAvailabilityTask(PieceAvailabilityProduct pieceAvialabilityProduct) async {
//   //   final inventoryData = FirebaseFirestore.instance.collection(
//   //       'Availability').doc();
//   //   final json = pieceAvialabilityProduct.tojson();
//   //   await inventoryData.set(json);
//   //   doneTask=true;
//   // }
// }
// //}
