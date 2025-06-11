import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kodanewtask/features/widgets/new_task_text_field.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';

import '../../bloc/new_task_bloc.dart';
import '../../bloc/new_task_event.dart';
import '../../bloc/new_task_state.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewTaskBloc(),
      child: const NewTaskView(),
    );
  }
}

class NewTaskView extends StatelessWidget {
  const NewTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewTaskBloc, NewTaskState>(
      listener: (context, state) {
        if (state.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Task saved successfully!'),
            ),
          );
          // Optionally navigate back or reset form
          context.read<NewTaskBloc>().add(TaskReset());
        }

        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Add New Task',
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              // Task Name Field
              NewTaskTextField(
                header: 'Task Name',
                hint: 'Example: Wake up',
                onChanged: (value) {
                  context.read<NewTaskBloc>().add(TaskNameChanged(value));
                },
              ),

              // Time Picker
              const Text("Time"),
              BlocBuilder<NewTaskBloc, NewTaskState>(
                builder: (context, state) {
                  return TimePickerSpinner(
                    locale: const Locale('en', ''),
                    time: state.time,
                    is24HourMode: false,
                    isShowSeconds: false,
                    itemHeight: 40,
                    hapticFeedback: true,
                    normalTextStyle: const TextStyle(fontSize: 24),
                    highlightedTextStyle: const TextStyle(
                      fontSize: 24,
                    ),
                    isForce2Digits: true,
                    onTimeChange: (time) {
                      context.read<NewTaskBloc>().add(TimeChanged(time));
                    },
                  );
                },
              ),

              // Notes Field
              NewTaskTextField(
                header: 'Notes',
                hint: 'Enter Notes here',
                expands: true,
                onChanged: (value) {
                  context.read<NewTaskBloc>().add(NotesChanged(value));
                },
              ),

              // Attachments
              const Text('Attachments'),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    // Here you would implement file picker
                    // For demo, just add a dummy attachment
                    context.read<NewTaskBloc>().add(
                      AttachmentAdded('attachment_${DateTime.now().millisecondsSinceEpoch}'),
                    );
                  },
                  child: const Text('Tap Here to add Files'),
                ),
              ),

              // Show attachments
              BlocBuilder<NewTaskBloc, NewTaskState>(
                builder: (context, state) {
                  if (state.attachments.isNotEmpty) {
                    return Column(
                      children: [
                        const SizedBox(height: 8),
                        ...state.attachments.map((attachment) =>
                            Chip(
                              label: Text(attachment),
                              onDeleted: () {
                                // You might want to add a remove attachment event
                              },
                            ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),


              // Submit Button
              BlocBuilder<NewTaskBloc, NewTaskState>(
                builder: (context, state) {
                  return FilledButton(
                    onPressed: state.isSubmitting ? null : () {
                      context.read<NewTaskBloc>().add(TaskSubmitted());
                    },
                    child: state.isSubmitting
                        ? const CircularProgressIndicator()
                        : const Text('Save Task'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

