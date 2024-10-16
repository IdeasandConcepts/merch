

import 'package:arrow_merchandising/view/widgets/inventory_product_widget.dart';
import 'package:arrow_merchandising/models/inventory_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';


class InventoryChartBody extends StatefulWidget {
  final int id, phone,managerPhone;
  final String username,
      marketImage,
      profileImage,
      branch,
      market,
      nationality;
  final String place;
  final String comeFrom;
  const InventoryChartBody(
      {super.key,
        required this.place,
        required this.username,
        required this.marketImage,
        required this.profileImage,
        required this.branch,
        required this.market,
        required this.id,
        required this.phone,
        required this.nationality,
        required this.comeFrom,
        required this.managerPhone,
      });

  @override
  State<InventoryChartBody> createState() => _InventoryChartBodyState();
}

class _InventoryChartBodyState extends State<InventoryChartBody> {

  bool startProgress=false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:(widget.comeFrom=="Normal")?
      (MediaQuery.of(context).size.height / 2.4).h:
      (MediaQuery.of(context).size.height * 0.84),

      child: ListView.builder(
        itemCount:  inventoryTaskDetails.length,
        itemBuilder: (context, index) =>
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Dismissible(
                  key: Key(  inventoryTaskDetails[index].toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      inventoryTaskDetails.removeAt(index);
                    });
                  },
                  background: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        //Color(0xFFFFF6E6),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(children: [
                      Spacer(),
                      SvgPicture.asset("assets/icons/Trash.svg")
                    ]),
                  ),
                  child:
                  InventoryProductWidget(
                    merchTask:   inventoryTaskDetails[index],
                    // place: widget.place,
                    // index:  index,

                  )),
            ),
      ),
    );
  }
}