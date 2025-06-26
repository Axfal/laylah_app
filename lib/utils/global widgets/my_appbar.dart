// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../ui/gift box screen/gift_box_screen.dart';
import '../constants/app_colors.dart';
import '../extensions/sized_box_extension.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color? backgroundColor;
  final double elevation;
  final VoidCallback? onNotificationPressed;

  const MyAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.centerTitle = false,
    this.backgroundColor,
    this.elevation = 4,
    this.onNotificationPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? MyAppColors.dullRedColor,
      elevation: elevation,
      surfaceTintColor: Colors.transparent,
      centerTitle: centerTitle,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(12),
        ),
      ),
      title: Text(
        title ?? 'Laylah',
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          color: MyAppColors.whiteColor,
        ),
      ),
      leading: leading,
      actions: actions ?? _defaultActions(context),
    );
  }

  List<Widget> _defaultActions(BuildContext context) {
    return [
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
    ];
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
