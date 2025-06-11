
import 'package:bloc/bloc.dart';
import 'package:kodanewtask/data/task_model.dart';

import 'new_task_event.dart';
import 'new_task_state.dart';

class NewTaskBloc extends Bloc<NewTaskEvent, NewTaskState> {
  NewTaskBloc() : super(NewTaskState(time: DateTime.now())) {
    on<TaskNameChanged>(_onTaskNameChanged);
    on<TimeChanged>(_onTimeChanged);
    on<NotesChanged>(_onNotesChanged);
    on<AttachmentAdded>(_onAttachmentAdded);
    on<TaskSubmitted>(_onTaskSubmitted);
    on<TaskReset>(_onTaskReset);
  }

  void _onTaskNameChanged(TaskNameChanged event, Emitter<NewTaskState> emit) {
    emit(state.copyWith(taskName: event.taskName));
  }

  void _onTimeChanged(TimeChanged event, Emitter<NewTaskState> emit) {
    emit(state.copyWith(time: event.time));
  }

  void _onNotesChanged(NotesChanged event, Emitter<NewTaskState> emit) {
    emit(state.copyWith(notes: event.notes));
  }

  void _onAttachmentAdded(AttachmentAdded event, Emitter<NewTaskState> emit) {
    final updatedAttachments = List<String>.from(state.attachments)
      ..add(event.attachment);
    emit(state.copyWith(attachments: updatedAttachments));
  }

  void _onTaskSubmitted(TaskSubmitted event, Emitter<NewTaskState> emit) async {
    if (!state.isValid) {
      emit(state.copyWith(errorMessage: 'Task name is required'));
      return;
    }

    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    try {
      // Simulate API call or database save
      await Future.delayed(const Duration(seconds: 1));

      // Create TaskModel
      final task = TaskModel(
        taskName: state.taskName,
        time: _formatTime(state.time),
        notes: state.notes,
        attachments: state.attachments.join(', '),
      );

      // Here you would typically save to repository/database
      // await taskRepository.saveTask(task);

      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        errorMessage: 'Failed to save task: ${e.toString()}',
      ));
    }
  }

  void _onTaskReset(TaskReset event, Emitter<NewTaskState> emit) {
    emit(NewTaskState(time: DateTime.now()));
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour == 0 ? 12 : (dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour);
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}