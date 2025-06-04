import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laylah_app/utils/constants/app_colors.dart';
import 'package:laylah_app/utils/extensions/sized_box_extension.dart';
import 'package:provider/provider.dart';
import '../providers/personal_info_provider.dart';

class AgeSelector extends StatelessWidget {
  const AgeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Age',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: MyAppColors.blackColor,
          ),
        ),
        SizedBoxExtensions.withHeight(16),
        Consumer<PersonalInfoProvider>(
          builder: (context, personalInfoProvider, child) {
            return Row(
              children: [
                _buildChoiceChip(
                  label: 'Under 18',
                  selected: personalInfoProvider.isUnder18,
                  onTap: () => personalInfoProvider.setAgeStatus(true),
                ),
                SizedBoxExtensions.withWidth(12),
                _buildChoiceChip(
                  label: 'Above 18',
                  selected: !personalInfoProvider.isUnder18,
                  onTap: () => personalInfoProvider.setAgeStatus(false),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildChoiceChip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: selected
                ? MyAppColors.dullRedColor
                : MyAppColors.lightGreyColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: selected ? MyAppColors.dullRedColor : Colors.grey.shade300,
              width: 1.2,
            ),
            boxShadow: selected
                ? [
              BoxShadow(
                color: MyAppColors.dullRedColor.withOpacity(0.2),
                blurRadius: 6,
                offset: const Offset(0, 3),
              )
            ]
                : [],
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: selected
                    ? MyAppColors.whiteColor
                    : MyAppColors.blackColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
