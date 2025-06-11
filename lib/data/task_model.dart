class TaskModel {
  final String taskName;
  final String time;
  String? notes;
  String? attachments;

  TaskModel({
    required this.taskName,
    required this.time,
    this.notes,
    this.attachments
  });
}