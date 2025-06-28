// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:laylah_app/utils/constants/exports.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notifications = [
      {
        'type': 'follow',
        'title': 'Donal Trump started following you',
        'time': '2h ago',
        'avatarUrl': 'https://i.imgur.com/BoN9kdC.png',
        'isFollowing': false,
      },
      {
        'type': 'like',
        'title': 'Donal Trump liked your photo',
        'time': '4h ago',
        'avatarUrl': 'https://i.imgur.com/BoN9kdC.png',
        'postImage': 'https://i.imgur.com/BoN9kdC.png',
      },
      {
        'type': 'comment',
        'title': 'Modi commented: "Nice shot!"',
        'time': '1d ago',
        'avatarUrl': 'https://i.imgur.com/BoN9kdC.png',
        'postImage': 'https://i.imgur.com/BoN9kdC.png',
      },
      {
        'type': 'follow',
        'title': 'Putin started following you',
        'time': '3d ago',
        'avatarUrl': 'https://i.imgur.com/BoN9kdC.png',
        'isFollowing': true,
      },
    ];

    return Scaffold(
      appBar: MyAppBar(
        title: "Notifications",
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        actions: [],
      ),
      backgroundColor: const Color(0xFFF9F9F9),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text("Today",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ...notifications.take(2).map((noti) => _buildNotificationTile(noti)),
          const SizedBox(height: 20),
          const Text("This Week",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ...notifications.skip(2).map((noti) => _buildNotificationTile(noti)),
        ],
      ),
    );
  }

  Widget _buildNotificationTile(Map<String, dynamic> noti) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          CircleAvatar(
            radius: 26,
            backgroundImage: NetworkImage(noti['avatarUrl']),
          ),
          const SizedBox(width: 12),

          // Notification Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  noti['title'],
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  noti['time'],
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),

          // Action Button or Post Image
          if (noti['type'] == 'follow')
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor:
                    noti['isFollowing'] ? Colors.black : Colors.white,
                backgroundColor:
                    noti['isFollowing'] ? Colors.grey[300] : Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(noti['isFollowing'] ? 'Following' : 'Follow'),
            )
          else if (noti.containsKey('postImage'))
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                noti['postImage'],
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),
    );
  }
}
