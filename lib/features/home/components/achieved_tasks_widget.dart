import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo_app/core/theme/theme_controler.dart';

class AchievedTasksWidget extends StatelessWidget {
  const AchievedTasksWidget({
    super.key,
    required this.totalDoneTasks,
    required this.totalTask,
    required this.percent,
  });
  final int totalDoneTasks;
  final int totalTask;
  final double percent;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  '$totalDoneTasks Out of $totalTask Done',
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
                      value: percent,
                      backgroundColor: Color(0xff6D6D6D),
                    ),
                  ),
                ),
                Text(
                  '${(percent * 100).toInt()}%',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
