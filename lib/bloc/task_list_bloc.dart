import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kodanewtask/bloc/task_list_event.dart';
import 'package:kodanewtask/bloc/task_list_state.dart';
import 'package:kodanewtask/data/task_model.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  List<TaskModel> _tasks = [];

  TaskListBloc() : super(TaskListInitial()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<DeleteTask>(_onDeleteTask);
    on<UpdateTask>(_onUpdateTask);
    on<RefreshTasks>(_onRefreshTasks);
  }

  void _onLoadTasks(LoadTasks event, Emitter<TaskListState> emit) async {
    emit(TaskListLoading());

    try {
      // Use provided tasks or default empty list
      _tasks = event.initialTasks ?? [];

      // Simulate loading delay (remove in production)
      await Future.delayed(const Duration(milliseconds: 300));

      emit(TaskListLoaded(List.from(_tasks)));
    } catch (e) {
      emit(TaskListError('Failed to load tasks: ${e.toString()}'));
    }
  }

  void _onAddTask(AddTask event, Emitter<TaskListState> emit) {
    if (state is TaskListLoaded) {
      _tasks.add(event.task);
      emit(TaskListLoaded(List.from(_tasks)));
    }
  }

  void _onDeleteTask(DeleteTask event, Emitter<TaskListState> emit) {
    if (state is TaskListLoaded && event.index >= 0 && event.index < _tasks.length) {
      _tasks.removeAt(event.index);
      emit(TaskListLoaded(List.from(_tasks)));
    }
  }

  void _onUpdateTask(UpdateTask event, Emitter<TaskListState> emit) {
    if (state is TaskListLoaded && event.index >= 0 && event.index < _tasks.length) {
      _tasks[event.index] = event.task;
      emit(TaskListLoaded(List.from(_tasks)));
    }
  }

  void _onRefreshTasks(RefreshTasks event, Emitter<TaskListState> emit) {
    emit(TaskListLoaded(List.from(_tasks)));
  }
}