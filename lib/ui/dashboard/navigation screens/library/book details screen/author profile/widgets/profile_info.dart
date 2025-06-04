import 'package:flutter/material.dart';
import 'package:laylah_app/utils/constants/app_colors.dart';
import 'follow_button.dart';


class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                /// Circular Image
                const CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 80,
                  // backgroundImage: AssetImage('assets/images/profile_picture.jpg'), // Your image path
                ),
                /// Floating Text
                Positioned(
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      color: MyAppColors.dullRedColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'John Doe', /// Replace with dynamic username
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Text('Author Name',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        const FollowButtonWidget()
      ],
    );
  }
}
