// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:laylah_app/utils/constants/exports.dart';

class IncomeScreen extends StatelessWidget {
  const IncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: MyAppBar(
        title: "Income Section",
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        actions: [],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _buildIncomeSummary(),
            const SizedBox(height: 32),
            Text('Income Details', style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),
            _buildBookIncomeCard(
              imageUrl: 'https://via.placeholder.com/60',
              title: 'Atomic Habits',
              subtitle: ' James Clear',
              income: 1200,
              date: '2025-06-26',
            ),
            _buildBookIncomeCard(
              imageUrl: 'https://invalidurl.com/image.jpg',
              title: 'The Forty Rules of Love',
              subtitle: 'Elif Shafak',
              income: 950,
              date: '2025-06-24',
            ),
            _buildBookIncomeCard(
              imageUrl: 'https://invalidurl.com/image.jpg',
              title: 'Rich Dad Poor Dad',
              subtitle: 'Robert T. Kiyosaki',
              income: 950,
              date: '2025-06-24',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2), // border width
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: MyAppColors.dullRedColor, width: 2),
          ),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/images/default_profile.png'),
            onBackgroundImageError: (_, __) {},
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Muhammad Anfal',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'anfalshah72@gmail.com',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIncomeSummary() {
    return Column(
      children: [
        Row(
          children: [
            _incomeCard('Total Income', 'PKR 2150',
                Icons.account_balance_wallet, Colors.green),
            const SizedBox(width: 16),
            _incomeCard('Bonus', 'PKR 250', Icons.card_giftcard, Colors.orange),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _incomeCard('Rewards', 'PKR 100', Icons.star, Colors.blue),
            const SizedBox(width: 16),
            _incomeCard(
                'Ad Revenue', 'PKR 300', Icons.monetization_on, Colors.purple),
          ],
        ),
      ],
    );
  }

  Widget _incomeCard(String title, String amount, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            Text(
              amount,
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookIncomeCard({
    required String imageUrl,
    required String title,
    required String subtitle,
    required int income,
    required String date,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imageUrl,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 70,
                  height: 70,
                  color: Colors.grey.shade200,
                  child: Icon(Icons.broken_image_outlined, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.monetization_on, color: Colors.green, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        "PKR $income",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
