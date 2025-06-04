import 'package:flutter/material.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../author section/novel info/novel_information_screen.dart';

class AddBookButton extends StatelessWidget {
  const AddBookButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const NovelInformationScreen()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: MyAppColors.dullRedColor,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: const Text(
        'Apply',
        style: TextStyle(
          color: MyAppColors.whiteColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
