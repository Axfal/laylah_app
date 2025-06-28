// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laylah_app/utils/constants/exports.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({super.key});

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  final List<String> years = ['2025', '2024', '2023'];
  String selectedYear = '2025';

  final Map<String, List<Map<String, dynamic>>> incomeByYear = {
    '2025': [
      {'month': 'January', 'income': 200},
      {'month': 'February', 'income': 300},
      {'month': 'March', 'income': 400},
      {'month': 'April', 'income': 250},
      {'month': 'May', 'income': 500},
      {'month': 'June', 'income': 500},
    ],
    '2024': [
      {'month': 'January', 'income': 150},
      {'month': 'February', 'income': 220},
      {'month': 'March', 'income': 180},
      {'month': 'April', 'income': 350},
      {'month': 'May', 'income': 400},
    ],
    '2023': [
      {'month': 'January', 'income': 100},
      {'month': 'February', 'income': 200},
    ],
  };

  @override
  Widget build(BuildContext context) {
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileHeader(),
              const SizedBox(height: 24),
              _buildIncomeSummary(),
              const SizedBox(height: 32),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Monthly Income - $selectedYear',
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  DropdownButton<String>(
                    value: selectedYear,
                    borderRadius: BorderRadius.circular(12),
                    dropdownColor: Colors.white,
                    elevation: 4,
                    underline: Container(),
                    icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
                    items: years
                        .map((year) => DropdownMenuItem<String>(
                      value: year,
                      child: Text(year,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                    ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => selectedYear = value);
                      }
                    },
                  ),
                ],
              ),
        
              const SizedBox(height: 16),
        
              Column(
                children: incomeByYear[selectedYear]!
                    .map((item) => _buildMonthlyIncomeCard(
                  month: item['month'],
                  income: item['income'],
                ))
                    .toList(),
              ),
        
              const SizedBox(height: 32),
              Text('Income Details',
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w600)),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: MyAppColors.dullRedColor, width: 2),
          ),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/images/default_profile.png'),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Muhammad Anfal',
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            Text('anfalshah72@gmail.com',
                style:
                GoogleFonts.poppins(color: Colors.grey, fontSize: 13)),
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
                Icons.account_balance_wallet, MyAppColors.dullRedColor),
            const SizedBox(width: 16),
            _incomeCard('Bonus', 'PKR 250', Icons.card_giftcard, MyAppColors.dullRedColor),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _incomeCard('Rewards', 'PKR 100', Icons.star, MyAppColors.dullRedColor),
            const SizedBox(width: 16),
            _incomeCard(
                'Ad Revenue', 'PKR 300', Icons.monetization_on, MyAppColors.dullRedColor),
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
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(title,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 14)),
            Text(amount,
                style: GoogleFonts.poppins(
                    color: color,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyIncomeCard({required String month, required int income}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  MyAppColors.dullRedColor.withOpacity(0.8),
                  MyAppColors.dullRedColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(Icons.calendar_month, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  month,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Income this month',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Text(
            'PKR $income',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.green.shade700,
            ),
          ),
        ],
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
                  Text(title,
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: GoogleFonts.poppins(
                          fontSize: 13, color: Colors.grey.shade600)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.monetization_on,
                          color: Colors.green, size: 18),
                      const SizedBox(width: 6),
                      Text("PKR $income",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600, fontSize: 14)),
                      const Spacer(),
                      Text(date,
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: Colors.grey)),
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
