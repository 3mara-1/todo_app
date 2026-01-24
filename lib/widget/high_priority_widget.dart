import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/screens/high_priority_screen.dart';

class HighPriorityWidget extends StatelessWidget {
  HighPriorityWidget({
    super.key,
    required this.refresh,
    required this.task,
    required this.onChanged,
  });
  final List<TaskModel> task;
  Function(bool?, int?) onChanged;
  final Function refresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xff282828),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF15B86C),
                    ),
                  ),
                ),
                ...task.reversed.where((e) => e.isHighPriority).take(4).map((
                  element,
                ) {
                  return Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        activeColor: Color(0xff15B86C),

                        value: element.isCompleted,

                        onChanged: (value) {
                          final index = task.indexWhere(
                            (e) => e.id == element.id,
                          );
                          onChanged(value, index);
                        },
                      ),
                      Flexible(
                        child: Text(
                          element.taskName,
                          style: TextStyle(
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w400,
                            color: element.isCompleted
                                ? Color(0xffA0A0A0)
                                : Color(0xffFFFCFC),
                            decoration: element.isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            decorationColor: Color(0xFFA0A0A0),
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return HighPriorityScreen();
                    },
                  ),
                );
                refresh();
              },
              child: Container(
                width: 56,
                height: 48,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xFF6E6E6E)),
                ),
                child: SvgPicture.asset(
                  'assets/images/arrow_up_right.svg',
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
