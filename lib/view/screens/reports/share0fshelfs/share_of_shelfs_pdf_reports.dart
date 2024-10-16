import 'package:arrow_merchandising/models/ai_share_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';

import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';

class AndroidShareSfShelfPdfReports extends StatelessWidget {
  final AiShareModel shareOfShellTask;
  final String reportMadeBy;
  const AndroidShareSfShelfPdfReports({
    super.key,
    required this.shareOfShellTask,
    required this.reportMadeBy,
  });

  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      build: (format) => generateDocument(PdfPageFormat.a4),
    );
  }

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
                marginBottom: 20,
                marginLeft: 10,
                marginRight: 10,
                marginTop: 20),
            orientation: pw.PageOrientation.portrait,
            theme: pw.ThemeData.withFont(
              base: arFont,
            )),
        build: (context) {
          return pw.Container(
              padding: pw.EdgeInsets.only(left: 25, right: 25),
              decoration: pw.BoxDecoration(
                borderRadius: pw.BorderRadius.circular(25),
              ),
              child: pw.Column(children: [
                pw.Container(child: pw.Image(image, height: 150.h)),
                pw.Container(
                  padding: pw.EdgeInsets.only(left: 25, right: 25),
                  decoration: pw.BoxDecoration(
                    borderRadius: pw.BorderRadius.circular(25),
                  ),
                  child: pw.Column(children: [
                    pw.Align(
                      alignment: pw.Alignment.center,
                      child: pw.Text('Share of Shelves'.tr,
                          style: pw.TextStyle(
                              fontSize: 20, fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('Date'.tr,
                              style: pw.TextStyle(
                                  fontSize: 20,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.Text(
                            shareOfShellTask.taskDate,
                            style: pw.TextStyle(
                                fontSize: 18, fontWeight: pw.FontWeight.bold),
                          )
                        ]),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Market",
                            style: pw.TextStyle(fontSize: 18),
                          ),
                          pw.Text(
                            shareOfShellTask.market,
                            style: pw.TextStyle(fontSize: 18),
                          ),
                        ]),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Branch",
                            style: pw.TextStyle(fontSize: 18),
                          ),
                          pw.Text(
                            shareOfShellTask.branch,
                            style: pw.TextStyle(fontSize: 18),
                          )
                        ]),
                  ]),
                ),
                pw.SizedBox(height: 20),
                pw.Container(
                    padding: pw.EdgeInsets.only(left: 25, right: 25),
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    child: pw.Column(children: [
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'Task Date:',
                              style: pw.TextStyle(fontSize: 18),
                            ),
                            pw.Text(
                              shareOfShellTask.taskDate,
                              style: pw.TextStyle(fontSize: 18),
                            )
                          ]),
                      //pw.Divider(height: 0.1),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'Task Time:',
                              style: pw.TextStyle(fontSize: 18),
                            ),
                            pw.Text(
                              shareOfShellTask.taskTime,
                              style: pw.TextStyle(fontSize: 18),
                            )
                          ]),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'Task Type'.tr,
                              style: pw.TextStyle(fontSize: 15),
                            ),
                            pw.Text(
                              shareOfShellTask.taskType,
                              style: pw.TextStyle(fontSize: 15),
                            )
                          ]),
                      pw.Divider(height: 0.1),
                      if (shareOfShellTask.taskType == "New Task")
                        pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                'Order By'.tr,
                                style: pw.TextStyle(fontSize: 15),
                              ),
                              pw.Text(
                                shareOfShellTask.orderBy,
                                style: pw.TextStyle(fontSize: 15),
                              )
                            ]),
                    ])),
                pw.SizedBox(height: 20),
                pw.Container(
                    padding: pw.EdgeInsets.only(left: 25, right: 25),
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    child: pw.Column(children: [
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'Case:'.tr,
                              style: pw.TextStyle(fontSize: 18),
                            ),
                            pw.Text(
                              (shareOfShellTask.degree < 50)
                                  ? "Full Of Stock"
                                  : "Empty Area" +
                                      '\t' +
                                      '${shareOfShellTask.degree}',
                              style: pw.TextStyle(fontSize: 18),
                            )
                          ]),
                      pw.Divider(height: 0.1),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'Made By'.tr,
                              style: pw.TextStyle(fontSize: 18),
                            ),
                            pw.Text(
                              shareOfShellTask.madeBy,
                              style: pw.TextStyle(fontSize: 18),
                            )
                          ]),
                    ])),
                pw.SizedBox(height: 20),
                pw.Container(
                    padding: pw.EdgeInsets.only(left: 25, right: 25),
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    child: pw.Column(children: [
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'Report Created by:'.tr,
                              style: pw.TextStyle(fontSize: 18),
                            ),
                            pw.Text(
                              reportMadeBy,
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(fontSize: 18),
                            )
                          ]),
                      pw.Divider(height: 0.1),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'Report Created Day'.tr,
                              style: pw.TextStyle(fontSize: 20),
                            ),
                            pw.Text(
                              DateFormat('yyyy-MM-dd')
                                  .format(DateTime.now())
                                  .toString(),
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(fontSize: 20),
                            )
                          ]),
                      pw.Divider(height: 0.1),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              'Report Created Time'.tr,
                              style: pw.TextStyle(fontSize: 20),
                            ),
                            pw.Text(
                              DateFormat('kk:mm')
                                  .format(DateTime.now())
                                  .toString(),
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(fontSize: 20),
                            )
                          ]),
                    ])),
                pw.SizedBox(height: 10),
              ]));
        }));
    return doc.save();
  }
}
