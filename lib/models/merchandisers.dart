class Merchandiser {
  /// login
  final String  email;
  /// main data
  final String fullName, nationality, birthday;
  final int phone, id,merchId;
  /// working deatails
  final String profileImage,status, market,
      marketImage, jopStartingDay, carDetails, city;

  Merchandiser({
    required this.merchId,
    required this.status,
    required this.fullName,
    required this.email,
    required this.marketImage,
    required this.jopStartingDay,
    required this.market,
    required this.profileImage,
    required this.carDetails,
    required this.city,
    required this.nationality,
    required this.phone,
    required this.id,
    required this.birthday,
  });
  Map<String, dynamic> tojson() => {
    "merch_id":merchId,
    "status":status,
        "market": market,
        "market_image": marketImage,
        "profile_image": profileImage,
        "id": id,
        "phone": phone,
        "nationality": nationality,
        "birthday": birthday,
        "city": city,
        "jop_starting_day": jopStartingDay,
        "car_details": carDetails,
        "full_name": fullName,
        "email": email,
      };

  static Merchandiser fromJson(Map<String, dynamic> json) => Merchandiser(
    merchId:json['merch_id'],
    status: json['status'],
        profileImage: json['profile_image'],
        id: json['id'],
        phone: json['phone'],
        nationality: json['nationality'],
        birthday: json['birthday'],
        city: json['city'],
        jopStartingDay: json['jop_starting_day'],
        carDetails: json['car_details'],
        market: json['market'],
        fullName: json['full_name'],
        email: json['email'],
        marketImage: json['market_image'],
      );


}
