import 'package:flutter/material.dart';


class TaskChild extends StatefulWidget {
  final String taskTitle;
  final String taskTime;
  const TaskChild({
    super.key,
    required this.taskTitle,
    required this.taskTime
  });

  @override
  State<StatefulWidget> createState() => _TaskChildState();
}

class _TaskChildState extends State<TaskChild> {


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Text(widget.taskTitle),
          Spacer(flex: 1,),
          Text(widget.taskTime),
        ],
      ),
    );
  }
}