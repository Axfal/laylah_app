import 'package:flutter/material.dart';
import 'package:laylah_app/utils/constants/app_colors.dart';

class FollowersAndWorkWidget extends StatelessWidget {
  const FollowersAndWorkWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          /// Followers
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Followers',
                style: TextStyle(
                  color: MyAppColors.dullRedColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),
              ),
              Text('10k',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                ),
              )
            ],
          ),

          /// Works
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Works',
                style: TextStyle(
                    color: MyAppColors.dullRedColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                ),
              ),
              Text('7',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
