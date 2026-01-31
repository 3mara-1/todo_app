import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/core/enums/popup_items_enum.dart';
import 'package:todo_app/core/services/preferences_manager.dart';
import 'package:todo_app/core/theme/theme_controler.dart';
import 'package:todo_app/core/widgets/custom_text_form_filed.dart';
import 'package:todo_app/models/task_model.dart';

class CustomTaskItem extends StatelessWidget {
  const CustomTaskItem({
    super.key,
    required this.task,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
  });
  final TaskModel task;
  final Function(bool?) onChanged;
  final Function(int?) onDelete;
  final Function() onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
        border: BoxBorder.all(
          color: ThemeControler.isDark()
              ? Colors.transparent
              : Color(0xffD1DAD6),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 8),
          Checkbox(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            activeColor: Color(0xff15B86C),

            value: task.isCompleted,

            onChanged: (value) => onChanged(value),
          ),
          SizedBox(width: 16),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.taskName,
                  style: task.isCompleted
                      ? Theme.of(context).textTheme.titleLarge
                      : Theme.of(context).textTheme.bodyLarge,

                  maxLines: 1,
                ),

                if (task.taskDescription.isNotEmpty)
                  Text(
                    task.taskDescription,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 1,
                  ),
              ],
            ),
          ),
          PopupMenuButton<PopupItemsEnum>(
            onSelected: (value) async {
              switch (value) {
                case PopupItemsEnum.done:
                  onChanged(!task.isCompleted);
                case PopupItemsEnum.edit:
                  final result = await _showBottomSheet(context, task);
                  if (result == true) {
                    //callBack fun to refresh
                    onEdit();
                  }
                case PopupItemsEnum.delete:
                  _showAlertDialog(context);
              }
            },
            icon: Icon(
              Icons.more_vert,
              color: ThemeControler.isDark()
                  ? (task.isCompleted ? Color(0xffA0A0A0) : Color(0xffC6C6C6))
                  : (task.isCompleted ? Color(0xff6A6A6A) : Color(0xff3A4640)),
            ),

            itemBuilder: (context) => PopupItemsEnum.values
                .map((e) => PopupMenuItem(value: e, child: Text(e.name)))
                .toList(),
          ),
        ],
      ),
    );
  }

  Future<bool?> _showBottomSheet(context, TaskModel model) {
    final TextEditingController taskNameController = TextEditingController(
      text: model.taskName,
    );
    final TextEditingController taskDescriptionController =
        TextEditingController(text: model.taskDescription);
    final GlobalKey<FormState> key = GlobalKey();
    bool isHighPriority = model.isHighPriority;
    return showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      useSafeArea: true,

      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 20.0,
              ),
              child: Form(
                key: key,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  // crossAxisAlignment: CrossAxisAlignment.start,
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
                    Spacer(),
                    // SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () async {
                        if (key.currentState?.validate() ?? false) {
                          final taskJson = PreferencesManager().getString(
                            'tasks',
                          );
                          List<dynamic> taskList = [];
                          if (taskJson != null) {
                            taskList = jsonDecode(taskJson);
                          }

                          TaskModel newModel = TaskModel(
                            id: model.id,
                            taskName: taskNameController.text,
                            taskDescription: taskDescriptionController.text,
                            isHighPriority: isHighPriority,
                            isCompleted: model.isCompleted,
                          );

                          final item = taskList.firstWhere(
                            (e) => e['id'] == model.id,
                          );
                          final int index = taskList.indexOf(item);
                          taskList[index] = newModel;

                          final taskEncode = jsonEncode(taskList);
                          await PreferencesManager().setString(
                            'tasks',
                            taskEncode,
                          );

                          Navigator.of(context).pop(true);
                        }
                      },

                      label: Text(
                        'Edit Task',
                        // style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      icon: Icon(Icons.edit),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 40),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<String?> _showAlertDialog(context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Task'),
          content: Text("are you sure to delete this task ? "),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onDelete(task.id);
              },

              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
