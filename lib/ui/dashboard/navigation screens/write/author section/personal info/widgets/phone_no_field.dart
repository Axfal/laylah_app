import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laylah_app/utils/constants/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:country_code_picker/country_code_picker.dart';
import '../providers/personal_info_provider.dart';

class PhoneNumberField extends StatefulWidget {
  const PhoneNumberField({super.key});

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<PersonalInfoProvider>(context, listen: false);
    _phoneController =
        TextEditingController(text: provider.getPhoneNumber ?? '');
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone Number',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: MyAppColors.blackColor,
          ),
        ),
        const SizedBox(height: 12),
        Consumer<PersonalInfoProvider>(
          builder: (context, personalInfoProvider, child) {
            return Container(
              decoration: BoxDecoration(
                color: MyAppColors.lightGreyColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: MyAppColors.lightGreyColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CountryCodePicker(
                    onChanged: (countryCode) {
                      personalInfoProvider
                          .setSelectedCountryCode(countryCode.dialCode ?? '+1');
                    },
                    initialSelection:
                        personalInfoProvider.selectedCountryCode ?? '+1',
                    favorite: const ['+1', '+44'],
                    showFlag: true,
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    alignLeft: false,
                    showDropDownButton: true,
                    searchDecoration: InputDecoration(
                      hintText: "Search country",
                      hintStyle: GoogleFonts.poppins(fontSize: 14),
                    ),
                    textStyle: GoogleFonts.poppins(
                      fontSize: 15,
                      color: MyAppColors.blackColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // const SizedBox(width: ),
                  Expanded(
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: MyAppColors.blackColor,
                      ),
                      onChanged: (value) {
                        personalInfoProvider.setPhoneNumber(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Phone number',
                        hintStyle: GoogleFonts.poppins(
                          color: MyAppColors.greyColor,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
