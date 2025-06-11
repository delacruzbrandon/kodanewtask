import '../data/task_model.dart';

abstract class TaskListEvent {}

class LoadTasks extends TaskListEvent {
  final List<TaskModel>? initialTasks;
  LoadTasks({this.initialTasks});
}

class AddTask extends TaskListEvent {
  final TaskModel task;
  AddTask(this.task);
}

class DeleteTask extends TaskListEvent {
  final int index;
  DeleteTask(this.index);
}

class UpdateTask extends TaskListEvent {
  final int index;
  final TaskModel task;
  UpdateTask(this.index, this.task);
}

class RefreshTasks extends TaskListEvent {}