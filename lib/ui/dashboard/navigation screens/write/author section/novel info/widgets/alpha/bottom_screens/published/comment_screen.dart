// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:laylah_app/utils/constants/app_colors.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  CommentScreenState createState() => CommentScreenState();
}

class CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();
  final List<String> _comments = [
    'Great chapter! Loved the writing.',
    'Can\'t wait for the next one!',
    'The plot twist was unexpected. Amazing!',
  ];

  void _postComment() {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        _comments.insert(0, _commentController.text);
      });
      _commentController.clear();
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Comments', style: TextStyle(color: Colors.white)),
        backgroundColor: MyAppColors.dullRedColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: MyAppColors.whiteColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: _comments.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage('assets/user_avatar.jpg'),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'User $index',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    '5 mins ago',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            _comments[index],
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.thumb_up_alt_outlined, color: Colors.grey, size: 20),
                              SizedBox(width: 4),
                              Text('25', style: TextStyle(color: Colors.grey[600])),
                              Spacer(),
                              Icon(Icons.reply_outlined, color: Colors.grey, size: 20),
                              SizedBox(width: 4),
                              Text('Reply', style: TextStyle(color: Colors.grey[600])),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(height: 1),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/user_avatar.jpg'),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                          hintText: 'Write a comment...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  IconButton(
                    icon: Icon(Icons.send_rounded, color: MyAppColors.dullRedColor),
                    onPressed: _postComment,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
