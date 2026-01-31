import 'package:flutter/material.dart';
import 'package:todo_app/core/theme/theme_controler.dart';
import 'package:todo_app/core/widgets/custom_check_box.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/core/components/custom_task_item.dart';

// ignore: must_be_immutable
class TaskListWidget extends StatelessWidget {
  TaskListWidget({
    super.key,
    required this.task,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,

    required this.emptyMessage,
  });

  final List<TaskModel> task;
  Function(bool?, int?) onChanged;
  Function(int?) onDelete;
  Function() onEdit;

  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    return task.isEmpty
        ? Center(
            child: Text(
              emptyMessage,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          )
        : ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: task.length,
            padding: EdgeInsets.only(bottom: 50),
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 8);
            },

            itemBuilder: (BuildContext context, int index) {
              return CustomTaskItem(
                task: task[index],
                onChanged: (value) => onChanged(value, index),
                onDelete: (int? id) => onDelete(id),
                onEdit: () {
                  onEdit();
                },
              );
            },
          );
  }
}
