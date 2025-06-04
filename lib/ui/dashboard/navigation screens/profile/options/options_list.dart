import 'package:flutter/material.dart';
import '../../../../../utils/constants/app_colors.dart';

class OptionList extends StatelessWidget {
  const OptionList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> options = [
      {'title': 'Notifications', 'icon': Icons.notifications_active_rounded},
      {'title': 'Chat', 'icon': Icons.chat_rounded},
      {'title': 'Become a Writer', 'icon': Icons.edit_rounded},
      {'title': 'Feedback', 'icon': Icons.feedback_rounded},
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: options.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(options[index]['icon'], color: MyAppColors.greyColor),
          title: Text(options[index]['title'],style: const TextStyle(color: MyAppColors.blackColor),),
          trailing: const Icon(Icons.arrow_forward_ios, color: MyAppColors.greyColor),
          onTap: () {},
        );
      },
    );
  }
}
