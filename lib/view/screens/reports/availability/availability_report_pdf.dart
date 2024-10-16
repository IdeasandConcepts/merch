import 'package:arrow_merchandising/models/availability_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class AndroidAvailabilityPdfReports extends StatelessWidget {
  final AvailabilityTaskModel availability;
  final String reportMadeBy;

  const AndroidAvailabilityPdfReports({
    super.key,
    required this.availability,
    required this.reportMadeBy,
  });

  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      build: (format) => generateDocument(PdfPageFormat.a3),
    );
  }

  Future<Uint8List> generateDocument(PdfPageFormat format) async {
    late pw.Font arFont;
    arFont =
        pw.Font.ttf((await rootBundle.load("assets/fonts/Cairo-Medium.ttf")));

    final doc = pw.Document(pageMode: PdfPageMode.fullscreen);
    final imageByteData = await rootBundle.load('assets/images/logo.png');
    final imageUint8List = imageByteData.buffer
        .asUint8List(imageByteData.offsetInBytes, imageByteData.lengthInBytes);
    final image = pw.MemoryImage(imageUint8List);

    doc.addPage(
        //

        pw.Page(
            pageTheme: pw.PageTheme(
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
                  child: pw.Container(
                      height: 1200,
                      padding: pw.EdgeInsets.only(left: 25, right: 25),
                      decoration: pw.BoxDecoration(),
                      child: pw.Center(
                        child: pw.Column(children: [
                          pw.Container(
                              height: 150, width: 150, child: pw.Image(image)),
                          pw.Container(
                              padding: pw.EdgeInsets.only(left: 25, right: 25),
                              decoration: pw.BoxDecoration(),
                              child: pw.Column(children: [
                                pw.Padding(
                                  padding: pw.EdgeInsets.only(
                                    left: 30.0,
                                    right: 30,
                                    top: 10,
                                  ),
                                  child: pw.Container(
                                    height: 40,
                                    // width: 220,
                                    decoration: pw.BoxDecoration(
                                      borderRadius:
                                          pw.BorderRadius.circular(10),
                                    ),
                                    child: pw.Center(
                                      child: pw.Text(
                                        "Availability Report".tr.toUpperCase(),
                                        style: pw.TextStyle(
                                            fontSize: 28,
                                            fontWeight: pw.FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                pw.SizedBox(height: 20),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text("Available Products".tr,
                                          style: pw.TextStyle(fontSize: 15)),
                                      pw.Text(
                                          '${availability.availabilityProduct.length}' +
                                              " " +
                                              "Products".tr,
                                          style: pw.TextStyle(
                                              fontSize: 15,
                                              fontWeight: pw.FontWeight.bold)),
                                    ]),
                                pw.SizedBox(height: 10),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text(
                                        "Market".tr,
                                        style: pw.TextStyle(fontSize: 15),
                                      ),
                                      pw.Text(
                                        availability.market,
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
                                        availability.branch,
                                        style: pw.TextStyle(fontSize: 15),
                                      )
                                    ]),
                                pw.SizedBox(height: 10),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text(
                                        'Place'.tr,
                                        style: pw.TextStyle(fontSize: 15),
                                      ),
                                      pw.Text(
                                        availability.place,
                                        style: pw.TextStyle(fontSize: 15),
                                      )
                                    ]),
                              ])),
                          pw.SizedBox(height: 20),
                          pw.Container(
                              padding: pw.EdgeInsets.only(left: 25, right: 25),
                              //color:pw.Colors.amberAccent,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
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
                                        availability.taskDate,
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
                                        availability.taskTime,
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
                                        availability.madeBy,
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
                                        availability.taskType,
                                        style: pw.TextStyle(fontSize: 15),
                                      )
                                    ]),
                                pw.Divider(height: 0.1),
                                if (availability.taskType == "New Task")
                                  pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.spaceBetween,
                                      children: [
                                        pw.Text(
                                          'Order By'.tr,
                                          style: pw.TextStyle(fontSize: 15),
                                        ),
                                        pw.Text(
                                          availability.orderBy,
                                          style: pw.TextStyle(fontSize: 15),
                                        )
                                      ]),
                              ])),
                          pw.SizedBox(height: 20),
                          pw.Container(
                              padding: pw.EdgeInsets.only(left: 25, right: 25),
                              decoration: pw.BoxDecoration(
                                border: pw.Border.all(),
                              ),
                              child: pw.Column(children: [
                                pw.Divider(height: 0.1),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text('Product Name'.tr,
                                          style: pw.TextStyle(fontSize: 15)),
                                      pw.Text(
                                        'Product Status'.tr,
                                        style: pw.TextStyle(fontSize: 17),
                                      )
                                    ]),
                              ])),
                          pw.SizedBox(
                            height: 10,
                          ),
                          pw.Divider(height: 0.1),
                          for (int i = 0;
                              i <
                                  (availability.availabilityProduct.length > 5
                                      ? 5
                                      : availability
                                          .availabilityProduct.length);
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
                                      availability
                                          .availabilityProduct[i].product,
                                      style: pw.TextStyle(fontSize: 15),
                                    ),
                                    pw.Text(
                                      '${(availability.availabilityProduct[i].prAmount > 5) ? "High Stock" : "Low Stock"}',
                                      style: pw.TextStyle(fontSize: 15),
                                    )
                                  ]),
                            ),
                          if (availability.availabilityProduct.length > 5)
                            pw.Container(
                                padding:
                                    pw.EdgeInsets.only(left: 25, right: 25),
                                decoration: pw.BoxDecoration(
                                  border: pw.Border.all(),
                                ),
                                child: pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text(
                                        '.....'.tr,
                                        style: pw.TextStyle(fontSize: 15),
                                      ),
                                      pw.Text(
                                        '....'.tr,
                                        style: pw.TextStyle(fontSize: 15),
                                      )
                                    ])),
                          //   ..
                          pw.Container(
                              padding: pw.EdgeInsets.only(left: 25, right: 25),
                              //color:pw.Colors.amberAccent,
                              decoration: pw.BoxDecoration(
                                // color: Colors.amber,
                                // borderRadius: pw.BorderRadius.circular(25),
                                border: pw.Border.all(),
                              ),
                              child: pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      'All Product'.tr,
                                      style: pw.TextStyle(fontSize: 15),
                                    ),
                                    pw.Text(
                                      '${availability.availabilityProduct.length}'
                                          .tr,
                                      style: pw.TextStyle(fontSize: 15),
                                    )
                                  ])),

                          pw.Column(children: [
                            pw.SizedBox(height: 20),
                            pw.Container(
                                padding:
                                    pw.EdgeInsets.only(left: 25, right: 25),
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
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
                                          reportMadeBy,
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
                        ]),
                      )));
            }));
    return doc.save();
  }
}
