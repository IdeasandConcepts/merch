
import 'package:arrow_merchandising/models/capture_photos.dart';


class FullVisit {
  final List<CapturePhotos> before;
  final List<CapturePhotos> after;
final String orderBy;
final String market;
final String branch;
final String madeBy;
final String date;
final String taskTime;
final String status;


FullVisit({
  required this.before,
  required this.after,
  required this.orderBy,
  required this.taskTime,
  required this.market,
  required this.branch,
  required this.madeBy,
  required this.date,
  required this.status,
});

  factory FullVisit.fromMap(Map<String, dynamic> map) {
    return FullVisit(
      orderBy:map['order_by'],
      before: (map['before']as List)
          .map((data) => CapturePhotos
          .fromMap(data)).toList(),
      after: (map['after']as List) .map((data) =>
          CapturePhotos.fromMap(data)).toList(),
      market: map['market'],
      taskTime: map['task_time'],
      branch: map['branch'],
      madeBy: map['made_by'],
      date: map['date'],
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'before':before.map((e) => e.toMap()).toList(),
      'after':after.map((e) => e.toMap()).toList(),
      'task_time':taskTime,
      'market': market,
      'branch': branch,
      'made_by': madeBy,
      'date': date,
      'order_by': orderBy,
      'status': status,
    };
  }
}