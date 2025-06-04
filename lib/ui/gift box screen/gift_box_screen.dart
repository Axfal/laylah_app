import 'package:flutter/material.dart';
import 'package:laylah_app/ui/gift%20box%20screen/widgets/bonus_coin_row.dart';
import 'package:laylah_app/ui/gift%20box%20screen/widgets/check_in_section.dart';
import 'package:laylah_app/ui/gift%20box%20screen/widgets/task_section.dart';
import 'package:laylah_app/utils/extensions/sized_box_extension.dart';
import '../../utils/constants/app_colors.dart';
import 'model/task_item.dart';

class GiftBoxScreen extends StatelessWidget {
  const GiftBoxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      /// main container
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              MyAppColors.dullRedColor,
              MyAppColors.dullRedColor,
              MyAppColors.darkGreyColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BonusCoinsRow(bonus: 65),
              SizedBoxExtensions.withHeight(16),
              const CheckInSection(),
              SizedBoxExtensions.withHeight(16),
              TaskSection(
                title: 'Daily Task',
                tasks: [
                  TaskItem(
                    title: 'Watch video to earn bonus',
                    subtitle: 'Earn 3 Bonus coins on each video',
                    progress: '0/7',
                    onTap: () {},
                  ),
                  TaskItem(
                    title: 'Top Up',
                    subtitle: 'Top up today and earn 20 bonus coins',
                    onTap: () {},
                  ),
                  TaskItem(
                    title: 'Reading task 0/80 min',
                    subtitle: '',
                    onTap: () {},
                  ),
                  TaskItem(
                    title: 'Leave a comment',
                    subtitle: 'Leave a comment today to earn a coin',
                    progress: '0/5',
                    onTap: () {},
                  ),
                ],
              ),
              SizedBoxExtensions.withHeight(16),
              TaskSection(
                title: 'New User Task',
                tasks: [
                  TaskItem(
                    title: 'Log in',
                    subtitle: 'Login to earn ten bonus coins',
                    onTap: () {},
                  ),
                ],
              ),
              SizedBoxExtensions.withHeight(16),
              /// bottom text
              const Center(
                child: Text(
                  'All the bonus coins have an expiry of seven days',
                  style: TextStyle(
                    fontSize: 14,
                    color: MyAppColors.blackColor,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: MyAppColors.dullRedColor,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      title: const Text(
        'Gift Center',
        style: TextStyle(
          color: MyAppColors.whiteColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
