import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/extensions/sized_box_extension.dart';

class CheckInSection extends StatelessWidget {
  const CheckInSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Calculate icon size flexibly
    final iconSize = screenWidth * 0.08 < 40 ? 40.0 : screenWidth * 0.08;
    final circlePadding = iconSize * 0.3;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Check-in Streak',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              color: MyAppColors.blackColor,
              letterSpacing: 0.3,
            ),
          ),
          SizedBoxExtensions.withHeight(28),

          // Use SingleChildScrollView with Row for horizontal scroll if needed
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (index) {
                final isFinalDay = index == 6;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(circlePadding),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: isFinalDay
                                ? [Colors.purple.shade300, Colors.deepPurple]
                                : [Colors.orange.shade300, Colors.deepOrange],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: (isFinalDay
                                  ? Colors.deepPurple
                                  : Colors.deepOrange)
                                  .withOpacity(0.4),
                              blurRadius: 10,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Icon(
                          isFinalDay ? Icons.card_giftcard : Icons.monetization_on,
                          color: Colors.white,
                          size: iconSize,
                        ),
                      ),
                      SizedBoxExtensions.withHeight(8),
                      Text(
                        '+15',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: MyAppColors.blackColor,
                        ),
                      ),
                      Text(
                        'Day ${index + 1}',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: MyAppColors.blackColor.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),

          SizedBoxExtensions.withHeight(32),

          SizedBox(
            width: 180,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: MyAppColors.dullRedColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 6,
                shadowColor: MyAppColors.dullRedColor.withOpacity(0.4),
              ),
              child: Text(
                'Check-in',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: MyAppColors.whiteColor,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
