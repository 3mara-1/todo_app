import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/core/constant/storage_key.dart';
import 'package:todo_app/core/services/preferences_manager.dart';
import 'package:todo_app/models/task_model.dart';

class TasksController with ChangeNotifier {
  List<TaskModel> task = [];
  List<TaskModel> todoTasks = [];
  List<TaskModel> completeTask = [];
  List<TaskModel> highPriorityTask = [];
  int totalTask = 0;
  int totalDoneTasks = 0;
  double percent = 0;

  inti() {
    _loadTasks();
  }

  void _loadTasks() async {
    final getTask = PreferencesManager().getString(StorageKey.userTask);
    if (getTask != null) {
      final taskAftreDecode = jsonDecode(getTask) as List<dynamic>;
      task = taskAftreDecode.map((e) => TaskModel.fromJson(e)).toList();
      _loadData();
      _calculatePercent();
    }
    notifyListeners();
  }

  void _loadData() {
    todoTasks = task.where((element) => !element.isCompleted).toList();
    completeTask = task.where((element) => element.isCompleted).toList();
    highPriorityTask = task.where((element) => element.isHighPriority).toList();
    highPriorityTask = highPriorityTask.reversed.toList();
  }


    void doneTask(bool? value, int id) async {
    final index = task.indexWhere((e) => e.id == id);
    task[index].isCompleted = value ?? false;

    _loadData();
    _calculatePercent();

    final updatedTask = task.map((element) => element.toJson()).toList();
    PreferencesManager().setString(StorageKey.userTask, jsonEncode(updatedTask));

    notifyListeners();
  }

  deleteTask(int? id) async {
    if (id == null) return;
    task.removeWhere((e) => e.id == id);
    _loadData();
    _calculatePercent();
    final taskJson = task.map((e) => e.toJson()).toList();
    PreferencesManager().setString(StorageKey.userTask, jsonEncode(taskJson));
    notifyListeners();
  }

  void _calculatePercent() {
    totalTask = task.length;
    totalDoneTasks = task.where((e) => e.isCompleted).length;
    percent = totalTask == 0 ? 0 : totalDoneTasks / totalTask;
    notifyListeners();
  }
}
