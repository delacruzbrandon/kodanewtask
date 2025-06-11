
class NewTaskState {
  final String taskName;
  final DateTime time;
  final String notes;
  final List<String> attachments;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  NewTaskState({
    this.taskName = '',
    DateTime? time,
    this.notes = '',
    this.attachments = const [],
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  }) : time = time ?? DateTime(2023, 1, 1, 6, 0);

  NewTaskState copyWith({
    String? taskName,
    DateTime? time,
    String? notes,
    List<String>? attachments,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return NewTaskState(
      taskName: taskName ?? this.taskName,
      time: time ?? this.time,
      notes: notes ?? this.notes,
      attachments: attachments ?? this.attachments,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get isValid => taskName.isNotEmpty;
}