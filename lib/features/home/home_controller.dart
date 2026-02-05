import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:todo_app/core/constant/storage_key.dart';
import 'package:todo_app/core/services/preferences_manager.dart';
import 'package:todo_app/models/task_model.dart';

class HomeController with ChangeNotifier {
  String? username;
  List<TaskModel> task = [];
  int totalTask = 0;
  int totalDoneTasks = 0;
  double percent = 0;
  String? userImagePath;

  // HomeController() {
  //   init();
  // }
  init() {
    loadUserName();
    loadTasks();
  }

  loadUserName() async {
    username = PreferencesManager().getString(StorageKey.username);
    userImagePath = PreferencesManager().getString(StorageKey.userImage);
    notifyListeners();
  }

  void loadTasks() async {
    final getTask = PreferencesManager().getString(StorageKey.userTask);
    if (getTask != null) {
      final taskAftreDecode = jsonDecode(getTask) as List<dynamic>;

      task = taskAftreDecode.map((e) => TaskModel.fromJson(e)).toList();
      calculatePercent();
    }
    notifyListeners();
  }

  void calculatePercent() {
    totalTask = task.length;
    totalDoneTasks = task.where((e) => e.isCompleted).length;
    percent = totalTask == 0 ? 0 : totalDoneTasks / totalTask;
    notifyListeners();
  }

  doneTask(bool? value, int? index) async {
    task[index!].isCompleted = value ?? false;
    calculatePercent();

    final taskJson = task.map((e) => e.toJson()).toList();
    PreferencesManager().setString(StorageKey.userTask, jsonEncode(taskJson));
    notifyListeners();
  }

  deleteTask(int? id) async {
    task.removeWhere((e) => e.id == id);
    calculatePercent();

    final taskJson = task.map((e) => e.toJson()).toList();
    PreferencesManager().setString(StorageKey.userTask, jsonEncode(taskJson));
    notifyListeners();
  }
}
