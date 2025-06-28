import 'package:flutter/material.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/profile/chat_section/chat_screen.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/profile/notification/notification_screen.dart';
import '../../../../../utils/constants/app_colors.dart';

class OptionList extends StatelessWidget {
  const OptionList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<OptionItem> options = [
      OptionItem(title: 'Notifications', icon: Icons.notifications_active_rounded),
      OptionItem(title: 'Chat', icon: Icons.chat_rounded),
      OptionItem(title: 'Become a Writer', icon: Icons.edit_rounded),
      OptionItem(title: 'Feedback', icon: Icons.feedback_rounded),
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: options.length,
      separatorBuilder: (_, __) => const Divider(height: 1, color: Colors.black12),
      itemBuilder: (context, index) {
        final option = options[index];
        return ListTile(
          leading: Icon(option.icon, color: MyAppColors.greyColor),
          title: Text(
            option.title,
            style: const TextStyle(
              color: MyAppColors.blackColor,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18, color: MyAppColors.greyColor),
          onTap: () {
            switch (option.title) {
              case 'Chat':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatScreen()),
                );
                break;
              case 'Notifications':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotificationScreen()),
                );
                break;
            // Add other cases as needed
            }
          },
        );
      },
    );
  }
}

class OptionItem {
  final String title;
  final IconData icon;

  OptionItem({required this.title, required this.icon});
}
