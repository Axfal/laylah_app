import 'package:flutter/material.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/profile/wallet%20section/topUp%20screen/top_up_screen.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/profile/wallet%20section/wallet%20screen/wallet_screen.dart';
import '../../../../../../utils/constants/app_colors.dart';

class WalletSection extends StatelessWidget {
  const WalletSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildButton(context, 'Top Up', Icons.add_circle, const TopUpScreen()),
        _buildButton(context, 'Wallet', Icons.account_balance_wallet, const MyWalletScreen()),
      ],
    );
  }

  Widget _buildButton(BuildContext context, String label, IconData icon, Widget destinationScreen) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => destinationScreen,
            ),
          );
        },
        icon: Icon(icon, color: MyAppColors.whiteColor),
        label: Text(
          label,
          style: const TextStyle(
            color: MyAppColors.whiteColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
          backgroundColor: MyAppColors.dullRedColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          minimumSize: const Size(150, 70),
        ),
      ),
    );
  }
}
