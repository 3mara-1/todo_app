import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/widget/task_list_widget.dart';

class HighPriorityScreen extends StatefulWidget {
  const HighPriorityScreen({super.key});

  @override
  State<HighPriorityScreen> createState() => _HighPriorityScreenState();
}

class _HighPriorityScreenState extends State<HighPriorityScreen> {
  List<TaskModel> todoTask = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    final pref = await SharedPreferences.getInstance();
    final getTask = pref.getString('tasks');
    if (getTask != null) {
      final taskAftreDecode = jsonDecode(getTask) as List<dynamic>;

      setState(() {
        todoTask = taskAftreDecode
            .map((e) => TaskModel.fromJson(e))
            .where((element) => element.isHighPriority)
            .toList();
      });
    }
    // print(task);
  }

  _doneTask(bool? value, int? index) async {
    setState(() {
      todoTask[index!].isCompleted = value ?? false;
    });

    final pref = await SharedPreferences.getInstance();
    final taskJson = todoTask.map((e) => e.toJson()).toList();
    pref.setString('tasks', jsonEncode(taskJson));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('High Priority')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TaskListWidget(
          task: todoTask,
          onChanged: (bool? value, int? index) async {
            _doneTask(value, index);
          },
          emptyMessage: 'No Tasks Available',
        ),
      ),
    );
  }
}
