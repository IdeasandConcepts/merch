import 'package:arrow_merchandising/models/Visits.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class AndroidCapturePhotoPdfReports extends StatelessWidget {
  final FullVisit capturePhotos;
  final String reportMadeBy;
  const AndroidCapturePhotoPdfReports({
    required this.capturePhotos,
    super.key,
    required this.reportMadeBy,
  });

  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      build: (
              //PdfPageFormat
              format) =>
          generateDocument(PdfPageFormat.a4
              //  format
              ),
    );
  }

  // init() async {}

  Future<Uint8List> generateDocument(PdfPageFormat format) async {
    late pw.Font arFont;
    arFont =
        pw.Font.ttf((await rootBundle.load("assets/fonts/Cairo-Medium.ttf")));
    final doc = pw.Document(pageMode: PdfPageMode.outlines);
    final imageByteData = await rootBundle.load('assets/images/logo.png');
    final imageUint8List = imageByteData.buffer
        .asUint8List(imageByteData.offsetInBytes, imageByteData.lengthInBytes);
    final image = pw.MemoryImage(imageUint8List);

    doc.addPage(pw.Page(
        pageTheme: pw.PageTheme(
            pageFormat: format.copyWith(
                marginBottom: 15,
                marginLeft: 10,
                marginRight: 10,
                marginTop: 10),
            orientation: pw.PageOrientation.portrait,
            theme: pw.ThemeData.withFont(
              base: arFont,
            )),
        build: (context) {
          return pw.Container(
              padding: pw.EdgeInsets.only(left: 25, right: 25),
              child: pw.Center(
                  child: pw.Column(children: [
                pw.SizedBox(height: 5),
                pw.Container(child: pw.Image(image, height: 150.h)),
                // pw.SizedBox(height: 15),
                pw.Padding(
                    padding: pw.EdgeInsets.only(left: 30.0, right: 30, top: 10),
                    child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Container(
                            height: 20.h,
                            decoration: pw.BoxDecoration(
                              borderRadius: pw.BorderRadius.circular(10),
                            ),
                            child: pw.Center(
                              child: pw.Text(
                                "Visit Report".tr,
                                style: pw.TextStyle(
                                    fontSize: 28,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ),
                          ),
                          pw.SizedBox(height: 15),
                          pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text("Date".tr,
                                    style: pw.TextStyle(fontSize: 15)),
                                pw.Text(capturePhotos.date,
                                    style: pw.TextStyle(fontSize: 15)),
                              ]),
                          pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text(
                                  "Market".tr,
                                  style: pw.TextStyle(fontSize: 15),
                                ),
                                pw.Text(
                                  capturePhotos.market,
                                  style: pw.TextStyle(fontSize: 15),
                                ),
                              ]),
                          //pw.Divider(height: 0.1),
                          pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text(
                                  "Branch".tr,
                                  style: pw.TextStyle(fontSize: 15),
                                ),
                                pw.Text(
                                  capturePhotos.branch,
                                  style: pw.TextStyle(fontSize: 15),
                                )
                              ]),
                        ])),

                pw.SizedBox(height: 15),
                pw.Container(
                  padding: pw.EdgeInsets.only(left: 25, right: 25),
                  decoration: pw.BoxDecoration(border: pw.Border.all()),
                  child: pw.Column(children: [
                    pw.Divider(height: 0.1),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Task Date:'.tr,
                            style: pw.TextStyle(fontSize: 15),
                          ),
                          pw.Text(
                            capturePhotos.date,
                            style: pw.TextStyle(fontSize: 15),
                          )
                        ]),
                    pw.Divider(height: 0.1),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Task Type'.tr,
                            style: pw.TextStyle(fontSize: 15),
                          ),
                          pw.Text(
                            capturePhotos.orderBy == "Daily Task"
                                ? "Daily Task"
                                : "New Task",
                            style: pw.TextStyle(fontSize: 15),
                          )
                        ]),
                    pw.Divider(height: 0.1),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Made by'.tr,
                            style: pw.TextStyle(fontSize: 15),
                          ),
                          pw.Text(
                            capturePhotos.madeBy,
                            style: pw.TextStyle(fontSize: 15),
                          )
                        ]),
                  ]),
                ),
                pw.SizedBox(height: 15),
                pw.Container(
                  padding: pw.EdgeInsets.only(left: 25, right: 25),
                  decoration: pw.BoxDecoration(border: pw.Border.all()),
                  child: pw.Column(children: [
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Task Case:'.tr,
                            style: pw.TextStyle(fontSize: 15),
                          ),
                          pw.Text(
                            capturePhotos.before[0].title.tr,
                            style: pw.TextStyle(fontSize: 15),
                          )
                        ]),
                    pw.Divider(height: 0.1),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Place'.tr,
                            style: pw.TextStyle(fontSize: 15),
                          ),
                          pw.Text(
                            '${capturePhotos.before[0].place}',
                            style: pw.TextStyle(fontSize: 15),
                          )
                        ]),
                    pw.Divider(height: 0.1),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Product'.tr,
                            style: pw.TextStyle(fontSize: 15),
                          ),
                          pw.Text(
                            capturePhotos.before[0].product,
                            style: pw.TextStyle(fontSize: 15),
                          )
                        ]),
                    pw.Divider(height: 0.1),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Task Time',
                            style: pw.TextStyle(fontSize: 15),
                          ),
                          pw.Text(
                            capturePhotos.before[0].taskTime,
                            style: pw.TextStyle(fontSize: 15),
                          )
                        ]),
                  ]),
                ),
                pw.SizedBox(height: 15),
                //pw.SizedBox(height: 15),
                pw.Container(
                  padding: pw.EdgeInsets.only(left: 25, right: 25),
                  decoration: pw.BoxDecoration(border: pw.Border.all()),
                  child: pw.Column(children: [
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Task Case:'.tr,
                            style: pw.TextStyle(fontSize: 15),
                          ),
                          pw.Text(
                            capturePhotos.after[0].title.tr,
                            style: pw.TextStyle(fontSize: 15),
                          )
                        ]),
                    pw.Divider(height: 0.1),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Place'.tr,
                            style: pw.TextStyle(fontSize: 15),
                          ),
                          pw.Text(
                            '${capturePhotos.after[0].place}',
                            style: pw.TextStyle(fontSize: 15),
                          )
                        ]),
                    pw.Divider(height: 0.1),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Product'.tr,
                            style: pw.TextStyle(fontSize: 15),
                          ),
                          pw.Text(
                            capturePhotos.after[0].product,
                            style: pw.TextStyle(fontSize: 15),
                          )
                        ]),
                    pw.Divider(height: 0.1),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Task Time',
                            style: pw.TextStyle(fontSize: 15),
                          ),
                          pw.Text(
                            capturePhotos.after[0].taskTime,
                            style: pw.TextStyle(fontSize: 15),
                          )
                        ]),
                    // pw.Divider(height: 0.1),
                  ]),
                ),
                pw.SizedBox(height: 15),
                pw.Column(children: [
                  //pw.SizedBox(height: 15),
                  pw.Container(
                      padding: pw.EdgeInsets.only(left: 25, right: 25),
                      //color:pw.Colors.amberAccent,
                      decoration: pw.BoxDecoration(border: pw.Border.all()),
                      child: pw.Column(children: [
                        pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                'Report Created by:'.tr,
                                style: pw.TextStyle(fontSize: 15),
                              ),
                              pw.Text(
                                reportMadeBy,
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(fontSize: 15),
                              )
                            ]),
                        pw.Divider(),
                        pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                'Report Created Day'.tr,
                                style: pw.TextStyle(fontSize: 15),
                              ),
                              pw.Text(
                                DateFormat('yyyy-MM-dd')
                                    .format(DateTime.now())
                                    .toString(),
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(fontSize: 15),
                              )
                            ]),
                        pw.Divider(height: 0.1),
                        pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
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
                      ])),
                ]),
              ])));
        }));
    return doc.save();
  }
}
