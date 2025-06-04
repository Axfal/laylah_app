// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/write/author%20section/contract/apply%20for%20contract/providers/document_provider.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/write/author%20section/contract/apply%20for%20contract/widget/no_of_years.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/write/author%20section/contract/apply%20for%20contract/widget/text_field.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/write/author%20section/contract/apply%20for%20contract/widget/contract_type.dart';
import 'package:laylah_app/utils/constants/app_colors.dart';
import 'package:laylah_app/utils/constants/exports.dart';
import 'package:laylah_app/utils/extensions/sized_box_extension.dart';
import '../../helpers/my_progress_bar.dart';
import '../../personal info/personal_info_form.dart';

class ApplyForContract extends StatefulWidget {
  final int bookId;
  const ApplyForContract({super.key, required this.bookId});

  @override
  State<ApplyForContract> createState() => _ApplyForContractState();
}

class _ApplyForContractState extends State<ApplyForContract> {
  final bookTitleController = TextEditingController();
  final expectedWordsController = TextEditingController();
  final avgWordsController = TextEditingController();
  final linkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bookTitleController.addListener(_onTextChanged);
    expectedWordsController.addListener(_onTextChanged);
    avgWordsController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {}); // Rebuilds the UI when text changes
  }

  @override
  void dispose() {
    bookTitleController.removeListener(_onTextChanged);
    expectedWordsController.removeListener(_onTextChanged);
    avgWordsController.removeListener(_onTextChanged);

    bookTitleController.dispose();
    expectedWordsController.dispose();
    avgWordsController.dispose();
    linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contractProvider = Provider.of<ContractProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildHeader('Book Info'),
                    SizedBoxExtensions.withHeight(10),
                    if (!contractProvider.contractExist)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Center(
                          child: MyProgressBar(
                            currentStep: 1,
                            totalSteps: 3,
                          ),
                        ),
                      ),
                    SizedBoxExtensions.withHeight(20),
                    CustomTextField(
                        label: 'Book Title',
                        hint: 'Title',
                        controller: bookTitleController),
                    SizedBoxExtensions.withHeight(20),
                    const ContractType(
                      contractIndex: 0,
                      label: 'Contract Type',
                      options: ['Alpha Contract', 'Superstar Contract'],
                    ),
                    SizedBoxExtensions.withHeight(20),
                    const ContractType(
                      contractIndex: 1,
                      label: 'Preferred binding',
                      options: ['Exclusive', 'Non-exclusive'],
                    ),
                    SizedBoxExtensions.withHeight(20),
                    const NumberOfYears(
                      label: 'Duration of Contract',
                      hint: 'Tap here',
                    ),
                    SizedBoxExtensions.withHeight(20),
                    CustomTextField(
                      label: 'Expected number of words',
                      hint: 'For eg: 25000',
                      keyboardType: TextInputType.number,
                      controller: expectedWordsController,
                    ),
                    SizedBoxExtensions.withHeight(20),
                    CustomTextField(
                      label: 'Average words in a chapter',
                      hint: 'For eg: 35000',
                      keyboardType: TextInputType.number,
                      controller: avgWordsController,
                    ),
                    SizedBoxExtensions.withHeight(20),
                    const ContractType(
                      contractIndex: 2,
                      label: 'Is the book already a completed work offline?',
                      options: ['Yes', 'No'],
                    ),
                    SizedBoxExtensions.withHeight(20),
                    const ContractType(
                      contractIndex: 3,
                      label: 'Is this book available on other sites?',
                      options: ['Yes', 'No'],
                    ),
                    SizedBoxExtensions.withHeight(20),
                    CustomTextField(
                      label: 'If yes provide the link',
                      hint: 'Enter the link (e.g., http://example.com)',
                      controller: linkController,
                    ),
                  ],
                ),
              ),

              /// Next Button
              _buildNextButton(context)
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      backgroundColor: MyAppColors.dullRedColor,
      centerTitle: true,
      title: Text(
        'Apply For Contract',
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: MyAppColors.whiteColor,
        ),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: MyAppColors.blackColor,
      ),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    final contractProvider = Provider.of<ContractProvider>(context);
    final isFormFilled = bookTitleController.text.isNotEmpty &&
        expectedWordsController.text.isNotEmpty &&
        avgWordsController.text.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Center(
        child: Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
            onPressed: contractProvider.contractExist
                ? (isFormFilled
                    ? () {
                        final bookTitle = bookTitleController.text;
                        final contractType = contractProvider.contractType;
                        final bindingType = contractProvider.preferredBinding;
                        final durationYear =
                            contractProvider.selectedYear.toString();
                        final expectedWords = expectedWordsController.text;
                        final avgWordsPerChapter = avgWordsController.text;
                        final completedOffline =
                            contractProvider.selectedValues[2];
                        final availableOnline =
                            contractProvider.selectedValues[3];
                        final onlineLink = linkController.text;
                        final bookId = widget.bookId.toString();
                        contractProvider.signContract(
                          context,
                          bookId,
                          bookTitle,
                          contractType,
                          bindingType,
                          durationYear,
                          expectedWords,
                          avgWordsPerChapter,
                          completedOffline,
                          availableOnline,
                          onlineLink: onlineLink,
                        );
                      }
                    : null)
                : () {
                    final bookTitle = bookTitleController.text;
                    final avgWords = avgWordsController.text;
                    final expectedWords = expectedWordsController.text;
                    final link = linkController.text;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PersonalInfoForm(
                          bookId: widget.bookId,
                          bookTitle: bookTitle,
                          avgWords: avgWords,
                          expectedWords: expectedWords,
                          link: link,
                        ),
                      ),
                    );
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: MyAppColors.dullRedColor,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 4,
              shadowColor:
                  MyAppColors.dullRedColor.withAlpha(77), // 30% opacity
            ),
            child: Text(
              contractProvider.contractExist ? 'Apply' : 'NEXT',
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
}
