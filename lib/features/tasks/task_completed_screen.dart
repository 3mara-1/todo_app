import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/core/constant/storage_key.dart';
import 'package:todo_app/core/services/preferences_manager.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/core/components/task_list_widget.dart';

class TaskCompletedScreen extends StatefulWidget {
  const TaskCompletedScreen({super.key});

  @override
  State<TaskCompletedScreen> createState() => _TaskCompletedScreenState();
}

class _TaskCompletedScreenState extends State<TaskCompletedScreen> {
  List<TaskModel> completedTask = [];

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
        completedTask = taskAftreDecode
            .map((e) => TaskModel.fromJson(e))
            .where((element) => element.isCompleted == true)
            .toList();
      });
    }
  }

  _deleteTask(int? id) async {
    List<TaskModel> tasks = [];
    if (id == null) return;

    final finalTask = PreferencesManager().getString(StorageKey.userTask);
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      tasks = taskAfterDecode.map((e) => TaskModel.fromJson(e)).toList();
      tasks.removeWhere((et) => et.id == id);

      setState(() {
        completedTask.removeWhere((e) => e.id == id);
      });

      final taskJson = tasks.map((e) => e.toJson()).toList();
      PreferencesManager().setString(StorageKey.userTask, jsonEncode(taskJson));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              'Completed Tasks',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),

        Expanded(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: TaskListWidget(
              task: completedTask,
              onChanged: (bool? value, int? index) async {
                setState(() {
                  completedTask[index!].isCompleted = value ?? false;
                });

                final allData = PreferencesManager().getString(
                  StorageKey.userTask,
                );
                if (allData != null) {
                  List<TaskModel> allTasklist = (jsonDecode(allData) as List)
                      .map((e) => TaskModel.fromJson(e))
                      .toList();
                  final int newIndex = allTasklist.indexWhere(
                    (e) => e.id == completedTask[index!].id,
                  );
                  allTasklist[newIndex] = completedTask[index!];

                  PreferencesManager().setString(
                    StorageKey.userTask,
                    jsonEncode(allTasklist),
                  );
                }
                _loadTasks();
                // deleted task()
                // edited task()
              },

              emptyMessage: 'No Completed Taskes',
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
