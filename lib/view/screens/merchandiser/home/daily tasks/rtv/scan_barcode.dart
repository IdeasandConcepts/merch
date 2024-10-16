

import 'package:arrow_merchandising/view/screens/merchandiser/profile/branch_appbar.dart';
import 'package:arrow_merchandising/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanBarCode extends StatefulWidget {
  final String managerName,userName,profileImage,market,marketImage,branch;
  final int phone,managerPhone;
  // final List<String> products;
  // final List<String> productsCodes;
  const ScanBarCode({Key? key,
    required this.managerName,
    required this.userName,
    required this.market,
    required this.marketImage,
    required this.branch,
    required this.phone,
    required this.managerPhone, required this.profileImage,
    // required this.products,
    // required this.productsCodes
  }) : super(key: key);

  @override
  State<ScanBarCode> createState() => _ScanBarCodeState();
}

class _ScanBarCodeState extends State<ScanBarCode> {
  bool isScanComplete=false;
  String scanResult = "";
  String selectedProduct="";
  void closeScan(){
    setState(() {
      isScanComplete=true;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kprimaryColor,
          title:
          MerchAppBar(
            // appBar: MerchAppBar(
            title: "RTV Section",
            manegerName: widget.managerName,
            phone: widget.phone,
            market: widget.market,
            marketImage: widget.marketImage,
            branch: widget.branch,
            username: widget.userName,
            profileImage: widget.profileImage,
          ) ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(child: Container(child: Center(child: Text("Scanning Result")))),
            Expanded(
              flex: 3,
              child: MobileScanner(
                //onDetect: ,
                // allowDuplicates: true,
                // onDetect: (barcode,args){
                //   if(isScanComplete!=true)
                //   {
                //   setState(() {
                //       scanResult=barcode.rawValue ?? '---';
                //       isScanComplete=true;
                //       print("Success");
                //   });
                //   // for(int i=0;i<widget.products.length;i++)
                //   //   if(widget.productsCodes[i]==scanResult)
                //   //     {
                //   //       selectedProduct=widget.products[i];
                //   //       break;
                //   //     }
                //   }
                //},
  ),
            ),
           
            Expanded(
                child: Container(child: Center(child: Text(
                    (isScanComplete==true)?scanResult:"No Result Yet".tr)))),
          ],
        ),
      ),
    );
  }
}
