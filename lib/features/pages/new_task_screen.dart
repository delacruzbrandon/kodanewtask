import 'package:flutter/material.dart';
import 'package:kodanewtask/data/task_model.dart';
import 'package:kodanewtask/features/widgets/new_task_text_field.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/new_task_bloc.dart';
import '../../bloc/new_task_event.dart';
import '../../bloc/new_task_state.dart';


class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final dreamList = <TaskModel>[
    TaskModel(
        taskName: "TestTask",
        time: "06:33 AM",
        notes: "This is a test task",
        attachments: "Hello PDF"
    ),
    TaskModel(
        taskName: "TestTask",
        time: "06:33 AM",
        notes: "This is a test task",
        attachments: "Hello PDF"
    ),
  ];



  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now();

    return BlocProvider(
      create: (context) => NewTaskBloc(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Add New Task',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            NewTaskTextField(
              header: 'Task Name',
              hint: 'Example: Wake up',
            ),
            Text("Time"),
            TimePickerSpinner(
              locale: const Locale('en', ''),
              time: dateTime,
              is24HourMode: false,
              isShowSeconds: false,
              itemHeight: 40,
              hapticFeedback: true,
              normalTextStyle: const TextStyle(
                fontSize: 24,
              ),
              highlightedTextStyle:
              const TextStyle(fontSize: 24, color: Colors.blue),
              isForce2Digits: true,
              onTimeChange: (time) {
                setState(() {
                  dateTime = time;
                });
              },
            ),
            NewTaskTextField(
              header: 'Notes',
              hint: 'Enter Notes here',
              expands: true,
            ),
            Text('Attachments'),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: null,
                child: Text('Tap Here to add Files'),
              ),
            ),
      
            const SizedBox(height: 24),
      
            // Submit Button
            BlocBuilder<NewTaskBloc, NewTaskState>(
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state.isSubmitting ? null : () {
                      context.read<NewTaskBloc>().add(TaskSubmitted());
                    },
                    child: state.isSubmitting
                        ? const CircularProgressIndicator()
                        : const Text('Save Task'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}