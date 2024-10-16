import 'rtv_product.dart';

class RTVTaskModel {
  final String branch, market, taskDate, taskTime, madeBy, status;
  final List<RTVProduct> rtvProduct;
  final String type, place;
  final String orderBy;
  final String taskType;
  RTVTaskModel({
    required this.orderBy,
    required this.place,
    required this.type,
    required this.taskType,
    required this.market,
    required this.branch,
    required this.rtvProduct,
    required this.madeBy,
    required this.taskDate,
    required this.status,
    required this.taskTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'order_by': orderBy,
      'place': place,
      'market': market,
      'branch': branch,
      'made_by': madeBy,
      'task_date': taskDate,
      'type': type,
      'status': status,
      'task_time': taskTime,
      "task_type": taskType,
      'rtv_products': rtvProduct.map((e) => e.toMap()).toList(),
    };
  }

  factory RTVTaskModel.fromMap(Map<String, dynamic> map) {
    return RTVTaskModel(
      taskType: map['task_type'],
      orderBy: map['order_by'],
      place: map['place'],
      market: map['market'],
      branch: map['branch'],
      madeBy: map['made_by'],
      taskDate: map['task_date'],
      type: map['type'],
      status: map['status'],
      taskTime: map['task_time'],
      rtvProduct: (map['rtv_products'] as List)
          .map((data) => RTVProduct.fromMap(data))
          .toList(),
    );
  }
}
