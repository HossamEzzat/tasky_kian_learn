class TaskModel {
  String taskName;
  String taskDesc;

  TaskModel({required this.taskName, required this.taskDesc});
  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      TaskModel(taskName: json["name"], taskDesc: json["desc"]);
  toMap() {
    return {"name": taskName, "desc": taskDesc};
  }
}
