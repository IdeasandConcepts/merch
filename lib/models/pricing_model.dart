
import 'package:arrow_merchandising/models/pricing_product.dart';

class PricingTask {
 final List<PricingProduct> pricingProduct;
 final String place;
final String orderBy;
final String taskType;
final String market;
final String branch;
final String madeBy;
final String taskTime;
final String taskDate;
final String status;

PricingTask({
required this.place,
required this.pricingProduct,
required this.taskTime,
  required this.taskDate,
required this.market,
required this.branch,
required this.madeBy,
required this.orderBy,
required this.status,
 required this.taskType,
});

factory PricingTask.fromMap(Map<String, dynamic> map) {
return PricingTask(
  place: map['place'],
  taskType: map['task_type'],
orderBy: map['order_by'],
  market: map['market'],
branch: map['branch'],
madeBy: map['made_by'],
  taskDate:map['task_date'],
  taskTime: map['task_time'],
status: map['status'],
  pricingProduct: (map['offers'] as List)
      .map((data) => PricingProduct.fromMap(data)).toList(),
);
}

Map<String, dynamic> toMap() {
return {
  'offers':pricingProduct.map((e)=>e.toMap()).toList(),
'order_by':orderBy,
  'place':place,
  'task_type':taskType,
  'task_time':taskTime,
'market': market,
'branch': branch,
'made_by': madeBy,
'task_date': taskDate,
'status': status,
};
}
}
