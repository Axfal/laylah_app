import 'package:flutter/material.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/write/widgets/add_book_button.dart';
import 'package:laylah_app/utils/constants/app_colors.dart';
import '../../../../utils/extensions/sized_box_extension.dart';

class WritingCenterScreen extends StatelessWidget {
  const WritingCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              MyAppColors.dullRedColor,
              MyAppColors.darkGreyColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// logo
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50.0),
                  child: SizedBox(
                    height: 100,
                      width: 100,
                      child: Image.asset('assets/logo/laylah_logo.png')),
                ),

                /// Welcome note with enhanced style
                Column(
                  children: [
                    const Text(
                      'Hello!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                        color: MyAppColors.whiteColor,
                        height: 1.4,
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Applying for the 1st time. ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: MyAppColors.whiteColor,
                            height: 1.4,
                          ),
                        ),
                        Text(
                          'You are Welcome',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: MyAppColors.whiteColor,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                    SizedBoxExtensions.withHeight(10),
                    const Text(
                      'BECOME SIGNED AUTHOR',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: MyAppColors.whiteColor,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
                SizedBoxExtensions.withHeight(30),

                /// AddBookButton
                const AddBookButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
