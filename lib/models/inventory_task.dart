

import 'inventory_products.dart';

class InventoryTask {
  final String branch, market, taskDate,
      taskTime, madeBy,
      status;
  final List<InventoryProduct> inventoryProduct;
  final String orderBy,taskType;
  final String place;

  InventoryTask({
  required this.orderBy,
     required this.place,
    required this.taskType,
    required this.market,
    required this.branch,
    required this.inventoryProduct,
    required this.madeBy,
    required this.taskDate,
    required this.status,
    required this.taskTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'task_type':taskType,
      'order_by':orderBy,
      'place':place,
      'market': market,
      'branch': branch,
      'made_by': madeBy,
      'task_date': taskDate,
      'status': status,
      'task_time': taskTime,
      'inventory_product':inventoryProduct.map((e) => e.toMap()).toList(),
    };
  }

  factory InventoryTask.fromMap(Map<String, dynamic> map) {
    return InventoryTask(
      place:map['place'],
      orderBy: map['order_by'],
      taskType: map['task_type'],
      market: map['market'],
      branch: map['branch'],
      madeBy: map['made_by'],
      taskDate: map['task_date'],
      status: map['status'],
      taskTime: map['task_time'],
      inventoryProduct: (map['inventory_product'] as List)
          .map((data) => InventoryProduct.fromMap(data)).toList(),
    );
  }
}