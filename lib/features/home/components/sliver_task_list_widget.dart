import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/tasks/tasks_controller.dart';
import 'package:todo_app/core/components/custom_task_item.dart';

// ignore: must_be_immutable
class SliverTaskListWidget extends StatelessWidget {
  SliverTaskListWidget({super.key, required this.emptyMessage});

  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksController>(
      builder: (context, TasksController controller, child) {
          final tasksList = controller.task;
        return tasksList.isEmpty
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
                  itemCount: tasksList.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 8);
                  },

                  itemBuilder: (BuildContext context, int index) {
                    return CustomTaskItem(
                      task:tasksList[index],
                      onChanged: (bool? value) => controller.doneTask(
                        value,
                       tasksList[index].id,
                      ),

                      onDelete: (id) => controller.deleteTask(id),
                      onEdit: () {
                        controller.inti();
                      },
                    );
                  },
                ),
              );
      },
    );
  
  }
}
