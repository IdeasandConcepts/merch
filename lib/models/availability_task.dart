
import 'package:arrow_merchandising/models/availability_products.dart';

class AvailabilityTaskModel {
  final String branch, market, taskDate,
      taskTime, madeBy,
      status;
  final List<AvailabilityProduct> availabilityProduct;
  final String place;
  final String photo;
  final String orderBy,taskType;


  AvailabilityTaskModel( {
  required this.orderBy,
     required this.place,
   required this.taskType,
    required this.photo,
    required this.market,
    required this.branch,
    required this.availabilityProduct,
    required this.madeBy,
    required this.taskDate,
    required this.status,
    required this.taskTime,
  });

  Map<String, dynamic> toMap() {
    return {

      'order_by':orderBy,
      'task_type':taskType,
      'market': market,
      'branch': branch,
      'made_by': madeBy,
      'date': taskDate,
      'status': status,
      'time': taskTime,
      'photo': photo,
       "place": place,
      'products':availabilityProduct.map((e) => e.toMap()).toList(),
    };
  }

  factory AvailabilityTaskModel.fromMap(Map<String, dynamic> map) {
    return AvailabilityTaskModel(
taskType: map['task_type'],
      orderBy: map['order_by'],
      market: map['market'],
      branch: map['branch'],
      madeBy: map['made_by'],
      taskDate: map['date'],
      status: map['status'],
      taskTime: map['time'],
      photo: map['photo'],
      place:map["place"],
      availabilityProduct: (map['products'] as List)
          .map((data) => AvailabilityProduct.fromMap(data)).toList(),

    );
  }
}