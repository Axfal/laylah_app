import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laylah_app/utils/constants/app_colors.dart';
import '../../../../../../../../utils/extensions/sized_box_extension.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextInputType keyboardType;
  final bool showInfoIcon;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.showInfoIcon = false,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Label with optional info icon
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: MyAppColors.blackColor,
              ),
            ),
            if (showInfoIcon) ...[
              const SizedBox(width: 6),
              const Icon(
                Icons.info_outline,
                color: MyAppColors.greyColor,
                size: 18,
              ),
            ],
          ],
        ),

        SizedBoxExtensions.withHeight(8),

        /// Visible & Stylish TextField
        TextField(
          keyboardType: keyboardType,
          controller: controller,
          cursorColor: MyAppColors.dullRedColor,
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: MyAppColors.blackColor,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            hintText: hint,
            hintStyle: GoogleFonts.poppins(
              color: MyAppColors.greyColor.withValues(alpha: 0.8),
              fontSize: 14.5,
            ),
            filled: true,
            fillColor: MyAppColors.lightGreyColor.withValues(alpha: 0.2),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: MyAppColors.greyColor.withValues(alpha: 0.4),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: MyAppColors.dullRedColor,
                width: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
