class ManagerModel {
  /// login
  final String  email;
  /// main data
  final String full_name,  profile_image,nationality, birthday;
  final int phone,id,manager_id;
  /// working deatails
  final String market, city;

  ManagerModel({
    required this.manager_id,
    required this.full_name,
    required this.email,
    required this.market,
    required this.profile_image,
    required this.city,
    required this.nationality,
    required this.phone,
    required this.id,
    required this.birthday,
  });
  Map<String, dynamic> tojson() => {
        "manager_id":manager_id,
        "market": market,
        "profile_image": profile_image,
        "id": id,
        "phone": phone,
        "nationality": nationality,
        "birthday": birthday,
        "city": city,
        "full_name": full_name,
        "email": email,
      };

  static ManagerModel fromJson(Map<String, dynamic> json) => ManagerModel(
        profile_image: json['profile_image'],
        id: json['id'],
        phone: json['phone'],
        nationality: json['nationality'],
        birthday: json['birthday'],
        city: json['city'],
        market: json['market'],
        full_name: json['full_name'],
        email: json['email'],
      manager_id:json['manager_id']
      );
}
