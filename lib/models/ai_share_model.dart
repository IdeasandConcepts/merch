class AiShareModel{
  final double degree;
  final String imagePath;
  final String madeBy,taskDate,taskTime, branch, market,status;
  final String selectedProducts,place,orderBy,taskType;
  final double markerArea,fullArea;

   AiShareModel({
       required this.orderBy,
    required this.taskDate,
    required this.branch,
    required this.market,
    required this.madeBy,
   required this.fullArea,
    required this.markerArea,
    required this.degree,
    required this.imagePath,
    required this.place,
    required this.status,
    required this.taskTime,
    required this.selectedProducts,
    required this.taskType,

  });

  Map<String, dynamic> tojson() => {
    'task_type':taskType,
    'order_by':orderBy,
       "full_area": fullArea,
        "marker_area": markerArea,
        "degree": degree,
        "image_path": imagePath,
        "place": place,
        "made_by": madeBy,
        "branch": branch,
        "market": market,
        "status": status,
    "task_date":taskDate,
    "task_time":taskTime,
    "selected_product":selectedProducts

   
  };

  static  AiShareModel fromJson(Map<String, dynamic> json) =>
       AiShareModel(
           taskType:json['task_type'],
         orderBy: json['order_by'],
        taskDate: json['task_date'],
        taskTime: json['task_time'],
        status: json['status'],
        fullArea: json['full_area'],
        markerArea: json['marker_area'],
        madeBy: json['made_by'],
        degree: json['degree'],
        imagePath: json['image_path'],
        place: json['place'],
        branch: json['branch'],
        market: json['market'],
        selectedProducts: json["selected_product"]
       

      );




}


