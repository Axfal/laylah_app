// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/profile/edit_profile_screen.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/profile/profile%20stats/followers_card.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/profile/social%20links/social_links.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/profile/wallet%20section/wallet_section.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/write/provider/author_center_provider.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/exports.dart';
import '../../../../utils/extensions/sized_box_extension.dart';
import '../../../auth/login_screen.dart';
import '../../../gift box screen/gift_box_screen.dart';
import 'options/options_list.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.whiteColor,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(context),
            _buildFollowersSection(),
            const WalletSection(),
            const OptionList(),
            const MySocialLinks(),
          ],
        ),
      ),
    );
  }

  /// AppBar
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: MyAppColors.dullRedColor,
      surfaceTintColor: Colors.transparent,
      title: const Text(
        'Profile',
        style: TextStyle(
          color: MyAppColors.whiteColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(builder: (context) => const GiftBoxScreen()),
            // );
          },
          child: Image.asset(
            'assets/icons/gift_box.png',
            width: 25,
            height: 25,
          ),
        ),
        SizedBoxExtensions.withWidth(20),
        IconButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              final authCenterProvider = Provider.of<AuthorCenterProvider>(context, listen: false);
              authCenterProvider.clearChaptersForBook();
              await prefs.remove('user_id');
              print("user_id removed from SharedPreferences and chapter from author center map deleted");

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            icon: Icon(
              Icons.login,
              color: Colors.white,
            )),
        SizedBoxExtensions.withWidth(15),
      ],
    );
  }

  Widget _buildProfileHeader(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
      child: Stack(
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              gradient: const LinearGradient(
                colors: [MyAppColors.dullRedColor, MyAppColors.darkGreyColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/default_profile.png",
                      fit: BoxFit.cover,
                      width: 75,
                      height: 75,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Muhammad Anfal',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: MyAppColors.whiteColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'anfal.cs.31@gmail.com',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> EditProfileScreen()));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(8.0),
                child: const Icon(
                  Icons.edit,
                  color: MyAppColors.dullRedColor,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Followers section
  Widget _buildFollowersSection() {
    return const Padding(
      padding: EdgeInsets.symmetric(
          vertical: 10.0), // Added padding for better spacing
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FollowersCard(title: 'Followers', value: '0', icon: Icons.group),
          FollowersCard(
              title: 'Following', value: '63', icon: Icons.person_add),
        ],
      ),
    );
  }
}
