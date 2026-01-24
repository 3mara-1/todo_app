import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/screens/add_task_screen.dart';
import 'package:todo_app/widget/achieved_tasks_widget.dart';
import 'package:todo_app/widget/high_priority_widget.dart';
import 'package:todo_app/widget/sliver_task_list_widget.dart';
import 'package:todo_app/widget/task_list_widget.dart';

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

  @override
  void initState() {
    super.initState();

    _loadUserName();
    _loadTasks();
  }

  _loadUserName() async {
    final pref = await SharedPreferences.getInstance();

    setState(() {
      username = pref.getString('username');
    });
  }

  void _loadTasks() async {
    final pref = await SharedPreferences.getInstance();
    final getTask = pref.getString('tasks');
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

    final pref = await SharedPreferences.getInstance();
    final taskJson = task.map((e) => e.toJson()).toList();
    pref.setString('tasks', jsonEncode(taskJson));
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
                        backgroundImage: AssetImage(
                          'assets/images/profile.png',
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good Evening ,$username',
                            style: const TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Text(
                            'One task at a time.One step closer.',
                            style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Yuhuu ,Your work Is ',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffFFFCFC),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'almost done !  ',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffFFFCFC),
                        ),
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
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffFFFCFC),
                      ),
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
                emptyMessage: 'No Tasks Available',
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
