import 'package:flutter/material.dart';
import 'package:laylah_app/utils/constants/app_colors.dart';

class RewardScreen extends StatelessWidget {
  const RewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF8),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    color: MyAppColors.dullRedColor,
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 20,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/coin.png',
                        width: 30,
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        '35',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text('Bonus')
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'Check-in Streak',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD72660),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(7, (index) {
                        return Column(
                          children: [
                            Image.asset('assets/icons/coin.png', width: 30),
                            Text('+15'),
                            Text('Day ${index + 1}')
                          ],
                        );
                      }),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF8BBD0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('Check-In'),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildTaskSection('Daily Task', [
              _buildTaskItem(
                  'Watch video to earn bouns', 'Earn 3  bouns on each video',
                  trailing: '(0/7)'),
              _buildTaskItem('Top Up', 'Earn 20 with first top up of the day',
                  trailing: '20'),
              _buildReadingTask(),
              _buildTaskItem('Comment', 'Earn 1 coin for each comment',
                  trailing: '1'),
            ]),
            _buildTaskSection('New User Task', [
              _buildTaskItem('Login', 'Login to earn 10 bonus coin'),
            ])
          ],
        ),
      ),
    );
  }

  Widget _buildTaskSection(String title, List<Widget> tasks) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: const BoxDecoration(
              color: Colors.pinkAccent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6),
                bottomRight: Radius.circular(6),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          ...tasks
        ],
      ),
    );
  }

  Widget _buildTaskItem(String title, String subtitle, {String? trailing}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF8BBD0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Go'),
                ),
                if (trailing != null) ...[
                  const SizedBox(height: 5),
                  Text(trailing)
                ]
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildReadingTask() {
    final times = ['5min', '10min', '20min', '40min', '80min'];
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Reading Task 0/80 mins',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: times
                  .map((t) => Column(
                        children: [
                          Image.asset('assets/icons/coin.png', width: 30),
                          Text(t),
                        ],
                      ))
                  .toList(),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF8BBD0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Go'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
