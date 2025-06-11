abstract class NewTaskEvent {}

class TaskNameChanged extends NewTaskEvent {
  final String taskName;
  TaskNameChanged(this.taskName);
}

class TimeChanged extends NewTaskEvent {
  final DateTime time;
  TimeChanged(this.time);
}

class NotesChanged extends NewTaskEvent {
  final String notes;
  NotesChanged(this.notes);
}

class AttachmentAdded extends NewTaskEvent {
  final String attachment;
  AttachmentAdded(this.attachment);
}

class TaskSubmitted extends NewTaskEvent {}

class TaskReset extends NewTaskEvent {}