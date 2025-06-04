// ignore_for_file: prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:laylah_app/main.dart';
import 'package:laylah_app/utils/constants/app_colors.dart';

class ToastHelper {
  // Constants for consistent styling
  static const double _margin = 8.0;
  static const double _borderRadius = 8.0;
  static final Color _infoTextColor = MyAppColors.whiteColor;

  static void hideCurrentSnackBar() {
    GlobalVariables.scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
  }

  static SnackBar _buildSnackBar({
    required String message,
    required Color backgroundColor,
    required Duration duration,
    bool isError = false,
    Color? textColor,
  }) {
    return SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: Theme.of(GlobalVariables.scaffoldMessengerKey.currentContext!)
            .textTheme
            .bodyMedium
            ?.copyWith(
              color: textColor ?? MyAppColors.whiteColor,
              fontWeight: FontWeight.w500,
            ),
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(_margin),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      duration: duration,
      dismissDirection:
          isError ? DismissDirection.horizontal : DismissDirection.down,
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: textColor ?? MyAppColors.whiteColor,
        onPressed: () {},
      ),
    );
  }

  static void showSuccess(String message) {
    if (GlobalVariables.scaffoldMessengerKey.currentState != null) {
      hideCurrentSnackBar();
      GlobalVariables.scaffoldMessengerKey.currentState!.showSnackBar(
        _buildSnackBar(
          message: message,
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  static void showError(String message) {
    if (GlobalVariables.scaffoldMessengerKey.currentState != null) {
      hideCurrentSnackBar();
      GlobalVariables.scaffoldMessengerKey.currentState!.showSnackBar(
        _buildSnackBar(
          message: message,
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
          isError: true,
        ),
      );
    }
  }

  static void showInfo(String message) {
    if (GlobalVariables.scaffoldMessengerKey.currentState != null) {
      hideCurrentSnackBar();
      GlobalVariables.scaffoldMessengerKey.currentState!.showSnackBar(
        _buildSnackBar(
          message: message,
          backgroundColor: Colors.indigo,
          duration: const Duration(seconds: 4),
          textColor: _infoTextColor,
        ),
      );
    }
  }
}
