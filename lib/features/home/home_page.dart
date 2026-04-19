import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todo_app/core/constant/app_size.dart';
import 'package:todo_app/core/widgets/custom_svg_picture.dart';

import 'package:todo_app/features/home/home_controller.dart';
import 'package:todo_app/features/add_task/add_task_screen.dart';
import 'package:todo_app/features/home/components/achieved_tasks_widget.dart';
import 'package:todo_app/features/home/components/high_priority_widget.dart';
import 'package:todo_app/features/home/components/sliver_task_list_widget.dart';
import 'package:todo_app/features/tasks/tasks_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (context) => HomeController()..init(),

      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(AppSize.w16),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Row(
                      spacing: 10,
                      children: [
                        Selector(
                          selector: (context, HomeController controller) =>
                              controller.userImagePath,
                          builder:
                              (context, String? userImagePath, Widget? child) =>
                                  CircleAvatar(
                                    radius: AppSize.r24,

                                    backgroundImage: userImagePath == null
                                        ? AssetImage(
                                            'assets/images/profile.png',
                                          )
                                        : FileImage(File(userImagePath)),
                                  ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Selector<HomeController, String?>(
                              selector: (context, HomeController controller) =>
                                  controller.username,
                              builder:
                                  (context, String? username, Widget? child) =>
                                      Text(
                                        'Good Evening ,$username',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium,
                                        maxLines: 1,
                                      ),
                            ),
                            Text(
                              'One task at a time.One step closer.',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.h16),
                    Text(
                      'Yuhuu ,Your work Is ',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Row(
                      children: [
                        Text(
                          'almost done !  ',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        CustomSvgPicture.withoutcolor(
                          imageSrc: 'assets/images/hand.svg',
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.h16),
                    AchievedTasksWidget(),
                    SizedBox(height: AppSize.h16),
                    HighPriorityWidget(),

                    Padding(
                      padding: EdgeInsets.only(
                        top: AppSize.w24,
                        bottom: AppSize.h16,
                      ),
                      child: Text(
                        'My Tasks',
                        style: Theme.of(context).textTheme.displaySmall!
                            .copyWith(fontSize: AppSize.f20),
                      ),
                    ),
                  ],
                ),
              ),

              // if (value.task.isNotEmpty)
              SliverTaskListWidget(emptyMessage: 'No Tasks Available'),
            ],
          ),
        ),

        floatingActionButton: SizedBox(
          height: AppSize.h40,
          child: Builder(
            builder: (context) {
              return FloatingActionButton.extended(
                backgroundColor: Color(0xff15B86C),
                foregroundColor: Color(0xffffffff),
                onPressed: () async {
                  final bool? result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => AddTask(),
                    ),
                  );

                  if (result != null && result) {
                    context.read<TasksController>().inti();
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.r100),
                ),
                label: Text('Add New Task'),
                icon: Icon(Icons.add),
              );
            },
          ),
        ),
      ),
    );
  }
}
