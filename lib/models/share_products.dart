

import 'dart:io';

class ShareProducts {
  final String prCategory , product, pType,barCode;
  final int prAmount;

  ShareProducts({
    required this.prCategory,
    required this.product,
    required this.prAmount,
    required this.pType,
    required this.barCode,
  });

  Map<String, dynamic> toMap() {
    return {
      "bar_code":barCode,
      "p_type": pType,
      "product_category": prCategory,
      "product": product,
      "return_amount": prAmount,
    };
  }
  factory ShareProducts.fromMap(Map<String, dynamic> map) {
    return   ShareProducts(
      barCode:map['bar_code'],
      prCategory: map['product_category'],
      product: map['product'],
      pType: map['p_type'],
      prAmount: map['return_amount'],
    );
  }
}

List<String>completeShareTasks=[];
List<String>workingOnShare=[];
List<String> displayShareTypes=[];
List <ShareProducts>shareTaskDetails =[];
List<File?> displaySharePhotos=[];



void addUserShareDetails(
    {
      required String prCategory,
      required String product,
      required int prAmount,
      required String pType,
      required String barCode,
    })
{
  final newDetails=ShareProducts(
    barCode:barCode,
    prCategory: prCategory,
    product: product,
    prAmount: prAmount,
    pType: pType,
  );

  shareTaskDetails.add(newDetails);
}
