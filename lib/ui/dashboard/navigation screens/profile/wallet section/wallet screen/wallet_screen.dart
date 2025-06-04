import 'package:flutter/material.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/profile/wallet%20section/wallet%20screen/widgets/total_balance.dart';
import 'package:laylah_app/ui/gift%20box%20screen/gift_box_screen.dart';
import '../../../../../../utils/constants/app_colors.dart';
import '../../../../../../utils/extensions/sized_box_extension.dart';

class MyWalletScreen extends StatelessWidget {
  const MyWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TotalBalanceWidget(),
              const SizedBox(height: 16),
              _buildBonusCoinsInfo(context),
              const SizedBox(height: 16),
              _buildTransactionHistory(context),

              const SizedBox(height: 16),
              _buildBonusCoinsHistory(context),
              const SizedBox(height: 16),
              _buildCoinUsageInfo(context),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: MyAppColors.dullRedColor,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          color: MyAppColors.whiteColor,
        ),
      ),
      title: const Text(
        'My Wallet',
        style: TextStyle(
          color: MyAppColors.whiteColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildBonusCoinsInfo(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.card_giftcard, size: 40, color: MyAppColors.dullRedColor),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Bonus Coins",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Earn bonus coins by completing tasks",
                    style: TextStyle(fontSize: 14, color: MyAppColors.greyColor),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  "Go ",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: MyAppColors.dullRedColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GiftBoxScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.arrow_circle_right, color: MyAppColors.dullRedColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionHistory(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Transaction History",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            ListTile(
              leading: Icon(Icons.shopping_cart, color: MyAppColors.dullRedColor),
              title: Text("Used"),
              subtitle: Text("January 7, 2025"),
              trailing: Text("-500", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            ),

            ListTile(
              leading: Icon(Icons.add_circle_outline, color: MyAppColors.dullRedColor),
              title: Text("Top-up"),
              subtitle: Text("December 8, 2024"),
              trailing: Text("+584", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBonusCoinsHistory(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Bonus Coins History",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Bonus Points 750',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Divider(),
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    ListTile(
                      leading: Icon(Icons.card_giftcard, color: MyAppColors.dullRedColor),
                      title: Text("Task Completion Reward"),
                      subtitle: Text("January 8, 2025"),
                      trailing: Text("+200", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                    ),
                    ListTile(
                      leading: Icon(Icons.shopping_cart, color: MyAppColors.dullRedColor),
                      title: Text("Used"),
                      subtitle: Text("January 2, 2025"),
                      trailing: Text("-50", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    ),
                    ListTile(
                      leading: Icon(Icons.card_giftcard, color: MyAppColors.dullRedColor),
                      title: Text("Task Completion Reward"),
                      subtitle: Text("January 8, 2025"),
                      trailing: Text("+200", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                    ),
                    ListTile(
                      leading: Icon(Icons.card_giftcard, color: MyAppColors.dullRedColor),
                      title: Text("Task Completion Reward"),
                      subtitle: Text("January 8, 2025"),
                      trailing: Text("+200", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                    ),
                    ListTile(
                      leading: Icon(Icons.shopping_cart, color: MyAppColors.dullRedColor),
                      title: Text("Used"),
                      subtitle: Text("January 2, 2025"),
                      trailing: Text("-400", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    ),
                    ListTile(
                      leading: Icon(Icons.card_giftcard, color: MyAppColors.dullRedColor),
                      title: Text("Task Completion Reward"),
                      subtitle: Text("January 8, 2025"),
                      trailing: Text("+200", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCoinUsageInfo(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 1,
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "How to Use Coins?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "1. Use coins to read chapters.\n"
                    "2. Redeem coins for exclusive offers.\n"
                    "3. Participate in events to earn more coins!",
                style: TextStyle(fontSize: 14, color: MyAppColors.greyColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
