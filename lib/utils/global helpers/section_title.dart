import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class SectionTitleHelper {
  static Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: RichText(
        text: TextSpan(
          children: [
            const TextSpan(
              text: '*  ',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: MyAppColors.dullRedColor,
              ),
            ),
            TextSpan(
              text: title.replaceFirst('*', ' '),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: MyAppColors.blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
