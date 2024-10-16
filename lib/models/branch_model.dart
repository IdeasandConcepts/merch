
class Branch {
  final String customerName;
  final int marketId;


  Branch(
      {
        required this.marketId,
        required this.customerName,

  });
  Map<String, dynamic> tojson() => {
    "branch_name": customerName,
    "branch_id": marketId,
  };

  static Branch fromJson(Map<String, dynamic> json) => Branch(
    customerName: json['branch_name'],
    marketId: json['branch_id'],
  );
}


class DailyBranch {
  // login
  final String customerName,managerName, customerCode,photo,date,day,status;
  final double gpsLat,gpsLon;
  final int marketId,merchId;


  DailyBranch(
      {
        required this.status,
        required this.managerName,
        required this.day,
        required this.customerCode,
        required this.photo,
        required this.gpsLat,
        required this.gpsLon,
        required this.marketId,
        required this.customerName,
        required this.merchId,
        required this.date

      });
  Map<String, dynamic> tojson() => {
    "status":status,
    "manager_name":managerName,
    "day":day,
    "photo":photo,
    "customer_name": customerName,
    "customer_code": customerCode,
    "gps_latitude": gpsLat,
    "gps_longitude": gpsLon,
    "market_id": marketId,
    "merch_id":merchId,
    "date":date,
  };

  static DailyBranch fromJson(Map<String, dynamic> json) => DailyBranch(
status:json['status'],
    day: json['day'],
    date:json['date'],
    merchId:json['merch_id'],
    managerName:json['manager_name'],
    photo:json['photo'],
    customerName: json['customer_name'],
    customerCode: json['customer_code'],
    marketId: json['market_id'],
    gpsLat: json['gps_latitude'],
    gpsLon: json['gps_longitude'],
  );
}

