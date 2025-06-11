import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kodanewtask/data/task_model.dart';
import 'package:kodanewtask/features/pages/task_child.dart';

import '../../bloc/task_list_bloc.dart';
import '../../bloc/task_list_event.dart';


class TaskListScreen extends StatefulWidget {
  final List<TaskModel> taskList;
  const TaskListScreen({super.key, required this.taskList});

  @override
  State<StatefulWidget> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => TaskListBloc()..add(LoadTasks(initialTasks: widget.taskList)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: widget.taskList.length,
          itemBuilder: (BuildContext context, int index) {
            return TaskChild(
              taskTitle: widget.taskList[index].taskName,
              taskTime: widget.taskList[index].time,
            );
          },
        )
      ),
    );
  }
}