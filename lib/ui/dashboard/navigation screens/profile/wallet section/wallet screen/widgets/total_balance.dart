import 'package:flutter/material.dart';

import '../../../../../../../utils/extensions/sized_box_extension.dart';


class TotalBalanceWidget extends StatelessWidget {
  const TotalBalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.monetization_on_outlined,
            color: Colors.orange,
            size: 26
        ),
        SizedBoxExtensions.withWidth(8),
        const Text(
          'Coins 84',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
