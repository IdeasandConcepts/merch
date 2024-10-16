class ProductsByPiece {
  final String photo,
      productCategory,
      productDetails,
      productItemCode,
      productName;
  final int id, productSize;

  ProductsByPiece(
      {
    required this.photo,
    required this.productSize,
    required this.productDetails,
    required this.productName,
    required this.productCategory,
    required this.productItemCode,
    required this.id,
  });

  Map<String, dynamic> tojson() => {
        "photo": photo,
        "id": id,
        "weight": productSize,
        "product_details": productDetails,
        "product_name": productName,
        "category": productCategory,
        "product_item_code": productItemCode,
      };

  static ProductsByPiece fromJson(Map<String, dynamic> json) => ProductsByPiece(
        id: json['id'],
        photo: json['photo'],
        productDetails: json['product_details'],
        productName: json['product_name'],
        productCategory: json['category'],
        productItemCode: json['product_item_code'],
        productSize: json['weight'],
      );
}
