// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laylah_app/utils/extensions/sized_box_extension.dart';
import 'package:laylah_app/utils/constants/app_colors.dart';
import '../providers/contract_provider.dart';

class ContractType extends StatelessWidget {
  final String label;
  final List<String> options;
  final int contractIndex;

  const ContractType({
    super.key,
    required this.label,
    required this.options,
    required this.contractIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
        SizedBoxExtensions.withHeight(10),

        /// Options
        Consumer<ContractProvider>(
          builder: (context, contractProvider, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(options.length, (index) {
                final bool isSelected =
                    contractProvider.selectedIndexes[contractIndex] == index;

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      contractProvider.selectContractOption(
                        contractIndex,
                        index,
                        options[index],
                      );
                      print(
                          "selected valued are = > ${contractProvider.selectedValues}");
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? MyAppColors.dullRedColor
                            : MyAppColors.lightGreyColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: isSelected
                              ? MyAppColors.dullRedColor
                              : MyAppColors.greyColor.withValues(alpha: 0.6),
                          width: 1.2,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: MyAppColors.dullRedColor
                                      .withValues(alpha: 0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            : [],
                      ),
                      child: Center(
                        child: Text(
                          options[index],
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? MyAppColors.whiteColor
                                : MyAppColors.blackColor.withValues(alpha: 0.8),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ],
    );
  }
}
