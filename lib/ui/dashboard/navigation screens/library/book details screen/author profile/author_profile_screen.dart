import 'package:flutter/material.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/library/book%20details%20screen/author%20profile/widgets/followers_and_work.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/library/book%20details%20screen/author%20profile/widgets/profile_info.dart';
import 'package:laylah_app/utils/constants/app_colors.dart';


class AuthorProfileScreen extends StatelessWidget {
  const AuthorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: MyAppColors.whiteColor,
      body: const Column(
        children: [
          /// Profile Info with floating text
          ProfileInfo(),
          FollowersAndWorkWidget(),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: MyAppColors.dullRedColor,
      /// back icon
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: MyAppColors.whiteColor,
        ),
      ),
      centerTitle: true,
      /// title
      title: const Text('Author Profile',
        style: TextStyle(
          color: MyAppColors.whiteColor,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}
