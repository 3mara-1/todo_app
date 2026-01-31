import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/core/services/preferences_manager.dart';
import 'package:todo_app/core/widgets/custom_text_form_filed.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/features/navigation/main_screen.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final GlobalKey<FormState> _key = GlobalKey();

  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController taskDescriptionController =
      TextEditingController();

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
                        CustomTextFormFiled(
                          title: 'Task Name',
                          controller: taskNameController,
                          hintText: 'Finish UI design for login screen',
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'please inter task name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),

                        CustomTextFormFiled(
                          title: 'Task Description',
                          controller: taskDescriptionController,
                          hintText:
                              'Finish onboarding UI and hand off to devs by Thursday.',
                          maxLines: 5,
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'High Priority ',
                              style: Theme.of(context).textTheme.titleMedium,
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
                      final taskJson = PreferencesManager().getString('tasks');
                      List<dynamic> taskList = [];
                      if (taskJson != null) {
                        taskList = jsonDecode(taskJson);
                      }

                      TaskModel model = TaskModel(
                        id: taskList.length + 1,
                        taskName: taskNameController.text,
                        taskDescription: taskDescriptionController.text,
                        isHighPriority: isHighPriority,
                      );

                      taskList.add(model.toJson());
                      final taskEncode = jsonEncode(taskList);
                      await PreferencesManager().setString('tasks', taskEncode);

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
