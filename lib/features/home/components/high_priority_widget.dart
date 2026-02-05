import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/theme/theme_controler.dart';
import 'package:todo_app/core/widgets/custom_check_box.dart';
import 'package:todo_app/core/widgets/custom_svg_picture.dart';
import 'package:todo_app/features/home/home_controller.dart';
import 'package:todo_app/features/tasks/high_priority_screen.dart';

class HighPriorityWidget extends StatelessWidget {
  HighPriorityWidget({
    super.key,

  });



  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, HomeController controller, child) {
        final taskList = controller.task;
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(20),
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 8),
                        child: Text(
                          'High Priority Tasks',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF15B86C),
                          ),
                        ),
                      ),
                      ...taskList.reversed
                          .where((e) => e.isHighPriority)
                          .take(4)
                          .map((element) {
                            return Row(
                              children: [
                                CustomCheckBox(
                                  isCompleted: element.isCompleted,
                                  onChanged: (value) {
                                    final index = taskList.indexWhere(
                                      (e) => e.id == element.id,
                                    );
                                    controller.doneTask(value, index);
                                    // onChanged(value, index);
                                  },
                                ),

                                Flexible(
                                  child: Text(
                                    element.taskName,
                                    style: element.isCompleted
                                        ? Theme.of(context).textTheme.titleLarge
                                        : Theme.of(context).textTheme.bodyLarge,

                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            );
                          }),
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
                    controller.loadTasks();
                  },
                  child: Container(
                    width: 56,
                    height: 48,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: ThemeControler.isDark()
                            ? Color(0xFF6E6E6E)
                            : Color(0xFFD1DAD6),
                        width: 1,
                      ),
                    ),
                    child: CustomSvgPicture(
                      imageSrc: 'assets/images/arrow_up_right.svg',
                      width: 24,
                      height: 24,
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
