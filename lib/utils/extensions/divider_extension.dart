import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

extension DividerExtension on BuildContext {
  /// A reusable divider with custom thickness and color.
  Divider customDivider({double thickness = 1, Color? color}) {
    return Divider(
      thickness: thickness,
      color: color ?? MyAppColors.lightGreyColor,
    );
  }
}
