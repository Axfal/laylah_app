import 'package:flutter/material.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/write/author%20section/novel%20info/widgets/description_form.dart';
import '../../../../../../utils/constants/app_colors.dart';

class NovelInformationScreen extends StatelessWidget {
  const NovelInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.whiteColor,
      appBar: _buildAppBar(context),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            DescriptionForm(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: MyAppColors.dullRedColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          color: MyAppColors.whiteColor,
        ),
      ),
      centerTitle: true,
      title: const Text(
        'Novel Information',
        style: TextStyle(
            color: MyAppColors.whiteColor, fontWeight: FontWeight.w500),
      ),
      actions: [
        /// skip button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: InkWell(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ApplyForContract()),
              // );
            },
            child: const Text(
              'SKIP ➔',
              style: TextStyle(
                color: MyAppColors.whiteColor,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
