

class RTVProduct {
  final String prCategory , product,image,
      rType,
      barCode;
   int prAmount;

  RTVProduct({
    required this.prCategory,
    required this.product,
    required this.prAmount,
    required this.image,
    required this.rType,
    required this.barCode,
  });

  Map<String, dynamic> toMap() {
    return {
      "bar_code":barCode,
      "image": image,
      "product_category": prCategory,
      "product": product,
      "return_type":rType,
      "return_amount": prAmount,
    };
  }
  factory RTVProduct.fromMap(Map<String, dynamic> map) {
    return   RTVProduct(
      rType: map['return_type'],
      barCode:map['bar_code'],
      prCategory: map['product_category'],
      product: map['product'],
      image: map['image'],
      prAmount: map['return_amount'],
    );
  }
}



List <RTVProduct>rTVTaskDetails =[];
List <String>selectedRtvDetailsList=[];
List<String>completeRtvTasks=[];
List<String>workingOnRtv=[];


void addUserRTvDetails(
    { required String rtype,
      required String prCategory,
      required String product,
      required int prAmount,
      required String image,
      required String barCode,

    })
{
  final newDetails=RTVProduct(
    barCode:barCode,
    prCategory: prCategory,
    product: product,
    prAmount: prAmount,
    image: image,
    rType: rtype
  );

  rTVTaskDetails.add(newDetails);
}
