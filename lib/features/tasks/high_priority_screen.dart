import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/tasks/tasks_controller.dart';

import 'package:todo_app/core/components/task_list_widget.dart';

class HighPriorityScreen extends StatelessWidget {
  const HighPriorityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TasksController>();
    return Scaffold(
      appBar: AppBar(title: Text('High Priority')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<TasksController>(
          builder: (context, TasksController valuecontroller,Widget? child) {
            return TaskListWidget(
              task: valuecontroller.highPriorityTask,
              onChanged: ( value,  index) async{
                controller.doneTask(value,valuecontroller.highPriorityTask[index!].id );
              },
              onDelete: (int? id) => controller.deleteTask(id),
              emptyMessage: 'No Tasks Available',
              onEdit: () {
                controller.inti();
              },
            );
          },
        ),
      ),
    );
  }
}
