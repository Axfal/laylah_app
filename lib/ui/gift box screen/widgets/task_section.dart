import 'package:flutter/material.dart';
import 'package:laylah_app/utils/constants/app_colors.dart';
import 'package:laylah_app/utils/extensions/sized_box_extension.dart';
import '../model/task_item.dart';
import 'task_item_widget.dart';

class TaskSection extends StatelessWidget {
  final String title;
  final List<TaskItem> tasks;

  const TaskSection({super.key, required this.title, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// header text
        Text(
          title,
          style: const TextStyle(
            color: MyAppColors.whiteColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBoxExtensions.withHeight(8),
        /// list of daily tasks
        Column(
          children: tasks
              .map((task) => TaskItemWidget(
                    key: ValueKey(task.title),
                    task: task,
                  ))
              .toList(),
        ),
      ],
    );
  }
}
