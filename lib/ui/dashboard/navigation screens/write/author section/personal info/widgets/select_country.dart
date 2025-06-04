// ignore_for_file: prefer_const_constructors

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../../../../utils/constants/app_colors.dart';
import '../providers/personal_info_provider.dart';

class SelectCountry extends StatelessWidget {
  final String label;
  final String hint;

  const SelectCountry({super.key, required this.label, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Consumer<PersonalInfoProvider>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Label
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: MyAppColors.blackColor,
              ),
            ),
            const SizedBox(height: 12),

            // Country Picker Field Styled
            GestureDetector(
              onTap: () => _showCountryPicker(context, provider),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                decoration: BoxDecoration(
                  color: MyAppColors.lightGreyColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: MyAppColors.lightGreyColor),
                ),
                child: Text(
                  provider.getSelectedCountryName ?? hint,
                  style: provider.getSelectedCountryName == null
                      ? GoogleFonts.poppins(
                    color: MyAppColors.greyColor.withOpacity(0.8),
                    fontSize: 14.5,
                  )
                      : GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: MyAppColors.blackColor,
                  ),
                ),
              ),
            ),

          ],
        );
      },
    );
  }

  void _showCountryPicker(BuildContext context, PersonalInfoProvider provider) {
    showCountryPicker(
      context: context,
      showPhoneCode: true, // shows +92, +1, etc.
      favorite: ['US', 'IN', 'PK'],
      countryListTheme: CountryListThemeData(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        backgroundColor: Colors.white,
        inputDecoration: InputDecoration(
          labelText: 'Search country',
          hintText: 'Type to search',
          hintStyle: GoogleFonts.poppins(fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: MyAppColors.lightGreyColor),
          ),
        ),
        textStyle: GoogleFonts.poppins(fontSize: 16),
      ),
      onSelect: (Country country) {
        provider.setSelectedCountryName(
          country.name,
          "+${country.phoneCode}",
        );
      },
    );
  }
}
