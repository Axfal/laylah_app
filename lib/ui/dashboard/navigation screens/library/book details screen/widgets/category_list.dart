import 'package:flutter/material.dart';
import 'package:laylah_app/utils/constants/app_colors.dart';

class CategoryList extends StatelessWidget {
  final String label;

  const CategoryList({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: MyAppColors.lightGreyColor,
      shape: const StadiumBorder(
        side: BorderSide(
          color: Colors.transparent,
          width: 0,
        ),
      ),
    );
  }
}
