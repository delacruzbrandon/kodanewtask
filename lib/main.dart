import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:kodanewtask/features/pages/new_task_screen.dart';

import 'bloc/new_task_bloc.dart';
import 'data/task_model.dart';
import 'features/pages/task_list_screen.dart';

void main() {
  runApp(const MyApp());
  final newTaskBloc = NewTaskBloc();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'kodaknewtask',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Kodak New Task'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final testTaskList = <TaskModel>[
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

  void navigateToNewTaskScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const NewTaskScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: TaskListScreen(taskList: testTaskList,),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToNewTaskScreen,
        tooltip: 'new_task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
