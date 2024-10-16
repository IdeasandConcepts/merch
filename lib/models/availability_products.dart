
//
class AvailabilityProduct {
  final String prCategory , product, image;
  int prAmount;
  final int weight;

  AvailabilityProduct({
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
  factory AvailabilityProduct.fromMap(Map<String, dynamic> map) {
  return   AvailabilityProduct(
  image: map['image'],
  prCategory: map['category'],
  product: map['product'],
  weight: map['weight'],
  prAmount: map['amount'],
  );
  }
  }
List<String>selectedAvailabilityProducts=[];
List <bool> availabilityStartProgressList=[];
List <AvailabilityProduct>availabilityTaskDetails =[];

List<String>completeAvailabilityTasks=[];
 List<String>workingOnAvailability=[];



void addUserRTvDetails(
    {
      required String prCategory,
      required String product,
      required int prAmount,
      required int weight,
      required String image,

    })
{
  final newDetails=AvailabilityProduct(
    weight:weight,
    prCategory: prCategory,
    product: product,
    prAmount: prAmount,
    image: image,
  );

  availabilityTaskDetails.add(newDetails);
}
