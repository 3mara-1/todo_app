import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/constant/storage_key.dart';
import 'package:todo_app/core/services/preferences_manager.dart';
import 'package:todo_app/core/theme/dark_theme.dart';
import 'package:todo_app/core/theme/light_theme.dart';
import 'package:todo_app/core/theme/theme_controler.dart';
import 'package:todo_app/features/navigation/main_screen.dart';
import 'package:todo_app/features/tasks/tasks_controller.dart';
import 'package:todo_app/features/welcome/welcome._screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferencesManager().init();
  // PreferencesManager().clear();
  ThemeController().init();
  String? username = PreferencesManager().getString(StorageKey.username);

  runApp(Taskly(user: username));
}

class Taskly extends StatelessWidget {
  Taskly({super.key, required this.user});

  final String? user;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeNotifier,
      builder: (context, ThemeMode thememode, Widget? child) {
        return ChangeNotifierProvider<TasksController>(
          create: (_) => TasksController()..inti(),
          child: ScreenUtilInit(
            designSize: const Size(375, 809),
            minTextAdapt: true,
            builder: (cxt, _) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: thememode,
                home: user == null ? Welcome() : MainScreen(),
              );
            },
          ),
        );
      },
    );
  }
}
