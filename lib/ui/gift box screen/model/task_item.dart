import 'dart:ui';

class TaskItem {
  final String title;
  final String subtitle;
  final String? progress;
  final String? buttonText;
  final VoidCallback onTap;

  TaskItem({
    required this.title,
    required this.subtitle,
    this.progress,
    this.buttonText,
    required this.onTap,
  });
}
