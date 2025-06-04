import 'package:flutter/cupertino.dart';

import '../../../../../utils/constants/app_colors.dart';

class FollowersCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const FollowersCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Container(
        width: 150,
        height: 70,
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: MyAppColors.dullRedColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: MyAppColors.whiteColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: MyAppColors.whiteColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
