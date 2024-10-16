
class SuperMarket {
  final String customerName, photo;
  final int customerId;

  SuperMarket({
    required this.customerName,
    required this.customerId,
    required this.photo
  });
  Map<String, dynamic> tojson() => {
    "market_name": customerName,
    "market_image": photo,
    "market_id": customerId,
  };

  static SuperMarket fromJson(Map<String, dynamic> json) => SuperMarket(
    customerName: json['market_name'],
    customerId: json['market_id'],
    photo: json['market_image'],
  );
}

