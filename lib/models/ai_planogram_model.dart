class  AiPlanogramModel{

  final String degree;
  final String imagePath;
  final String madeBy,taskDate,taskTime, branch, market,status;
  final String orderBy ,taskType;
  final String place;

   AiPlanogramModel( {
     required this.place,
     required this.orderBy,
    required this.taskDate,
    required this.branch,
    required this.market,
    required this.madeBy,
     required this.taskType,
    required this.degree,
    required this.imagePath,
    required this.status,
    required this.taskTime,

  });

  Map<String, dynamic> tojson() => {
    "place":place,
    "degree": degree,
    "image_path": imagePath,
    "made_by": madeBy,
    "task_type":taskType,
    "branch": branch,
    "market": market,
    "status": status,
    "task_date":taskDate,
    "task_time":taskTime,
    "order_by":orderBy

  };

  static   AiPlanogramModel fromJson(Map<String, dynamic> json) =>
       AiPlanogramModel(
         taskType: json['task_type'],
         place:json['place'],
         orderBy: json['order_by'],
        taskDate: json['task_date'],
        taskTime: json['task_time'],
        status: json['status'],
        madeBy: json['made_by'],
        degree: json['degree'],
        imagePath: json['image_path'],
        branch: json['branch'],
        market: json['market'],


      );




}
List<String>completedPlanogramTasks=[];
List<String>workingOnPlanogramTasks=[];

