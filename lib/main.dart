import 'package:flutter/material.dart';
import 'package:todo_app/core/services/preferences_manager.dart';
import 'package:todo_app/core/theme/dark_theme.dart';
import 'package:todo_app/core/theme/light_theme.dart';
import 'package:todo_app/core/theme/theme_controler.dart';
import 'package:todo_app/screens/main_screen.dart';
import 'package:todo_app/screens/welcome._screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferencesManager().init();
  // PreferencesManager().clear();
  ThemeControler().init();
  String? username = PreferencesManager().getString('username');

  runApp(Taskly(user: username));
}

class Taskly extends StatelessWidget {
  Taskly({super.key, required this.user});

  final String? user;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeControler.themeNotifier,
      builder: (context, ThemeMode thememode, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: thememode,
          home: user == null ? Welcome() : MainScreen(),
        );
      },
    );
  }
}
