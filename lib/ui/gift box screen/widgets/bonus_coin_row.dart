import 'package:flutter/material.dart';
import 'package:laylah_app/utils/extensions/sized_box_extension.dart';
import '../../../utils/constants/app_colors.dart';

class BonusCoinsRow extends StatelessWidget {
  final int bonus;

  const BonusCoinsRow({super.key, required this.bonus});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Icon(Icons.monetization_on_outlined,
            color: Colors.orange,
            size: 26
        ),
        SizedBoxExtensions.withWidth(8),
        Text(
          '$bonus Bonus',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: MyAppColors.whiteColor,
          ),
        ),
        SizedBoxExtensions.withWidth(15),
      ],
    );
  }
}
