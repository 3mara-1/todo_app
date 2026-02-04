import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/core/constant/storage_key.dart';
import 'package:todo_app/core/services/preferences_manager.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/features/add_task/add_task_screen.dart';
import 'package:todo_app/features/home/components/achieved_tasks_widget.dart';
import 'package:todo_app/features/home/components/high_priority_widget.dart';
import 'package:todo_app/features/home/components/sliver_task_list_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? username;
  List<TaskModel> task = [];
  int totalTask = 0;
  int totalDoneTasks = 0;
  double percent = 0;
  String? userImagePath;

  @override
  void initState() {
    super.initState();

    _loadUserName();
    _loadTasks();
  }

  _loadUserName() async {
    setState(() {
      username = PreferencesManager().getString(StorageKey.username);
      userImagePath = PreferencesManager().getString('user_image');
    });
  }

  void _loadTasks() async {
    final getTask = PreferencesManager().getString('tasks');
    if (getTask != null) {
      final taskAftreDecode = jsonDecode(getTask) as List<dynamic>;

      setState(() {
        task = taskAftreDecode.map((e) => TaskModel.fromJson(e)).toList();
        _calculatePercent();
      });
    }
    // print(task);
  }

  void _calculatePercent() {
    totalTask = task.length;
    totalDoneTasks = task.where((e) => e.isCompleted).length;
    percent = totalTask == 0 ? 0 : totalDoneTasks / totalTask;
  }

  _doneTask(bool? value, int? index) async {
    setState(() {
      task[index!].isCompleted = value ?? false;
      _calculatePercent();
    });

    final taskJson = task.map((e) => e.toJson()).toList();
    PreferencesManager().setString('tasks', jsonEncode(taskJson));
  }

  _deleteTask(int? id) async {
    setState(() {
      task.removeWhere((e) => e.id == id);
      _calculatePercent();
    });

    final taskJson = task.map((e) => e.toJson()).toList();
    PreferencesManager().setString('tasks', jsonEncode(taskJson));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    spacing: 10,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        // backgroundColor: Colors.transparent,
                        backgroundImage: userImagePath == null
                            ? AssetImage('assets/images/profile.png')
                            : FileImage(File(userImagePath!)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good Evening ,$username',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            'One task at a time.One step closer.',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Yuhuu ,Your work Is ',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Row(
                    children: [
                      Text(
                        'almost done !  ',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      SvgPicture.asset('assets/images/hand.svg'),
                    ],
                  ),
                  SizedBox(height: 16),
                  AchievedTasksWidget(
                    totalTask: totalTask,
                    totalDoneTasks: totalDoneTasks,
                    percent: percent,
                  ),
                  SizedBox(height: 16),
                  HighPriorityWidget(
                    refresh: () {
                      _loadTasks();
                    },
                    task: task,
                    onChanged: (bool? value, int? index) {
                      _doneTask(value, index);
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 24.0, bottom: 16),
                    child: Text(
                      'My Tasks',
                      style: Theme.of(
                        context,
                      ).textTheme.displaySmall!.copyWith(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),

            if (task.isNotEmpty)
              SliverTaskListWidget(
                task: task,

                onChanged: (bool? value, int? index) async {
                  _doneTask(value, index);
                },
                // deleted task()
                // edited task()
                onDelete: (id) => _deleteTask(id),
                emptyMessage: 'No Tasks Available',
                onEdit: () {
                  _loadTasks();
                },
              ),
          ],
        ),
      ),

      floatingActionButton: SizedBox(
        height: 40,
        child: FloatingActionButton.extended(
          backgroundColor: Color(0xff15B86C),
          foregroundColor: Color(0xffffffff),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => AddTask()),
            );
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          label: Text('Add New Task'),
          icon: Icon(Icons.add),
        ),
      ),
    );
  }
}
