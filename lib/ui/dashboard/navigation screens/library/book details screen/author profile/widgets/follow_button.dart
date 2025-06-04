import 'package:flutter/material.dart';
import 'package:laylah_app/utils/constants/app_colors.dart';

class FollowButtonWidget extends StatefulWidget {
  const FollowButtonWidget({super.key});

  @override
  State<FollowButtonWidget> createState() => _FollowButtonWidgetState();
}

class _FollowButtonWidgetState extends State<FollowButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: MyAppColors.dullRedColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        minimumSize: const Size(150, 40),
      ),
      child: const Text(
        'Follow',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
