import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/widget/task_list_widget.dart';

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
    final pref = await SharedPreferences.getInstance();
    final getTask = pref.getString('tasks');
    if (getTask != null) {
      final taskAftreDecode = jsonDecode(getTask) as List<dynamic>;

      setState(() {
        todoTask = taskAftreDecode
            .map((e) => TaskModel.fromJson(e))
            .where((element) => element.isCompleted == false)
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
          padding: EdgeInsets.all(18.0),
          child: Text(
            'To Do Tasks',
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
              task: todoTask,
              onChanged: (bool? value, int? index) async {
                setState(() {
                  todoTask[index!].isCompleted = value ?? false;
                });

                final pref = await SharedPreferences.getInstance();
                final allData = pref.getString('tasks');
                if (allData != null) {
                  List<TaskModel> allDataList = (jsonDecode(allData) as List)
                      .map((e) => TaskModel.fromJson(e))
                      .toList();
                  final int newIndex = allDataList.indexWhere(
                    (e) => e.id == todoTask[index!].id,
                  );
                  allDataList[newIndex] = todoTask[index!];
                  pref.setString('tasks', jsonEncode(allDataList));
                }
                _loadTasks();
              },
              emptyMessage: 'No Taskes',
            ),
          ),
        ),
      ],
    );
  }
}
