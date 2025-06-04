import 'package:flutter/material.dart';
import 'package:laylah_app/utils/constants/app_colors.dart';

class BottomCardWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;

  const BottomCardWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// Book Image
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            imageUrl,
            width: 80,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),

        /// Title
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 2,
        ),

        /// Subtitle
        Container(
          width: 75,
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: MyAppColors.lightGreyColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Center(
            child: Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                // color: MyAppColors.greyColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
