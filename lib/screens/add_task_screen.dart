import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/screens/main_screen.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final GlobalKey<FormState> _key = GlobalKey();

  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController taskController = TextEditingController();

  bool isHighPriority = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Task')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Task Name',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFFFFCFC),
                          ),
                        ),
                        SizedBox(height: 8),

                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: taskNameController,
                          cursorColor: Color(0xFF15B86C),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'please inter task name';
                            }
                            return null;
                          },

                          decoration: InputDecoration(
                            hintText: 'Finish UI design for login screen',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF6D6D6D),
                            ),
                            filled: true,
                            fillColor: Color(0xFF282828),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Task Description',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFFFFCFC),
                          ),
                        ),
                        SizedBox(height: 8),

                        TextFormField(
                          controller: taskController,
                          style: TextStyle(color: Colors.white),
                          cursorColor: Color(0xFF15B86C),

                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText:
                                'Finish onboarding UI and hand off to devs by Thursday.',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF6D6D6D),
                            ),
                            filled: true,
                            fillColor: Color(0xFF282828),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'High Priority ',
                              style: TextStyle(
                                color: Color(0xffFFFCFC),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Switch(
                              value: isHighPriority,
                              onChanged: (value) {
                                setState(() {
                                  isHighPriority = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Spacer(),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (_key.currentState?.validate() ?? false) {
                      final pref = await SharedPreferences.getInstance();

                      final taskJson = pref.getString('tasks');
                      List<dynamic> taskList = [];
                      if (taskJson != null) {
                        taskList = jsonDecode(taskJson);
                      }

                      TaskModel model = TaskModel(
                        id: taskList.length + 1,
                        taskName: taskNameController.text,
                        taskDescription: taskController.text,
                        isHighPriority: isHighPriority,
                      );

                      taskList.add(model.toJson());
                      final taskEncode = jsonEncode(taskList);
                      await pref.setString('tasks', taskEncode);
                      print(taskList);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => MainScreen(),
                        ),
                      );
                    }
                  },

                  label: Text(
                    'Add task',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  icon: Icon(Icons.add),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff15B86C),
                    foregroundColor: Color(0xffFFFCFC),
                    fixedSize: Size(MediaQuery.of(context).size.width, 40),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
