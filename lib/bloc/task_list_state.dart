import '../data/task_model.dart';

abstract class TaskListState {}

class TaskListInitial extends TaskListState {}

class TaskListLoading extends TaskListState {}

class TaskListLoaded extends TaskListState {
  final List<TaskModel> tasks;

  TaskListLoaded(this.tasks);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TaskListLoaded &&
        other.tasks.length == tasks.length;
  }

  @override
  int get hashCode => tasks.hashCode;
}

class TaskListError extends TaskListState {
  final String message;
  TaskListError(this.message);
}