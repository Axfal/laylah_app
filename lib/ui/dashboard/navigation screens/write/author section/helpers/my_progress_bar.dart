import 'package:flutter/material.dart';
import '../../../../../../../utils/constants/app_colors.dart';

class MyProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final Color activeColor;
  final Color inactiveColor;

  const MyProgressBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.activeColor = MyAppColors.dullRedColor,
    this.inactiveColor = MyAppColors.lightGreyColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        bool isActive = index + 1 <= currentStep;
        bool isCompleted = index + 1 < currentStep;
        return Expanded(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                /// Step Circle
                CircleAvatar(
                  radius: 14,
                  backgroundColor: isActive ? activeColor : inactiveColor,
                  child: isCompleted
                      ? const Icon(
                    Icons.check,
                    color: MyAppColors.whiteColor,
                    size: 14,
                  )
                      : Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: isActive
                          ? MyAppColors.whiteColor
                          : MyAppColors.blackColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
                /// Connector Line
                if (index < totalSteps - 1)
                  Expanded(
                    child: Container(
                      height: 2,
                      color: isActive
                          ? activeColor
                          : inactiveColor,
                    ),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
