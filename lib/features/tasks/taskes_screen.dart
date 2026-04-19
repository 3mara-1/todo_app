import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/constant/app_size.dart';
import 'package:todo_app/features/tasks/tasks_controller.dart';
import 'package:todo_app/core/components/task_list_widget.dart';

class TaskesScreen extends StatelessWidget {
  const TaskesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TasksController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.all(AppSize.w16),
            child: Text(
              'To Do Tasks',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(AppSize.w16),
            child: Consumer<TasksController>(
              builder: (context, TasksController valuecontroller, child) {
                return TaskListWidget(
                  task: valuecontroller.todoTasks,
                  onChanged: (value, index) async {
                    controller.doneTask(
                      value,
                      valuecontroller.todoTasks[index!].id,
                    );
                  },
                  emptyMessage: 'No Taskes',
                  onDelete: (int? id) => controller.deleteTask(id),
                  onEdit: () {
                    controller.inti();
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
