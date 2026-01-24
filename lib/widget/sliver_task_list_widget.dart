import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';

// ignore: must_be_immutable
class SliverTaskListWidget extends StatelessWidget {
  SliverTaskListWidget({
    super.key,
    required this.task,
    required this.onChanged,
    required this.emptyMessage,
  });

  final List<TaskModel> task;
  Function(bool?, int?) onChanged;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    return task.isEmpty
        ? SliverToBoxAdapter(
          child: Center(
            child: Text(
              emptyMessage,
              style: TextStyle(fontSize: 14, color: Colors.white),
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
                return Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Color(0xff282828),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        activeColor: Color(0xff15B86C),

                        value: task[index].isCompleted,

                        onChanged: (value) => onChanged(value, index),
                      ),
                      SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task[index].taskName,
                              style: TextStyle(
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w400,
                                color: task[index].isCompleted
                                    ? Color(0xffA0A0A0)
                                    : Color(0xffFFFCFC),
                                decoration: task[index].isCompleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                decorationColor: Color(0xFFA0A0A0),
                              ),
                              maxLines: 1,
                            ),

                            if (task[index].taskDescription.isNotEmpty)
                              Text(
                                task[index].taskDescription,
                                style: TextStyle(
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,

                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffC6C6C6),
                                ),
                                maxLines: 1,
                              ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.more_vert, color: Colors.white),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
  }
}
