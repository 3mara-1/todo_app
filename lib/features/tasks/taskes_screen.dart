import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/core/services/preferences_manager.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/core/components/task_list_widget.dart';

class TaskesScreen extends StatefulWidget {
  const TaskesScreen({super.key});

  @override
  State<TaskesScreen> createState() => _TaskesScreenState();
}

class _TaskesScreenState extends State<TaskesScreen> {
  List<TaskModel> todoTask = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    final getTask = PreferencesManager().getString('tasks');
    if (getTask != null) {
      final taskAftreDecode = jsonDecode(getTask) as List<dynamic>;

      setState(() {
        todoTask = taskAftreDecode
            .map((e) => TaskModel.fromJson(e))
            .where((element) => element.isCompleted == false)
            .toList();
      });
    }
  }

  _deleteTask(int? id) async {
    List<TaskModel> tasks = [];
    if (id == null) return;

    final finalTask = PreferencesManager().getString('tasks');
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      tasks = taskAfterDecode.map((e) => TaskModel.fromJson(e)).toList();
      tasks.removeWhere((e) => e.id == id);

      setState(() {
        todoTask.removeWhere((e) => e.id == id);
      });

      final taskJson = tasks.map((e) => e.toJson()).toList();
      PreferencesManager().setString('tasks', jsonEncode(taskJson));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.all(18.0),
            child: Text(
              'To Do Tasks',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: TaskListWidget(
              task: todoTask,
              onChanged: (bool? value, int? index) async {
                setState(() {
                  todoTask[index!].isCompleted = value ?? false;
                });

                final allData = PreferencesManager().getString('tasks');
                if (allData != null) {
                  List<TaskModel> allDataList = (jsonDecode(allData) as List)
                      .map((e) => TaskModel.fromJson(e))
                      .toList();
                  final int newIndex = allDataList.indexWhere(
                    (e) => e.id == todoTask[index!].id,
                  );
                  allDataList[newIndex] = todoTask[index!];
                  PreferencesManager().setString(
                    'tasks',
                    jsonEncode(allDataList),
                  );
                }
                _loadTasks();
              },
              emptyMessage: 'No Taskes',
              onDelete: (id) => _deleteTask(id),
              onEdit: () {
                _loadTasks();
              },
            ),
          ),
        ),
      ],
    );
  }
}
