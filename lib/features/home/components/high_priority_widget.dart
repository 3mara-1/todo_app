import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/constant/app_size.dart';
import 'package:todo_app/core/theme/theme_controler.dart';
import 'package:todo_app/core/widgets/custom_check_box.dart';
import 'package:todo_app/core/widgets/custom_svg_picture.dart';
import 'package:todo_app/features/tasks/high_priority_screen.dart';
import 'package:todo_app/features/tasks/tasks_controller.dart';

class HighPriorityWidget extends StatelessWidget {
  const HighPriorityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksController>(
      builder: (context, TasksController controller, child) {
        final taskList = controller.task;
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(AppSize.r20),
            border: BoxBorder.all(
              color: ThemeController.isDark()
                  ? Colors.transparent
                  : Color(0xffD1DAD6),
              width: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(AppSize.w16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: AppSize.h16,
                          top: AppSize.h8,
                        ),
                        child: Text(
                          'High Priority Tasks',
                          style: TextStyle(
                            fontSize: AppSize.f16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF15B86C),
                          ),
                        ),
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            taskList.reversed
                                    .where((e) => e.isHighPriority)
                                    .length >
                                4
                            ? 4
                            : taskList.reversed
                                  .where((e) => e.isHighPriority)
                                  .length,
                        itemBuilder: (BuildContext context, int index) {
                          final task = taskList.reversed
                              .where((e) => e.isHighPriority)
                              .toList()[index];
                          return Row(
                            children: [
                              CustomCheckBox(
                                isCompleted: task.isCompleted,
                                onChanged: (bool? value) {
                                  controller.doneTask(value, task.id);
                                },
                              ),
                              Flexible(
                                child: Text(
                                  task.taskName,
                                  style: task.isCompleted
                                      ? Theme.of(context).textTheme.titleLarge
                                      : Theme.of(context).textTheme.titleMedium,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return HighPriorityScreen();
                        },
                      ),
                    );
                    controller.inti();
                  },
                  child: Container(
                    width: AppSize.w56,
                    height: AppSize.h48,
                    padding: EdgeInsets.all(AppSize.w8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: ThemeController.isDark()
                            ? Color(0xFF6E6E6E)
                            : Color(0xFFD1DAD6),
                        width: 1,
                      ),
                    ),
                    child: CustomSvgPicture(
                      imageSrc: 'assets/images/arrow_up_right.svg',
                      width: AppSize.w24,
                      height: AppSize.h24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
