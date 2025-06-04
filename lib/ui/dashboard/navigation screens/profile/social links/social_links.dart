import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_colors.dart';

class MySocialLinks extends StatelessWidget {
  const MySocialLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Row(
          children: [
            _buildSocialButton('Follow us on Facebook', Colors.blueAccent, Icons.facebook),
            _buildSocialButton('Follow us on Instagram', Colors.deepOrangeAccent, Icons.camera_alt_rounded),
            _buildSocialButton('Follow us on Website', MyAppColors.dullRedColor, Icons.laptop_chromebook_outlined),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(String label, Color color, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(icon, color: MyAppColors.whiteColor),
        label: Text(
          label,
          style: const TextStyle(color: MyAppColors.whiteColor),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
