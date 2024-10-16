

class CapturePhotos {
  final String product;
   final String place;
  final String taskTime;
 final List<String> images;
  final String title;


  CapturePhotos({
    required this.product,
    required this.taskTime,
     required this.place,
    required this.images,
   required this.title,

  });

  factory CapturePhotos.fromMap(Map<String, dynamic> map) {
    return CapturePhotos(
      product:map['product'],
      place: map['place'],
      taskTime: map['task_time'],
      images: List<String>.from(map['images']),
      title: map['title'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product':product,
      'task_time':taskTime,
       'place': place,
      'images': images,
      'title': title,
    };
  }
}
List<String> completeFirstOrderingTask=[];
List<CapturePhotos> firstVisitTask=[];
List<String> completeLastOrderingTask=[];
List<CapturePhotos> lastVisitTask=[];









