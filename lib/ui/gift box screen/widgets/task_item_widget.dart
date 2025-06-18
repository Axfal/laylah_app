import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/extensions/sized_box_extension.dart';
import '../model/task_item.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskItem task;

  const TaskItemWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          /// Text section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: MyAppColors.blackColor,
                  ),
                ),
                if (task.subtitle.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      task.subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: MyAppColors.greyColor.withOpacity(0.8),
                        height: 1.3,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBoxExtensions.withWidth(12),

          /// Progress & Button section
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (task.progress != null)
                Text(
                  task.progress!,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: MyAppColors.blackColor.withOpacity(0.85),
                  ),
                ),
              SizedBoxExtensions.withHeight(8),
              SizedBox(
                height: 36,
                child: OutlinedButton.icon(
                  onPressed: task.onTap,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: MyAppColors.dullRedColor, width: 1.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    backgroundColor: Colors.transparent,
                    foregroundColor: MyAppColors.dullRedColor,
                    textStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  icon: const Icon(Icons.arrow_forward_ios, size: 14),
                  label: Text(task.buttonText ?? 'Go'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
