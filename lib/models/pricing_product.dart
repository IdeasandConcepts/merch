
class PricingProduct {
  final double price;
  final String category;
  final String details;
  final String product;
  final List<String> images;

  PricingProduct({
    required this.price,
    required this.category,
    required this.details,
    required this.product,
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return {
      'details':details,
      'category':category,
      'price':price,
      'product':product,
      'images': images,
    };
  }
  factory PricingProduct.fromMap(Map<String, dynamic> map) {
    return   PricingProduct(
      details: map['details'],
      category:map['category'],
      price:map['price'],
      product: map['product'],
      images: List<String>.from(map['images']),
    );
  }
}
List<String>selectedPricingProducts=[];
List <PricingProduct>offersTaskDetails =[];


List<String>workingOnOffers=[];
List<String>completeOffersTasks=[];

void addOfferCartDetails(
    {
      required double price,
      required String category,
      required String details,
      required String product,
      required List<String>images,
    })
{
  final newDetails=PricingProduct(
    images: images,
    category: category,
    product: product,
    price: price  ,
    details: details
  );

  offersTaskDetails.add(newDetails);
}

