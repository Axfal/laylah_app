import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laylah_app/utils/constants/app_colors.dart';
import 'package:laylah_app/utils/extensions/sized_box_extension.dart';
import 'package:provider/provider.dart';
import '../providers/contract_provider.dart';

class NumberOfYears extends StatelessWidget {
  final String label;
  final String hint;

  const NumberOfYears({
    super.key,
    required this.label,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Label
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: MyAppColors.blackColor,
            ),
          ),
          SizedBoxExtensions.withHeight(8),

          /// Selectable container
          GestureDetector(
            onTap: () {
              _showYearSelectionBottomSheet(context);
            },
            child: Consumer<ContractProvider>(
              builder: (context, provider, child) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  decoration: BoxDecoration(
                    color: MyAppColors.lightGreyColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: MyAppColors.lightGreyColor.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _getSelectedYearText(provider.selectedYear),
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: MyAppColors.greyColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: MyAppColors.greyColor,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Get selected year as string
  String _getSelectedYearText(int year) {
    switch (year) {
      case 2:
        return '2 Years';
      case 3:
        return '3 Years';
      case 4:
        return '4 Years';
      case 5:
        return '5 Years';
      default:
        return hint;
    }
  }

  /// Bottom Sheet for Year Selection
  void _showYearSelectionBottomSheet(BuildContext context) {
    final provider = Provider.of<ContractProvider>(context, listen: false);
    final selected = provider.selectedYear;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select Duration',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: MyAppColors.blackColor,
                  ),
                ),
                const SizedBox(height: 10),
                ...[2, 3, 4, 5]
                    .map((year) => _buildYearListTile(context, year, selected))
                    .toList(),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Styled Year Option
  Widget _buildYearListTile(BuildContext context, int year, int selected) {
    final isSelected = year == selected;

    return ListTile(
      leading: isSelected
          ? const Icon(Icons.check_circle, color: MyAppColors.dullRedColor)
          : const Icon(Icons.radio_button_unchecked, color: Colors.grey),
      title: Text(
        '$year Years',
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isSelected ? MyAppColors.dullRedColor : MyAppColors.blackColor,
        ),
      ),
      onTap: () {
        _updateSelectedYear(context, year);
        Navigator.pop(context);
      },
    );
  }

  /// Update Selected Year
  void _updateSelectedYear(BuildContext context, int year) {
    final provider = Provider.of<ContractProvider>(context, listen: false);
    switch (year) {
      case 2:
        provider.selectTwoYears();
        break;
      case 3:
        provider.selectThreeYears();
        break;
      case 4:
        provider.selectFourYears();
        break;
      case 5:
        provider.selectFiveYears();
        break;
    }
  }
}
