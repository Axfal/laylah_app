// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laylah_app/utils/constants/app_colors.dart';

class RewardScreen extends StatelessWidget {
  const RewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF8),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor: MyAppColors.dullRedColor,
          elevation: 4,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          title: Text(
            "My Rewards",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                    icon: Icon(Icons.notifications_none, color: Colors.white, size: 24),
                    onPressed: () {},
                  ),
                  // Notification dot
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBalanceCard(),
              SizedBox(height: 20),
              _buildCheckInCard(),
              SizedBox(height: 20),
              _buildTaskSection('Daily Tasks', [
                _buildTaskItem('Watch videos', 'Earn 3 coins on each video', trailing: '(0/7)'),
                _buildTaskItem('Top Up', 'Earn 20 coins with first top-up of the day', trailing: '20'),
                _buildReadingTask(),
                _buildTaskItem('Comment', 'Earn 1 coin for each comment', trailing: '1'),
              ]),
              _buildTaskSection('New User Tasks', [
                _buildTaskItem('Login', 'Login to earn 10 bonus coins'),
              ]),
              SizedBox(height: 30),
              Center(
                child: Text(
                  'More Ways to Earn Coming Soon...',
                  style: GoogleFonts.poppins(fontStyle: FontStyle.italic, fontSize: 14, color: Colors.grey),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MyAppColors.dullRedColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
      ),
      child: Row(
        children: [
          Image.asset('assets/icons/laylah_coins.png', width: 40),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Current Balance', style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14)),
              Text('35 Coins',
                  style: GoogleFonts.poppins(
                      fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCheckInCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Check-in Streak',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: MyAppColors.dullRedColor,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (index) {
              return Column(
                children: [
                  Image.asset('assets/icons/laylah_coins.png', width: 28),
                  SizedBox(height: 4),
                  Text('+15', style: GoogleFonts.poppins(fontSize: 13)),
                  Text('Day ${index + 1}', style: GoogleFonts.poppins(fontSize: 12)),
                ],
              );
            }),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: MyAppColors.dullRedColor,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 4,
            ),
            child: Text(
              'Check-In',
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTaskSection(String title, List<Widget> tasks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        ...tasks
      ],
    );
  }

  Widget _buildTaskItem(String title, String subtitle, {String? trailing}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Text(subtitle, style: GoogleFonts.poppins(fontSize: 13)),
              ],
            ),
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyAppColors.dullRedColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text('Go', style: GoogleFonts.poppins(color: Colors.white, fontSize: 14)),
              ),
              if (trailing != null) ...[
                const SizedBox(height: 6),
                Text(trailing, style: GoogleFonts.poppins(fontSize: 12)),
              ]
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReadingTask() {
    final times = ['5min', '10min', '20min', '40min', '80min'];
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reading Task 0/80 mins',
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: times
                .map((t) => Column(
              children: [
                Image.asset('assets/icons/laylah_coins.png', width: 28),
                const SizedBox(height: 4),
                Text(t, style: GoogleFonts.poppins(fontSize: 12)),
              ],
            ))
                .toList(),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: MyAppColors.dullRedColor,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Go',
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
              ),
            ),
          )
        ],
      ),
    );
  }
}