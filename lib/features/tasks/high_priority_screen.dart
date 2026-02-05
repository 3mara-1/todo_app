import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/core/constant/storage_key.dart';
import 'package:todo_app/core/services/preferences_manager.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/core/components/task_list_widget.dart';

class HighPriorityScreen extends StatefulWidget {
  const HighPriorityScreen({super.key});

  @override
  State<HighPriorityScreen> createState() => _HighPriorityScreenState();
}

class _HighPriorityScreenState extends State<HighPriorityScreen> {
  List<TaskModel> highPriorityTask = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    final getTask = PreferencesManager().getString(StorageKey.userTask);
    if (getTask != null) {
      final taskAftreDecode = jsonDecode(getTask) as List<dynamic>;

      setState(() {
        highPriorityTask = taskAftreDecode
            .map((e) => TaskModel.fromJson(e))
            .where((element) => element.isHighPriority)
            .toList();
      });
    }
    // print(task);
  }

  _doneTask(bool? value, int? index) async {
    setState(() {
      highPriorityTask[index!].isCompleted = value ?? false;
    });

    final taskJson = highPriorityTask.map((e) => e.toJson()).toList();
    PreferencesManager().setString(StorageKey.userTask, jsonEncode(taskJson));
  }

  _deleteTask(int? id) async {
    List<TaskModel> tasks = [];
    if (id == null) return;

    final finalTask = PreferencesManager().getString(StorageKey.userTask);
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      tasks = taskAfterDecode.map((e) => TaskModel.fromJson(e)).toList();
      tasks.removeWhere((e) => e.id == id);

      setState(() {
        highPriorityTask.removeWhere((e) => e.id == id);
        print(highPriorityTask.map((e) => e.taskName));
      });

      final taskJson = tasks.map((e) => e.toJson()).toList();
      PreferencesManager().setString(StorageKey.userTask, jsonEncode(taskJson));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('High Priority')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TaskListWidget(
          task: highPriorityTask,
          onDelete: (int? id) => _deleteTask(id),
          onChanged: (bool? value, int? index) {
            _doneTask(value, index);
          },
          emptyMessage: 'No Tasks Available',
          onEdit: () {
            _loadTasks();
          },
        ),
      ),
    );
  }
}
