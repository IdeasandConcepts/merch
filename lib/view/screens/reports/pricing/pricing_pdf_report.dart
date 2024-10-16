import 'package:arrow_merchandising/models/pricing_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class AndroidPricingTaskPdfReports extends StatelessWidget {
  final PricingTask pricingTask;
  final String repoortMadeBy;
  const AndroidPricingTaskPdfReports({
    required this.pricingTask,
    super.key,
    required this.repoortMadeBy,
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
    // Convert ByteData to Uint8List
    final imageUint8List = imageByteData.buffer
        .asUint8List(imageByteData.offsetInBytes, imageByteData.lengthInBytes);
    final image = pw.MemoryImage(imageUint8List);
    doc.addPage(pw.Page(
        pageTheme: pw.PageTheme(
            pageFormat: format.copyWith(
                marginBottom: 20,
                marginLeft: 10,
                marginRight: 10,
                marginTop: 10),
            orientation: pw.PageOrientation.portrait,
            theme: pw.ThemeData.withFont(
              base: arFont,
            )),
        build: (context) {
          return pw.Padding(
              padding: pw.EdgeInsets.only(left: 25, right: 25),
              child: pw.Container(
                  padding: pw.EdgeInsets.only(left: 25, right: 25),
                  decoration: pw.BoxDecoration(),
                  child: pw.Center(
                    child: pw.Column(children: [
                      pw.Container(child: pw.Image(image)),
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(
                            left: 30.0, right: 30, top: 5.0),
                        child: pw.Container(
                          height: 40,
                          decoration: pw.BoxDecoration(
                            borderRadius: pw.BorderRadius.circular(10),
                          ),
                          child: pw.Center(
                            child: pw.Text(
                              "Offers Report".tr.toUpperCase(),
                              style: pw.TextStyle(
                                  fontSize: 18, fontWeight: pw.FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      pw.Container(
                          padding: pw.EdgeInsets.only(left: 25, right: 25),
                          child: pw.Column(children: [
                            pw.Center(
                              child: pw.Text(
                                  '${pricingTask.pricingProduct.length}' +
                                      " " +
                                      "Products".tr,
                                  style: pw.TextStyle(
                                      fontSize: 15,
                                      fontWeight: pw.FontWeight.bold)),
                            ),
                            pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text("Date".tr,
                                      style: pw.TextStyle(fontSize: 15)),
                                  pw.Text(pricingTask.taskDate,
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
                                    pricingTask.market,
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
                                    pricingTask.branch,
                                    style: pw.TextStyle(fontSize: 15),
                                  )
                                ]),
                          ])),
                      pw.SizedBox(height: 20),
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
                                    'Date'.tr,
                                    style: pw.TextStyle(fontSize: 15),
                                  ),
                                  pw.Text(
                                    pricingTask.taskDate,
                                    style: pw.TextStyle(fontSize: 15),
                                  )
                                ]),
                            pw.Divider(height: 0.1),
                            pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text(
                                    'Time'.tr,
                                    style: pw.TextStyle(fontSize: 15),
                                  ),
                                  pw.Text(
                                    pricingTask.taskTime,
                                    style: pw.TextStyle(fontSize: 15),
                                  )
                                ]),
                            pw.Divider(height: 0.1),
                            pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text(
                                    'Done By'.tr,
                                    style: pw.TextStyle(fontSize: 15),
                                  ),
                                  pw.Text(
                                    pricingTask.madeBy,
                                    style: pw.TextStyle(fontSize: 15),
                                  )
                                ]),
                            pw.Divider(height: 0.1),
                            pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text(
                                    'Task Type'.tr,
                                    style: pw.TextStyle(fontSize: 15),
                                  ),
                                  pw.Text(
                                    pricingTask.taskType,
                                    style: pw.TextStyle(fontSize: 15),
                                  )
                                ]),
                            pw.Divider(height: 0.1),
                            if (pricingTask.taskType == "New Task")
                              pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      'Order By'.tr,
                                      style: pw.TextStyle(fontSize: 15),
                                    ),
                                    pw.Text(
                                      pricingTask.orderBy,
                                      style: pw.TextStyle(fontSize: 15),
                                    )
                                  ]),
                          ])),
                      pw.SizedBox(height: 20),
                      pw.Text(
                        'Products'.tr,
                        style: pw.TextStyle(fontSize: 15),
                      ),
                      pw.Container(
                        padding: pw.EdgeInsets.only(left: 25, right: 25),
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(),
                        ),
                        child: pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                'Product'.tr,
                                style: pw.TextStyle(fontSize: 15),
                              ),
                              pw.Text(
                                'Price'.tr,
                                style: pw.TextStyle(fontSize: 15),
                              )
                            ]),
                      ),
                      pw.SizedBox(height: 10),
                      for (int i = 0;
                          i < pricingTask.pricingProduct.length;
                          i++)
                        pw.Container(
                          padding: pw.EdgeInsets.only(left: 25, right: 25),
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                          ),
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text(
                                  pricingTask.pricingProduct[i].product,
                                  style: pw.TextStyle(fontSize: 15),
                                ),
                                pw.Text(
                                  "${pricingTask.pricingProduct[i].price}",
                                  style: pw.TextStyle(fontSize: 15),
                                )
                              ]),
                        ),
                      pw.SizedBox(height: 20),
                      pw.Column(children: [
                        pw.SizedBox(height: 20),
                        pw.Container(
                            padding: pw.EdgeInsets.only(left: 25, right: 25),
                            //color:pw.Colors.amberAccent,
                            decoration: pw.BoxDecoration(
                                // color: Colors.amber,
                                //borderRadius: pw.BorderRadius.circular(25),
                                border: pw.Border.all()),
                            child: pw.Column(children: [
                              pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
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
                      // pw.SizedBox(height: 20),

                      // pw.SizedBox(height: 20),
                    ]),
                  )));
        }));
    return doc.save();
  }
}
