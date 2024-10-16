


class InventoryProduct {
  final String prCategory , product, image;
   int prAmount;
   final int weight;

  InventoryProduct({
    required this.prCategory,
    required this.product,
    required this.prAmount,
   required this.weight,
    required this.image
});

  Map<String, dynamic> toMap() {
    return {
      "image":image,
      "weight": weight,
      "category": prCategory,
      "product": product,
      "amount": prAmount,
    };
  }
  factory InventoryProduct.fromMap(Map<String, dynamic> map) {
 return   InventoryProduct(
   image: map['image'],
      prCategory: map['category'],
      product: map['product'],
      weight: map['weight'],
      prAmount: map['amount'],
    );
  }
}
List<String>selectedInventoryProducts=[];

List <InventoryProduct>inventoryTaskDetails =[];
List<String>workingOnInventory=[];
List<String>completeInventoryTasks=[];


void addUserCartDetails(
    {
     required String prCategory,
      required String product,
      required int prAmount,
     required int weight,
      required String image,
    })
{
  final newDetails=InventoryProduct(
    image: image,
    prCategory: prCategory,
    product: product,
    prAmount: prAmount,
   weight: weight,
  );

  inventoryTaskDetails.add(newDetails);
}

