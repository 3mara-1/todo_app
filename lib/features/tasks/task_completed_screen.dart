import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/tasks/tasks_controller.dart';
import 'package:todo_app/core/components/task_list_widget.dart';

class TaskCompletedScreen extends StatelessWidget {
  const TaskCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TasksController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              'Completed Tasks',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),

        Expanded(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Consumer<TasksController>(
              builder: (context, TasksController valuecontroller, child) {
                return TaskListWidget(
                  task: valuecontroller.completeTask,
                  onChanged: ( value,  index) async {
                    controller.doneTask(value,valuecontroller.completeTask[index!].id);
                  },

                  emptyMessage: 'No Completed Taskes',
                  onDelete: (id) => controller.deleteTask(id),
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
