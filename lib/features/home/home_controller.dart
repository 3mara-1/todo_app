
import 'package:flutter/cupertino.dart';
import 'package:todo_app/core/constant/storage_key.dart';
import 'package:todo_app/core/services/preferences_manager.dart';
import 'package:todo_app/models/task_model.dart';

class HomeController with ChangeNotifier {
  String? username;
  List<TaskModel> task = [];

  String? userImagePath;

  init() {
    loadUserName();
  }

  loadUserName() async {
    username = PreferencesManager().getString(StorageKey.username);
    userImagePath = PreferencesManager().getString(StorageKey.userImage);
    notifyListeners();
  }
}
