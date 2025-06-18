import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laylah_app/utils/extensions/sized_box_extension.dart';
import '../../../utils/constants/app_colors.dart';

class BonusCoinsRow extends StatelessWidget {
  final int bonus;

  const BonusCoinsRow({super.key, required this.bonus});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white.withOpacity(0.1),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.deepOrange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Icon(
                Icons.monetization_on_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),
            SizedBoxExtensions.withWidth(10),
            Text(
              '$bonus Bonus',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
