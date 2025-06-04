import 'package:flutter/material.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/extensions/sized_box_extension.dart';

class CheckInSection extends StatelessWidget {
  const CheckInSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          /// Header text
          const Text(
            'Check-in Streak',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: MyAppColors.blackColor,
            ),
          ),
          SizedBoxExtensions.withHeight(16),
          /// Streaks row
          _buildStreakRow(),
          SizedBoxExtensions.withHeight(16),
          /// check in button
          _buildCheckInButton(),
        ],
      ),
    );
  }

  /// Streaks row
  Widget _buildStreakRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(7, (index) {
        final isFinalDay = index == 6;
        return Column(
          children: [
            Icon(
              isFinalDay ? Icons.card_giftcard : Icons.monetization_on,
              color: Colors.orange,
              size: 32,
            ),
            const SizedBox(height: 8),
            const Text(
              '+15',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Text(
              'Day ${index + 1}',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        );
      }),
    );
  }

  /// check in button
  Widget _buildCheckInButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: MyAppColors.dullRedColor,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: const Text(
        'Check-in',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: MyAppColors.whiteColor,
        ),
      ),
    );
  }
}
