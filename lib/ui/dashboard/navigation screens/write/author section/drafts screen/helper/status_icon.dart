import 'package:flutter/material.dart';
import '../../../../../../../utils/constants/app_colors.dart';

class StatusIconWithText extends StatelessWidget {
  final IconData icon;
  final String text;

  const StatusIconWithText({
    required this.icon,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: MyAppColors.greyColor,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: MyAppColors.greyColor,
            ),
          ),
        ],
      ),
    );
  }
}