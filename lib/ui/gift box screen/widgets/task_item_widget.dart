import 'package:flutter/material.dart';
import 'package:laylah_app/utils/extensions/sized_box_extension.dart';
import '../../../utils/constants/app_colors.dart';
import '../model/task_item.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskItem task;

  const TaskItemWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// texts in task containers
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// header bold text in task container
                Text(
                  task.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (task.subtitle.isNotEmpty)

                  /// text under header bold in task container
                  Text(
                    task.subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: MyAppColors.greyColor,
                    ),
                  ),
              ],
            ),
          ),

          /// progress and Go button
          Row(
            children: [
              if (task.progress != null)

                /// track progress
                Text(
                  task.progress!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: MyAppColors.blackColor,
                  ),
                ),
              SizedBoxExtensions.withWidth(12),

              /// Go button
              _buildGoButton(),
            ],
          ),
        ],
      ),
    );
  }

  /// Build Go button
  Widget _buildGoButton() {
    return ElevatedButton(
      onPressed: task.onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: MyAppColors.dullRedColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        task.buttonText ?? 'Go', // Use buttonText if provided
        style: const TextStyle(color: MyAppColors.whiteColor),
      ),
    );
  }
}
