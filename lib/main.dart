import 'package:flutter/material.dart';
import 'package:todo_app/spalsh_acreen.dart';
import 'package:todo_app/welcome.dart';

void main() {
  runApp(Taskly());
}

class Taskly extends StatelessWidget {
  const Taskly({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Welcome());
  }
}
