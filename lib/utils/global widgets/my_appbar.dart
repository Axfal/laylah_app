// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../ui/gift box screen/gift_box_screen.dart';
import '../constants/app_colors.dart';
import '../extensions/sized_box_extension.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onNotificationPressed;

  const MyAppBar({super.key, this.onNotificationPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MyAppColors.dullRedColor,
      elevation: 4,
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(12),
        ),
      ),
      title: const Text(
        'Laylah',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          color: MyAppColors.whiteColor,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Row(
            children: [
              IconButton(
                onPressed: onNotificationPressed ?? () {},
                icon: const Icon(Icons.search_rounded),
                iconSize: 24,
                color: MyAppColors.whiteColor,
                tooltip: "Search",
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined),
                iconSize: 24,
                color: MyAppColors.whiteColor,
                tooltip: "Notifications",
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const RewardScreen()),
                  );
                },
                borderRadius: BorderRadius.circular(50),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Image.asset(
                    'assets/icons/gift_box.png',
                    width: 22,
                    height: 22,
                    color: MyAppColors.whiteColor,
                  ),
                ),
              ),
              SizedBoxExtensions.withWidth(6),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
