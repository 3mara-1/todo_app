import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/widgets/custom_text_form_filed.dart';
import 'package:todo_app/features/add_task/add_task_controller.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddTaskController>(
      create: (context) => AddTaskController(),
      builder: (context, _) {
       
        final controller = context.read<AddTaskController>();
        return Scaffold(
          appBar: AppBar(title: Text('New Task')),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Form(
                key: controller.key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextFormFiled(
                              title: 'Task Name',
                              controller: controller.taskNameController,
                              hintText: 'Finish UI design for login screen',
                              validator: (String? value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'please inter task name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),

                            CustomTextFormFiled(
                              title: 'Task Description',
                              controller: controller.taskDescriptionController,
                              hintText:
                                  'Finish onboarding UI and hand off to devs by Thursday.',
                              maxLines: 5,
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'High Priority ',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Consumer<AddTaskController>(
                                  builder:
                                      (
                                        context,
                                        AddTaskController value,
                                        child,
                                      ) {
                                        return Switch(
                                          value: value.isHighPriority,
                                          onChanged: (value) {
                                            controller.toggel(value);
                                          },
                                        );
                                      },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Spacer(),
                    SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () async {
                        context.read<AddTaskController>().addTask(context);
                      },

                      label: Text(
                        'Add task',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      icon: Icon(Icons.add),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 40),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
