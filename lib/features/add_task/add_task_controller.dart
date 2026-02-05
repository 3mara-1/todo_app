import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todo_app/core/constant/storage_key.dart';
import 'package:todo_app/core/services/preferences_manager.dart';
import 'package:todo_app/models/task_model.dart';

class AddTaskController with ChangeNotifier {
  final GlobalKey<FormState> key = GlobalKey();

  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController taskDescriptionController =
      TextEditingController();

  bool isHighPriority = true;

  void addTask() async {
    if (key.currentState?.validate() ?? false) {
      final taskJson = PreferencesManager().getString(StorageKey.userTask);
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
      await PreferencesManager().setString(StorageKey.userTask, taskEncode);

      
    }
    notifyListeners();
  }

  toggel(bool value) {
    isHighPriority = value;
    notifyListeners();
  }
}
