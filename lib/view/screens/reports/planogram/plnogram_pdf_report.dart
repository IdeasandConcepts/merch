import 'package:arrow_merchandising/models/ai_planogram_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;



class AndroidPlonogramPdfReports extends StatelessWidget {
  //const PlonogramPdfReports({super.key});
  final AiPlanogramModel planogramModel;
  final String repoortMadeBy;

  const AndroidPlonogramPdfReports({
    required this.planogramModel,
    super.key,
    required this.repoortMadeBy,
  });

  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      build: (
          //PdfPageFormat
          format) =>
          generateDocument(PdfPageFormat.legal
            //  format
          ),
    );
  }

  // static var Font;
  //static init() async {

  // }

  Future<Uint8List> generateDocument(PdfPageFormat format) async {
    late pw.Font arFont;
    arFont =
        pw.Font.ttf((await rootBundle.load("assets/fonts/Cairo-Medium.ttf")));

    // final doc = pw.Document(pageMode: PdfPageMode.outlines);

    final doc = pw.Document(pageMode: PdfPageMode.outlines);
    final imageByteData = await rootBundle.load('assets/images/logo.png');
    // Convert ByteData to Uint8List
    final imageUint8List = imageByteData.buffer
        .asUint8List(imageByteData.offsetInBytes, imageByteData.lengthInBytes);

    final image = pw.MemoryImage(imageUint8List);

    doc.addPage(pw.Page(
      // textDirection:
        pageTheme: pw.PageTheme(
          // textDirection: pw.TextDirection.rtl,
            pageFormat: format.copyWith(
                marginBottom: 20,
                marginLeft: 10,
                marginRight: 10,
                marginTop: 10),
            orientation: pw.PageOrientation.portrait,
            theme: pw.ThemeData.withFont(
              base: arFont,
              // bold: arFont,
            )),
        build: (context) {
          return pw.Padding(
              padding: pw.EdgeInsets.only(left: 25, right: 25),
              child:
              pw.Container(
                  padding: pw.EdgeInsets.only(left: 25, right: 25),
                  //color:pw.Colors.amberAccent,
                  decoration: pw.BoxDecoration(
                    // color: Colors.amber,
                    // borderRadius: pw.BorderRadius.circular(25),
                    //border: pw.Border.all()
                  ),
                  child: pw.Center(
                    child: pw.Column(
                        children: [
                          pw.Container(
                            // height: 50,
                            // width: 50,
                              child: pw.Image(image,height: 150.h)
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.only(left:30.0,right:30,top:5.0),
                            child: pw.Container(
                              height: 40,
                              //width: 280,
                              decoration: pw.BoxDecoration(
                                borderRadius: pw.BorderRadius.circular(10),
                                //color: pw.Colors.grey.withOpacity(0.2)
                              ),
                              child: pw.Center(
                                child: pw.Text("Planogram Report".tr.toUpperCase(),
                                  style: pw.TextStyle(fontSize: 18,fontWeight: pw.FontWeight.bold),

                                  //"26".tr
                                ),
                              ),
                            ),
                          ),
                          pw.Container(
                              padding: pw.EdgeInsets.only(left: 25, right: 25),
                              //color:pw.Colors.amberAccent,
                              decoration: pw.BoxDecoration(
                                // color: Colors.amber,
                                //borderRadius: pw.BorderRadius.circular(25),
                                // border: pw.Border.all()
                              ),
                              child:pw.Column(
                                  children: [
                                    // pw.Center(
                                    //   child: pw.Text(
                                    //       '${planogramModel.rtvProduct.length}' + " "+"Products".tr,
                                    //       style: pw.TextStyle(fontSize: 15,
                                    //           fontWeight: pw.FontWeight.bold)),
                                    // ),
                                    pw.Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text(
                                              "Date".tr,
                                              style: pw.TextStyle(fontSize: 15)),
                                          pw.Text(
                                              planogramModel.taskDate,
                                              style: pw.TextStyle(fontSize: 15)),

                                        ]
                                    ),
                                    pw.Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text(
                                            "Market".tr,
                                            style: pw.TextStyle(fontSize: 15),
                                          ),
                                          pw.Text(
                                            planogramModel.market,
                                            style: pw.TextStyle(fontSize: 15),
                                          ),
                                        ]),
                                    //pw.Divider(height: 0.1),
                                    pw.Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text(
                                            "Branch".tr,
                                            style: pw.TextStyle(fontSize: 15),
                                          ),
                                          pw.Text(
                                            planogramModel.branch,
                                            style: pw.TextStyle(fontSize: 15),
                                          )
                                        ]),
                                  ]
                              )
                          ),
                          pw.SizedBox(height: 20),
                          pw.Container(
                              padding: pw.EdgeInsets.only(left: 25, right: 25),
                              //color:pw.Colors.amberAccent,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all()
                              ),
                              child: pw.Column(
                                  children: [
                                    pw.Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text(
                                            'Date'.tr,
                                            style: pw.TextStyle(fontSize: 15),
                                          ),
                                          pw.Text(
                                            planogramModel.taskDate,
                                            style: pw.TextStyle(fontSize: 15),
                                          )
                                        ]),
                                    pw.Divider(height: 0.1),
                                    pw.Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text(
                                            'Time'.tr,
                                            style: pw.TextStyle(fontSize: 15),
                                          ),
                                          pw.Text(
                                            planogramModel.taskTime,
                                            style: pw.TextStyle(fontSize: 15),
                                          )
                                        ]),
                                    pw.Divider(height: 0.1),

                                    pw.Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text(
                                            'Done By'.tr,
                                            style: pw.TextStyle(fontSize: 15),
                                          ),
                                          pw.Text(
                                            planogramModel.madeBy,
                                            style: pw.TextStyle(fontSize: 15),
                                          )
                                        ]),  pw.Divider(height: 0.1),

                                    pw.Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text(
                                            'Task Type'.tr,
                                            style: pw.TextStyle(fontSize: 15),
                                          ),
                                          pw.Text(
                                            planogramModel.taskType,
                                            style: pw.TextStyle(fontSize: 15),
                                          )
                                        ]),
                                    pw.Divider(height: 0.1),
                                    if(planogramModel.taskType=="New Task")
                                      pw.Row(
                                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Text(
                                              'Order By'.tr,
                                              style: pw.TextStyle(fontSize: 15),
                                            ),
                                            pw.Text(
                                              planogramModel.orderBy,
                                              style: pw.TextStyle(fontSize: 15),
                                            )
                                          ]),
                                  ])
                          ),
                          pw.SizedBox(height: 10),
                          // pw.Text(
                          //   'Returned Products'.tr,
                          //   style: pw.TextStyle(fontSize: 15),
                          // ),

                          pw.Container(
                            padding: pw.EdgeInsets.only(left: 25, right: 25),
                            //color:pw.Colors.amberAccent,
                            decoration: pw.BoxDecoration(
                              // color: Colors.amber,
                              // borderRadius: pw.BorderRadius.circular(25),
                              border: pw.Border.all(),
                            ),
                            child: pw.Column(
                                children: [
                            pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text(
                                    'Case'.tr,
                                    style: pw.TextStyle(fontSize: 15),
                                  ),
                                  pw.Text(
                                    '${planogramModel.degree}'.tr,
                                    style: pw.TextStyle(fontSize: 15),
                                  )
                                ]),
                                  pw.Divider(height: 0.1),
                          //),
                          // pw.Container(
                          //   padding: pw.EdgeInsets.only(left: 25, right: 25),
                          //   //color:pw.Colors.amberAccent,
                          //   decoration: pw.BoxDecoration(
                          //     // color: Colors.amber,
                          //     // borderRadius: pw.BorderRadius.circular(25),
                          //     border: pw.Border.all(),
                          //   ),
                          //   child:
                            pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text(
                                    'Degree is'.tr,
                                    style: pw.TextStyle(fontSize: 15),
                                  ),
                                  pw.Text(
                                    planogramModel.degree=="Excellent"?"90 - 100":
                                    planogramModel.degree=="Very Good"?"70 - 90":
                                    planogramModel.degree=="Good"?"50 - 70":
                                  "Not Arranged"
                                    ,
                                    style: pw.TextStyle(fontSize: 15),
                                  )
                                ]),
                         ] )),

                          pw.SizedBox(height: 10),
                          // for(int i=0;i<planogramModel.rtvProduct.length;i++)
                          // // if(planogramModel.rtvProduct[i].pType=="Piece")
                          //   pw.Container(
                          //     padding: pw.EdgeInsets.only(left: 25, right: 25),
                          //     //color:pw.Colors.amberAccent,
                          //     decoration: pw.BoxDecoration(
                          //       // color: Colors.amber,
                          //       // borderRadius: pw.BorderRadius.circular(25),
                          //       border: pw.Border.all(),
                          //     ),
                          //     child:
                          //     pw.Row(
                          //         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           pw.Text(
                          //             planogramModel.rtvProduct[i].product,
                          //             style: pw.TextStyle(fontSize: 15),
                          //           ),
                          //           pw.Text(
                          //             "${
                          //                 planogramModel.rtvProduct[i].prAmount}",
                          //             style: pw.TextStyle(fontSize: 15),
                          //           )
                          //         ]),
                          //   ),
                          //pw.SizedBox(height: 20),
                          pw.Column(
                              children: [

                                pw.SizedBox(height: 20),
                                pw.Container(
                                    padding: pw.EdgeInsets.only(left: 25, right: 25),
                                    //color:pw.Colors.amberAccent,
                                    decoration: pw.BoxDecoration(
                                      // color: Colors.amber,
                                      //borderRadius: pw.BorderRadius.circular(25),
                                        border: pw.Border.all()
                                    ),
                                    child: pw.Column(
                                        children: [
                                          pw.Row(
                                              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                              children: [
                                                pw.Text(
                                                  'Report Created By'.tr,
                                                  style: pw.TextStyle(fontSize: 15),
                                                ),
                                                pw.Text(
                                                  repoortMadeBy,
                                                  textAlign: pw.TextAlign.center,
                                                  style: pw.TextStyle(fontSize: 15),
                                                )
                                              ]),
                                          pw.Divider(height: 0.1),
                                          pw.Row(
                                              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                              children: [
                                                pw.Text(
                                                  'Report Created Day'.tr,
                                                  style: pw.TextStyle(fontSize: 15),
                                                ),
                                                pw.Text(DateFormat('yyyy-MM-dd')
                                                    .format(DateTime.now())
                                                    .toString(),
                                                  textAlign: pw.TextAlign.center,
                                                  style: pw.TextStyle(fontSize: 15),
                                                )
                                              ]),
                                          pw.Divider(height: 0.1),
                                          pw.Row(
                                              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                              children: [
                                                pw.Text(
                                                  'Report Created Time'.tr,
                                                  style: pw.TextStyle(fontSize: 15),
                                                ),
                                                pw.Text(
                                                  DateFormat('kk:mm')
                                                      .format(DateTime.now())
                                                      .toString(),
                                                  textAlign: pw.TextAlign.center,
                                                  style: pw.TextStyle(fontSize: 15),
                                                )
                                              ]),

                                        ]
                                    )
                                ),
                              ]

                          ),
                          // pw.SizedBox(height: 20),

                          // pw.SizedBox(height: 20),

                        ]),
                  )
              ));
        }));
    return doc.save();
  }
}
