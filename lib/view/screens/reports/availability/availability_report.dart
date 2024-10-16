import 'package:arrow_merchandising/view/components/default_button.dart';
import 'package:arrow_merchandising/view/screens/reports/availability/availability_report_pdf.dart';
import 'package:arrow_merchandising/view/screens/super_visor/super_app_bar.dart';
import 'package:arrow_merchandising/models/availability_task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:arrow_merchandising/const.dart';



class AndroidAvailabilityReport extends StatefulWidget {
  // final CapturePhotos availability;
  final AvailabilityTaskModel availability;
  //final InventoryReport inventoryReport;
  final int id, phone;
  final String profileImage,
      username,
      branch,
      market,
      marketImage,
      nationality,
      role;
  //marketDetails;
  // final String firstphoto, secondphoto;

  const AndroidAvailabilityReport(
      {super.key,
      // required this.title,
      // required this.firstphoto,
      // required this.secondphoto,
      //required this.marketImage,
      required this.profileImage,
      required this.username,
      required this.branch,
      required this.market,
      required this.id,
      required this.phone,
      required this.nationality,
      required this.marketImage,
      required this.role,
      required this.availability});

  @override
  State<AndroidAvailabilityReport> createState() =>
      _AndroidAvailabilityReportState();
}

class _AndroidAvailabilityReportState extends State<AndroidAvailabilityReport>
//  with TickerProviderStateMixin {
{
  bool viewNotAvailable = false;
  List<String> allProducts = [];
  List<String> notAvailableProducts = [];
  List<String> merchandisers = [];

  Future getId() async {
    await FirebaseFirestore.instance
        .collection("arrow_products")
        .orderBy("id", descending: true)
        .limit(700)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection("arrow_products")
            .doc(element.reference.id)
            .get()
            .then((value) {
          Map<String, dynamic> data = value.data() as Map<String, dynamic>;
          if (!allProducts
              .contains(data['product_name'] + "_" + '${data['weight']}')) {
            setState(() {
              // if (!allProducts
              //     .contains(data['product_name']
              //    // + "_" + '${data['weight']}'
              //   )
              // )
              allProducts.add(data['product_name'] + "_" + '${data['weight']}');
            });
          }
        });
      });
    });
    print(allProducts.length);
    //setState(() {
    //  filtterProduct();
    //});
  }

  void filtterProduct() {
    setState(() {
      for (int j = 0; j < widget.availability.availabilityProduct.length; j++) {
        //  for (int i = j; i <allProducts.length; i++)
        if
            //(widget.availability.availabilityProduct[i].product !=
            (allProducts[j] !=
                widget.availability.availabilityProduct[j].product) {
          if (notAvailableProducts[j] != allProducts[j])
            notAvailableProducts.add(allProducts[j]);
        }
      }
      print(allProducts.length);
      print(widget.availability.availabilityProduct.length);
      print(notAvailableProducts.length);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TabController controller = TabController(length: 2, vsync: this);
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kprimaryColor,
          title: SuperAppBar(
            comeFrom: "report",
            // appBar: MerchAppBar(
            title: "Availability Report",
            //manegerName: widget.manegerName,
            phone: widget.phone,
            market: widget.market,
            marketImage: widget.marketImage,
            branch: widget.branch,
            username: widget.username,
            profileImage: widget.profileImage,
          )),
      body: ListView(shrinkWrap: true, children: <Widget>[
        SizedBox(height: 10.h),
        // here is our code :-
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              right: 15.w,
              left: 15.w,
            ),
            child: Column(
              children: [
                Container(
                  width: 330.w,
                  //padding: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: kprimaryColor.withOpacity(0.45),
                      borderRadius:
                          // border: BorderRadius.circular(15)
                          // border
                          BorderRadius.circular(15)),
                  child: DataTable(
                      dataTextStyle: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.bold),
                      //showBottomBorder: true,
                      //border: TableBorder.all(),
                      //columnSpacing: 12,
                      columns: [
                        DataColumn(
                            label: Text(
                          'Market'.tr.toUpperCase(),
                          //   style: const TextStyle(fontSize: 18,color: Colors.black87),
                        )),
                        DataColumn(
                            label: Text(
                          widget.availability.market,
                          // style: const TextStyle(fontSize: 18,color: Colors.black87),
                        )),
                      ],
                      rows: [
                        DataRow(cells: <DataCell>[
                          DataCell(Text(
                            'Branch'.tr.toUpperCase(),
                            style: TextStyle(
                                fontSize: 13.sp, color: Colors.black87),
                          )

                              // Text(merchandiserName)
                              ),
                          DataCell(Text(
                            widget.availability.branch,
                            style: TextStyle(
                                fontSize: 13.sp, color: Colors.black87),
                          )),
                        ]),
                        DataRow(cells: <DataCell>[
                          DataCell(Text(
                            'Task Type'.tr.toUpperCase(),
                            style: TextStyle(
                                fontSize: 13.sp, color: Colors.black87),
                          )

                            // Text(merchandiserName)
                          ),
                          DataCell(Text(
                            widget.availability.taskType,
                            style: TextStyle(
                                fontSize: 13.sp, color: Colors.black87),
                          )),
                        ]),
                        if(widget.availability.taskType=="New Task")
                        DataRow(cells: <DataCell>[
                          DataCell(Text(
                            'Order By'.tr.toUpperCase(),
                            style: TextStyle(
                                fontSize: 13.sp, color: Colors.black87),
                          )

                            // Text(merchandiserName)
                          ),
                          DataCell(Text(
                            widget.availability.orderBy,
                            style: TextStyle(
                                fontSize: 13.sp, color: Colors.black87),
                          )),
                        ]),
                      ]),
                ),

                SizedBox(
                  height: 10.h,
                ),
                // for(int i=0; i<widget.availability.availabilityProduct.length; i++)
                Container(
                  width: 330.w,
                  //padding: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: kprimaryColor.withOpacity(0.45),
                      borderRadius:
                          // border: BorderRadius.circular(15)
                          // border
                          BorderRadius.circular(15)),
                  child: DataTable(
                      dataTextStyle: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.bold),
                      columns: [
                        DataColumn(
                            label: Text(
                          'Product'.tr.toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.sp,
                              color: Colors.black87),
                        )),
                        DataColumn(
                            label: Text(
                          'Status'.tr.toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.sp,
                              color: Colors.black87),
                        )),
                      ],
                      rows: [
                        for (int i = 0;
                            i <
                                widget
                                    .availability.availabilityProduct.length;
                            i++)
                          DataRow(cells: <DataCell>[
                            DataCell(Text(
                              '${widget.availability.availabilityProduct[i].product}'
                                  .toUpperCase(),
                              style: TextStyle(
                                  fontSize: 10.sp, color: Colors.black87),
                            )

                                // Text(merchandiserName)
                                ),
                            DataCell(Text(
                              // 'status'.tr+
                              '${(widget.availability.availabilityProduct[i].prAmount > 5) ? "High Stock" : "Low Stock"}' +
                                  '\t',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp,
                                  color: Colors.black87),
                            )),
                          ]),
                        DataRow(cells: <DataCell>[
                          DataCell(Text(
                            "All products".tr,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp,
                                color: Colors.black87),
                          )

                              // Text(merchandiserName)
                              ),
                          DataCell(Text(
                            // 'status'.tr+
                            '${widget.availability.availabilityProduct.length}' +
                                "\t" +
                                "products".tr,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp,
                                color: Colors.black87),
                          )),
                        ]),
                      ]),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 30.w, right: 30.w, top: 10.h),
                  child: Divider(),
                ),
                Container(
                  width: 330.w,
                  //padding: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: kprimaryColor.withOpacity(0.45),
                      borderRadius:
                          // border: BorderRadius.circular(15)
                          // border
                          BorderRadius.circular(15)),
                  child: DataTable(
                      dataTextStyle: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.bold),
                      columns: [
                        DataColumn(
                            label: Text(
                          'Done By'.tr.toUpperCase(),
                          //   style: const TextStyle(fontSize: 18,color: Colors.black87),
                        )),
                        DataColumn(
                            label: Text(
                          widget.availability.madeBy,
                          // style: const TextStyle(fontSize: 18,color: Colors.black87),
                        )),
                      ],
                      rows: [
                        DataRow(cells: <DataCell>[
                          DataCell(Text(
                            'Date'.tr.toUpperCase(),
                            style: TextStyle(
                                fontSize: 13.sp, color: Colors.black87),
                          )),
                          DataCell(Text(
                            widget.availability.taskDate,
                            style: TextStyle(
                                fontSize: 13.sp, color: Colors.black87),
                          )),
                        ]),
                        DataRow(cells: <DataCell>[
                          DataCell(Text(
                            'Time'.tr.toUpperCase(),
                            style: TextStyle(
                                fontSize: 13.sp, color: Colors.black87),
                          )),
                          DataCell(Text(
                            widget.availability.taskTime,
                            style: TextStyle(
                                fontSize: 13.sp, color: Colors.black87),
                          )),
                        ]),
                      ]),
                ),
                // SizedBox(
                //   height: 20,
                // ),
              ],
            ),
          ),
        )
      ]),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
        child: MaterialButton(
          onPressed: () {
            Get.to(() => AndroidAvailabilityPdfReports(
                  availability: widget.availability,
                  reportMadeBy: widget.username,
                ));
            // Save Data ....
          },
          child: DefualtButton(
            selected: true,
            text: 'Create a pdf',
          ),
        ),
      ),
    );
  }

  // Future createTask(NewAvailabilityTaskModel task) async {
  //   final taskData =
  //       FirebaseFirestore.instance.collection('New Availability Tasks').doc();
  //   final json = task.toMap();
  //   await taskData.set(json);
  //   //  final
  // }

  // Future<void> navigateTo(double lat, double lng) async {
  //   try {
  //     var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
  //     //  if (await canLaunch(uri.toString())) {
  //     await launch(uri.toString());
  //     // } else {
  //     // throw 'Could not launch ${uri.toString()}';
  //     // }
  //   } catch (e) {
  //     throw "Could not launch " + e.toString();
  //   }
  //   // try(){}catch(e){
  //   //
  //   // }
  //}
}
