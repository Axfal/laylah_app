// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/write/author%20section/contract/apply%20for%20contract/documents_screen.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/write/author%20section/personal%20info/widgets/phone_no_field.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/write/author%20section/personal%20info/widgets/select_country.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/write/author%20section/personal%20info/widgets/age_selector.dart';
import 'package:laylah_app/utils/constants/exports.dart';
import '../../../../../../utils/constants/app_colors.dart';
import '../contract/apply for contract/widget/text_field.dart';
import '../helpers/my_progress_bar.dart';

class PersonalInfoForm extends StatefulWidget {
  final bookId;
  final String bookTitle;
  final String expectedWords;
  final String avgWords;
  final String link;
  const PersonalInfoForm(
      {super.key,
        required this.bookId,
      required this.bookTitle,
      required this.avgWords,
      required this.expectedWords,
      required this.link});

  @override
  State<PersonalInfoForm> createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  final nameController = TextEditingController();
  final penController = TextEditingController();
  final emailController = TextEditingController();
  final websiteController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  final postalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.whiteColor,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 15, bottom: 15),
                    child: Center(
                        child: MyProgressBar(currentStep: 2, totalSteps: 3)),
                  ),
                  SizedBox(height: 30),
                  CustomTextField(
                    label: 'Name',
                    hint: 'Fill in your full name',
                    controller: nameController,
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                      label: 'Pen name',
                      hint: 'Pen name',
                      controller: penController),
                  SizedBox(height: 20),
                  CustomTextField(
                    label: 'E-mail address',
                    hint: 'Enter email',
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    label: 'Website or platform',
                    hint: 'Website/ platform name',
                    showInfoIcon: true,
                    controller: websiteController,
                  ),
                  SizedBox(height: 20),
                  SelectCountry(
                    label: 'Select Country',
                    hint: 'Tap to select',
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                      label: 'State',
                      hint: 'Enter state',
                      controller: stateController),
                  SizedBox(height: 20),
                  CustomTextField(
                    label: 'City',
                    hint: 'Enter city name',
                    controller: cityController,
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                      label: 'Address',
                      hint: 'Enter your address',
                      controller: addressController),
                  SizedBox(height: 20),
                  CustomTextField(
                      label: 'Postal Address',
                      hint: 'Zip code',
                      keyboardType: TextInputType.number,
                      controller: postalController),
                  SizedBox(height: 20),
                  AgeSelector(),
                  SizedBox(height: 20),
                  PhoneNumberField(),
                ],
              ),
              const SizedBox(height: 10),
              _buildNextButton(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Next Button
  Widget _buildNextButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Center(
        child: Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
            onPressed: () {
              final bookTitle = widget.bookTitle;
              final avgWords = widget.avgWords;
              final expectedWords = widget.expectedWords;
              final link = widget.link;
              final personalProvider = Provider.of<PersonalInfoProvider>(context, listen: false);
              final phoneNumber = personalProvider.phoneNumber;
              final state =
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DocumentUploadScreen(
                      bookId: widget.bookId,
                        bookTitle: bookTitle,
                        avgWords: avgWords,
                        expectedWords: expectedWords,
                        link: link,
                    email: emailController.text,
                        state: stateController.text,
                         phoneNumber: phoneNumber ?? "",
                        penName: penController.text,
                        city: cityController.text,
                         address: addressController.text,
                        name: nameController.text,
                        plateformLink: websiteController.text,
                        postalAddress: postalController.text)),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: MyAppColors.dullRedColor,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 4,
              shadowColor: MyAppColors.dullRedColor.withValues(alpha: 0.3),
            ),
            child: Text(
              'NEXT',
              style: GoogleFonts.poppins(
                color: MyAppColors.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        'Personal Info',
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: MyAppColors.whiteColor,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      backgroundColor: MyAppColors.dullRedColor,
    );
  }
}
