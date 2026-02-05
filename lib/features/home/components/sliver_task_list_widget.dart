import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/home/home_controller.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/core/components/custom_task_item.dart';

// ignore: must_be_immutable
class SliverTaskListWidget extends StatelessWidget {
  SliverTaskListWidget({
    super.key,
 

    required this.emptyMessage,
  });


  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context,HomeController controller, child) => 
       controller.task.isEmpty
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
                itemCount:controller. task.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 8);
                },
      
                itemBuilder: (BuildContext context, int index) {
                  return CustomTaskItem(
                    task:controller.task[index],
                    onChanged: (value) => controller.doneTask(value, index),
                    onDelete: (id) => controller.deleteTask(id),
                    onEdit: () {
                      controller.loadTasks();
                    },
                  );
                },
              ),
            ),
    );
  }
}
