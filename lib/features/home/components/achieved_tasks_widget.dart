import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/theme/theme_controler.dart';
import 'package:todo_app/features/tasks/tasks_controller.dart';

class AchievedTasksWidget extends StatelessWidget {
  const AchievedTasksWidget({
    super.key,

  });
 
  @override
  Widget build(BuildContext context) {
    return Consumer<TasksController>(
      builder: (context,TasksController controller,Widget? child) =>
     Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
          border: BoxBorder.all(
            color: ThemeControler.isDark()
                ? Colors.transparent
                : Color(0xffD1DAD6),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Achieved Tasks',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '${controller.totalDoneTasks} Out of ${controller.totalTask} Done',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              Stack(
                alignment: AlignmentGeometry.center,
                children: [
                  Transform.rotate(
                    angle: -pi / 2,
                    child: SizedBox(
                      height: 48,
                      width: 48,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Color(0xff15B86C)),
                        strokeWidth: 4,
                        value:controller.percent,
                        backgroundColor: Color(0xff6D6D6D),
                      ),
                    ),
                  ),
                  Text(
                    '${(controller.percent * 100).toInt()}%',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
