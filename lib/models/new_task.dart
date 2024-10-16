import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class NewAllTask {
  final DateTime date;
  final String madeBy,
      branch, market,
      details, status,
      place ,title,merchandiser;
  final int taskIndex;


  NewAllTask( {
 required this.taskIndex,
    required this.place,
    required this.branch,
    required this.merchandiser,
    required this.details,
    required this.market,
    required this.madeBy,
    required this.date,
    required this.status,
    required this.title,
  });

  Map<String, dynamic> tojson() => {
    "index":taskIndex,
    "title":title,
    "place":place,
    "status":status,
    "made_by": madeBy,
    "details": details,
    "date":date,
    "branch": branch,
    "market": market,
    "merchandiser": merchandiser
  };

  static NewAllTask fromJson(Map<String, dynamic> json) =>
      NewAllTask(
        taskIndex: json['index'],
        title:json['title'],
        place:json['place'],
        merchandiser:json['merchandiser'],
        status: json['status'],
        details: json['details'],
        madeBy: json['made_by'],
        date:DateTime.parse(
           DateFormat('yyyy-MM-dd').format
              ((json['date'] as Timestamp).toDate())),
        branch: json['branch'],
        market: json['market'],
      );
}