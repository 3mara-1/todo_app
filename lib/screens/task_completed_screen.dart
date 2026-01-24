import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/widget/task_list_widget.dart';

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
    final pref = await SharedPreferences.getInstance();
    final getTask = pref.getString('tasks');
    if (getTask != null) {
      final taskAftreDecode = jsonDecode(getTask) as List<dynamic>;

      setState(() {
        completedTask = taskAftreDecode
            .map((e) => TaskModel.fromJson(e))
            .where((element) => element.isCompleted == true)
            .toList();
      });
    }
    // print(task);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            'Completed Tasks',
            style: TextStyle(
              color: Color(0xFFFFFCFC),
              fontSize: 20,
              fontWeight: FontWeight.w400,
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

                final pref = await SharedPreferences.getInstance();
                final allData = pref.getString('tasks');
                if (allData != null) {
                  List<TaskModel> allTasklist = (jsonDecode(allData) as List)
                      .map((e) => TaskModel.fromJson(e))
                      .toList();
                  final int newIndex = allTasklist.indexWhere(
                    (e) => e.id == completedTask[index!].id,
                  );
                  allTasklist[newIndex] = completedTask[index!];

                  pref.setString('tasks', jsonEncode(allTasklist));
                }
                _loadTasks();
              },
              emptyMessage: 'No Completed Taskes',
            ),
          ),
        ),
      ],
    );
  }
}
