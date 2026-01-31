import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/widget/custom_task_item.dart';

// ignore: must_be_immutable
class SliverTaskListWidget extends StatelessWidget {
  SliverTaskListWidget({
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
        ? SliverToBoxAdapter(
            child: Center(
              child: Text(
                emptyMessage,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          )
        : SliverPadding(
            padding: EdgeInsets.only(bottom: 80),
            sliver: SliverList.separated(
              itemCount: task.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 8);
              },

              itemBuilder: (BuildContext context, int index) {
                return CustomTaskItem(
                  task: task[index],
                  onChanged: (value) => onChanged(value, index),
                  onDelete: (id) => onDelete(id),
                  onEdit: () {
                    onEdit();
                  },
                );
              },
            ),
          );
  }
}
