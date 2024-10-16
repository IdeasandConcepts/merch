import 'package:arrow_merchandising/models/inventory_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class AndroidinventoryPdfReports extends StatelessWidget {
//  late
  final InventoryTask inventoryTask;
  final String reportMadeBy;

  const AndroidinventoryPdfReports(
      {super.key, required this.inventoryTask, required this.reportMadeBy});

  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      build: (format) => generateDocument(PdfPageFormat.a4
          //  format
          ),
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
                marginLeft: 10.h,
                marginRight: 10.h,
                marginTop: 10.h),
            orientation: pw.PageOrientation.portrait,
            theme: pw.ThemeData.withFont(
              base: arFont,
            )),
        build: (context) {
          return pw.Padding(
              padding: pw.EdgeInsets.only(left: 25, right: 25),
              child: pw.Container(
                  padding: pw.EdgeInsets.only(left: 25.w, right: 25.w),
                  decoration: pw.BoxDecoration(),
                  child: pw.Center(
                    child: pw.Column(children: [
                      pw.Container(
                          height: 150.h, width: 150.w, child: pw.Image(image)),
                      pw.Padding(
                        padding: const pw.EdgeInsets.only(
                            left: 30.0, right: 30, top: 5.0),
                        child: pw.Container(
                          height: 40,
                          decoration: pw.BoxDecoration(
                            borderRadius: pw.BorderRadius.circular(10.h),
                          ),
                          child: pw.Center(
                            child: pw.Text(
                              "Inventory Report".tr.toUpperCase(),
                              style: pw.TextStyle(
                                  fontSize: 18, fontWeight: pw.FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      pw.Container(
                          padding: pw.EdgeInsets.only(left: 25.w, right: 25.w),
                          child: pw.Column(children: [
                            pw.Center(
                              child: pw.Text(
                                  '${inventoryTask.inventoryProduct.length}' +
                                      " " +
                                      "Products".tr,
                                  style: pw.TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: pw.FontWeight.bold)),
                            ),
                            pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text(
                                    "Market".tr,
                                    style: pw.TextStyle(fontSize: 15.sp),
                                  ),
                                  pw.Text(
                                    inventoryTask.market,
                                    style: pw.TextStyle(fontSize: 15.sp.sp),
                                  ),
                                ]),
                            pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text(
                                    "Branch".tr,
                                    style: pw.TextStyle(fontSize: 15.sp.sp),
                                  ),
                                  pw.Text(
                                    inventoryTask.branch,
                                    style: pw.TextStyle(fontSize: 15.sp.sp),
                                  )
                                ]),
                            pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text("Place".tr,
                                      style: pw.TextStyle(fontSize: 15.sp)),
                                  pw.Text(inventoryTask.place,
                                      style: pw.TextStyle(fontSize: 15.sp)),
                                ]),
                          ])),
                      pw.SizedBox(height: 20),
                      pw.Container(
                          padding: pw.EdgeInsets.only(left: 25.w, right: 25.w),
                          //color:pw.Colors.amberAccent,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Column(children: [
                            pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text(
                                    'Date'.tr,
                                    style: pw.TextStyle(fontSize: 15.sp),
                                  ),
                                  pw.Text(
                                    inventoryTask.taskDate,
                                    style: pw.TextStyle(fontSize: 15.sp),
                                  )
                                ]),
                            pw.Divider(height: 0.1),
                            pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text(
                                    'Time'.tr,
                                    style: pw.TextStyle(fontSize: 15.sp),
                                  ),
                                  pw.Text(
                                    inventoryTask.taskTime,
                                    style: pw.TextStyle(fontSize: 15.sp),
                                  )
                                ]),
                            pw.Divider(height: 0.1),
                            pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text(
                                    'Done By'.tr,
                                    style: pw.TextStyle(fontSize: 15.sp),
                                  ),
                                  pw.Text(
                                    inventoryTask.madeBy,
                                    style: pw.TextStyle(fontSize: 15.sp),
                                  )
                                ]),
                            pw.Divider(height: 0.1),
                            pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text(
                                    'Task Type'.tr,
                                    style: pw.TextStyle(fontSize: 15.sp),
                                  ),
                                  pw.Text(
                                    inventoryTask.taskType,
                                    style: pw.TextStyle(fontSize: 15.sp),
                                  )
                                ]),
                            pw.Divider(height: 0.1),
                            if (inventoryTask.taskType == "New Task")
                              pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      'Order By'.tr,
                                      style: pw.TextStyle(fontSize: 15.sp),
                                    ),
                                    pw.Text(
                                      inventoryTask.orderBy,
                                      style: pw.TextStyle(fontSize: 15.sp),
                                    )
                                  ]),
                          ])),
                      pw.SizedBox(height: 10.h),
                      pw.Container(
                        padding: pw.EdgeInsets.only(left: 25.w, right: 25.w),
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(),
                        ),
                        child: pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                'Product'.tr,
                                style: pw.TextStyle(fontSize: 15.sp),
                              ),
                              pw.Text(
                                'Quantity'.tr,
                                style: pw.TextStyle(fontSize: 15.sp),
                              )
                            ]),
                      ),
                      pw.SizedBox(height: 10.h),
                      for (int i = 0;
                          i <
                              (inventoryTask.inventoryProduct.length > 5
                                  ? 5
                                  : inventoryTask.inventoryProduct.length);
                          i++)
                        pw.Container(
                          padding: pw.EdgeInsets.only(left: 25.w, right: 25.w),
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                          ),
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text(
                                  inventoryTask.inventoryProduct[i].product,
                                  style: pw.TextStyle(fontSize: 15.sp),
                                ),
                                pw.Text(
                                  "${inventoryTask.inventoryProduct[i].prAmount}",
                                  style: pw.TextStyle(fontSize: 15.sp),
                                )
                              ]),
                        ),
                      if (inventoryTask.inventoryProduct.length > 5)
                        pw.Container(
                            padding:
                                pw.EdgeInsets.only(left: 25.w, right: 25.w),
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(),
                            ),
                            child: pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text(
                                    '.....'.tr,
                                    style: pw.TextStyle(fontSize: 15.sp),
                                  ),
                                  pw.Text(
                                    '....'.tr,
                                    style: pw.TextStyle(fontSize: 15.sp),
                                  )
                                ])),
                      pw.Container(
                          padding: pw.EdgeInsets.only(left: 25.w, right: 25.w),
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(),
                          ),
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text(
                                  'All Product'.tr,
                                  style: pw.TextStyle(fontSize: 15.sp),
                                ),
                                pw.Text(
                                  '${inventoryTask.inventoryProduct.length}'.tr,
                                  style: pw.TextStyle(fontSize: 15.sp),
                                )
                              ])),
                      // pw.SizedBox(height: 20),
                      pw.Column(children: [
                        pw.SizedBox(height: 10.h),
                        pw.Container(
                            padding:
                                pw.EdgeInsets.only(left: 25.w, right: 25.w),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(children: [
                              pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      'Report Created By'.tr,
                                      style: pw.TextStyle(fontSize: 15.sp),
                                    ),
                                    pw.Text(
                                      reportMadeBy,
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(fontSize: 15.sp),
                                    )
                                  ]),
                              pw.Divider(height: 0.1),
                              pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      'Report Created Day'.tr,
                                      style: pw.TextStyle(fontSize: 15.sp),
                                    ),
                                    pw.Text(
                                      (DateFormat('yyyy-MM-dd')
                                          .format(DateTime.now())
                                          .toString()),
                                      // widget.reportMadeBy,
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(fontSize: 15.sp),
                                    )
                                  ]),
                              pw.Divider(height: 0.1),
                              pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                      'Report Created Time'.tr,
                                      style: pw.TextStyle(fontSize: 15.sp),
                                    ),
                                    pw.Text(
                                      DateTime.now().hour.toString() +
                                          ':' +
                                          DateTime.now().minute.toString(),
                                      // widget.reportMadeBy,
                                      textAlign: pw.TextAlign.center,
                                      style: pw.TextStyle(fontSize: 15.sp),
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
