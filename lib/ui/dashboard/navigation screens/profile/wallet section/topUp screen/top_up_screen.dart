import 'package:flutter/material.dart';
import '../../../../../../utils/constants/app_colors.dart';
import '../../../../../../utils/extensions/sized_box_extension.dart';

class TopUpScreen extends StatelessWidget {
  const TopUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.whiteColor,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBoxExtensions.withHeight(8),
              _buildTopUpCard(context),
              SizedBoxExtensions.withHeight(170),
              _buildMainContent(context),
              SizedBoxExtensions.withHeight(16),
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
      iconTheme: const IconThemeData(color: MyAppColors.whiteColor),
      title: Text(
        'Top Up',
        style: TextStyle(
          color: MyAppColors.whiteColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          color: MyAppColors.whiteColor,
        ),
      ),
    );
  }

  Widget _buildTopUpCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyAppColors.dullRedColor.withOpacity(0.5),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Card(
          elevation: 2,
          color: MyAppColors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: const BorderSide(color: MyAppColors.greyColor),
          ),
          child: ListTile(
            leading: const Icon(Icons.credit_card, color: MyAppColors.blackColor),
            title: const Text(
              'Payment Method',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            subtitle: const Text(
              'Tap to select',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, color: MyAppColors.blackColor),
            onTap: () => _showPaymentMethod(context),
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyAppColors.whiteColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            '\$ 0',
            style: TextStyle(
              color: MyAppColors.greyColor,
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(
            color: MyAppColors.greyColor,
            thickness: 2,
          ),
          SizedBoxExtensions.withHeight(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildAmountButton(context, '800'),
              const SizedBox(width: 16),
              _buildAmountButton(context, '1000'),
              const SizedBox(width: 16),
              _buildAmountButton(context, '1200'),
            ],
          ),
          SizedBoxExtensions.withHeight(50),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              fixedSize: Size(220, 50),
              backgroundColor: MyAppColors.dullRedColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Text(
              'Top Up',
              style: TextStyle(color: MyAppColors.whiteColor),
            ),
          ),
        ],
      ),
    );
  }

  void _showPaymentMethod(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: MyAppColors.whiteColor,
      barrierColor: MyAppColors.blackColor.withOpacity(0.5),
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Text(
                    'Top Up via',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              ListTile(
                leading: const Icon(Icons.credit_card),
                title: const Text('Bank Card'),
                subtitle: const Text('\$ 50-18000'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.money),
                title: const Text('Other Wallets'),
                subtitle: const Text('PKR 50-18000'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAmountButton(BuildContext context, String amount) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: MyAppColors.whiteColor,
        side: const BorderSide(color: MyAppColors.lightGreyColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
      ),
      child: Text(
        amount,
        style: const TextStyle(
          color: MyAppColors.greyColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
