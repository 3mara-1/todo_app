import 'package:flutter/material.dart';
import 'package:todo_app/core/constant/storage_key.dart';
import 'package:todo_app/core/services/preferences_manager.dart';

class ThemeControler {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.light,
  );

  init() {
    bool result = PreferencesManager().getBool(StorageKey.theme) ?? false;
    themeNotifier.value = result ? ThemeMode.dark : ThemeMode.light;
  }

  toggelTheme() async {
    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
      await PreferencesManager().setBool(StorageKey.theme, false);
    } else {
      themeNotifier.value = ThemeMode.dark;
      await PreferencesManager().setBool(StorageKey.theme, true);
    }
  }

  static isDark() => themeNotifier.value == ThemeMode.dark;
}
