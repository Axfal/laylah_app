// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/write/author%20section/contract/apply%20for%20contract/providers/document_provider.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/write/author%20section/contract/apply%20for%20contract/widget/contract_type.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/write/author%20section/helpers/my_progress_bar.dart';
import '../../../../../../../utils/constants/exports.dart';

class DocumentUploadScreen extends StatefulWidget {
  final int bookId;
  final String bookTitle;
  final String expectedWords;
  final String avgWords;
  final String link;
  final String name;
  final String penName;
  final String email;
  final String? plateformLink;
  final String state;
  final String city;
  final String address;
  final String postalAddress;
  final String phoneNumber;

  const DocumentUploadScreen(
      {super.key,
        required this.bookId,
      required this.bookTitle,
      required this.avgWords,
      required this.expectedWords,
      required this.link,
      required this.address,
      required this.email,
      required this.name,
      required this.city,
      required this.penName,
      required this.phoneNumber,
      required this.plateformLink,
      required this.postalAddress,
      required this.state});

  @override
  State<DocumentUploadScreen> createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(BuildContext context, String type) async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      Provider.of<DocumentUploadProvider>(context, listen: false)
          .setImage(type, File(picked.path));
    }
  }

  Widget _buildImageTile({
    required BuildContext context,
    required String title,
    required File? file,
    required String type,
    bool isRequired = false,
  }) {
    return GestureDetector(
      onTap: () => _pickImage(context, type),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 12,
                offset: Offset(0, 6))
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: 250,
              child: file != null
                  ? Image.file(file, fit: BoxFit.cover)
                  : Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.grey[300]!, Colors.grey[100]!],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.upload_file,
                                size: 50, color: MyAppColors.dullRedColor),
                            SizedBox(height: 10),
                            Text("Tap to Upload",
                                style:
                                    TextStyle(color: MyAppColors.dullRedColor)),
                          ],
                        ),
                      ),
                    ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(12),
                color: MyAppColors.dullRedColor.withValues(alpha: 0.9),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "$title${isRequired ? ' *' : ''}",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ),
                    Icon(Icons.edit_note_rounded, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAgreement(BuildContext context) {
    return Consumer<DocumentUploadProvider>(
      builder: (context, provider, _) => Row(
        children: [
          Checkbox(
            value: provider.agreeTerms,
            onChanged: (val) => provider.toggleAgreement(),
            activeColor: MyAppColors.dullRedColor,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => provider.toggleAgreement(),
              child: RichText(
                text: TextSpan(
                  text: "I agree to the ",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Terms & Conditions",
                      style: TextStyle(
                        color: MyAppColors.dullRedColor,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Consumer<DocumentUploadProvider>(
      builder: (context, provider, _) => AnimatedOpacity(
        duration: Duration(milliseconds: 300),
        opacity: provider.canSubmit ? 1 : 0.5,
        child: ElevatedButton(
          onPressed: provider.canSubmit
              ? () {
                  final contractProvider =
                      Provider.of<ContractProvider>(context, listen: false);
                  final personalProvider =
                      Provider.of<PersonalInfoProvider>(context, listen: false);
                  final docProvider =
                      Provider.of<DocumentUploadProvider>(context, listen: false);
                  final bookTitle = widget.bookTitle;
                  final expectedWords = widget.expectedWords;
                  final contractType = contractProvider.contractType;
                  final bindingType = contractProvider.preferredBinding;
                  final durationYear = contractProvider.selectedYear.toString();
                  final avgWordsPerChapter = widget.avgWords;
                  final completedOffline = contractProvider.selectedValues[2];
                  final availableOnline = contractProvider.selectedValues[3];
                  final name = widget.name;
                  final penName = widget.penName;
                  final email = widget.email;
                  final onlineLink = widget.link;
                  final address = widget.address;
                  final city = widget.city;
                  final phoneNumber = widget.phoneNumber;
                  final country = personalProvider.selectedCountryName ?? "";
                  final state = widget.state;
                  final postalCode = widget.postalAddress;
                  final plateformLink = widget.plateformLink;
                  final File? idFront = docProvider.idFront;
                  final File? idBack = docProvider.idBack;
                  final File? passport = docProvider.passport;
                  final File? drivingLicense = docProvider.license;
                  final above18 = personalProvider.isUnder18;
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
                    email: email,
                    above18: above18.toString(),
                    address: address,
                    city: city,
                    country: country,
                    drivingLicense: drivingLicense,
                    fullName: name,
                    idBack: idBack,
                    idFront: idFront,
                    passport: passport,
                    penName: penName,
                    phoneNumber: phoneNumber,
                    platformLink: plateformLink,
                    state: state,
                    zipCode: postalCode,
                  );
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: MyAppColors.dullRedColor,
            minimumSize: Size(double.infinity, 52),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          child:
              Text("Submit Documents", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DocumentUploadProvider>(context);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MyProgressBar(currentStep: 3, totalSteps: 3),
              SizedBox(height: 30),
              Text(
                  "To complete your application, please upload required documents.",
                  textAlign: TextAlign.center),
              SizedBox(height: 30),
              _buildImageTile(
                  context: context,
                  title: "ID Card - Front",
                  file: provider.idFront,
                  type: 'idFront',
                  isRequired: true),
              _buildImageTile(
                  context: context,
                  title: "ID Card - Back",
                  file: provider.idBack,
                  type: 'idBack',
                  isRequired: true),
              _buildImageTile(
                  context: context,
                  title: "Passport (Optional)",
                  file: provider.passport,
                  type: 'passport'),
              _buildImageTile(
                  context: context,
                  title: "Driving License (Optional)",
                  file: provider.license,
                  type: 'license'),
              SizedBox(height: 20),
              const ContractType(
                  contractIndex: 4,
                  label: 'Do you have Payoneer?',
                  options: ['Yeah', 'Nope']),
              SizedBox(height: 12),
              _buildAgreement(context),
              SizedBox(height: 20),
              _buildSubmitButton(context),
            ],
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
        'Upload Documents',
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
