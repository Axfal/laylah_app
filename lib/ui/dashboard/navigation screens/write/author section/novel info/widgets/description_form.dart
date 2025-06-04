import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laylah_app/utils/extensions/sized_box_extension.dart';
import 'package:provider/provider.dart';
import '../../../../../../../utils/constants/app_colors.dart';
import '../../../../../../../utils/global helpers/section_title.dart';
import '../providers/novel_info_provider.dart';
import 'description_form2.dart';
import 'package:path_provider/path_provider.dart';

class DescriptionForm extends StatefulWidget {
  const DescriptionForm({super.key});

  @override
  State<DescriptionForm> createState() => _DescriptionFormState();
}

class _DescriptionFormState extends State<DescriptionForm> {
  final bookTitleController = TextEditingController();

  Future<File> getAssetFile(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/${assetPath.split('/').last}');
    await file.writeAsBytes(byteData.buffer.asUint8List());
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NovelInfoProvider>(
      builder: (context, provider, _) {
        return SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Upload Book Cover Section
                SectionTitleHelper.buildSectionTitle('Book Cover'),
                _buildBookCoverSection(provider),
                SizedBoxExtensions.withHeight(20),

                /// Book Title
                SectionTitleHelper.buildSectionTitle('Book Title'),
                _buildBookTitleField(provider),
                SizedBoxExtensions.withHeight(20),

                /// Language Section
                SectionTitleHelper.buildSectionTitle('Language'),
                _buildLanguageSection(provider),
                SizedBoxExtensions.withHeight(20),

                /// Target Audience
                SectionTitleHelper.buildSectionTitle('Target Audience'),
                _buildTargetAudience(provider),
                SizedBoxExtensions.withHeight(20),

                /// Content Rating
                SectionTitleHelper.buildSectionTitle('Content Rating'),
                _buildContentRating(provider),
                SizedBoxExtensions.withHeight(40),

                /// Next Button
                _buildNextButton(context, provider),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Book Cover Section
  Widget _buildBookCoverSection(NovelInfoProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            GestureDetector(
              onTap: () => provider.addImageFromGallery(),
              child: Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                  color: MyAppColors.lightGreyColor,
                  borderRadius: BorderRadius.circular(10.0),
                  image: provider.bookCovers.isNotEmpty
                      ? DecorationImage(
                          image: provider.bookCovers[0].startsWith('assets/')
                              ? AssetImage(provider.bookCovers[0])
                                  as ImageProvider
                              : FileImage(File(provider.bookCovers[0])),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: provider.bookCovers.isEmpty
                    ? const Icon(
                        Icons.add_a_photo,
                        color: MyAppColors.greyColor,
                        size: 30,
                      )
                    : null,
              ),
            ),
            if (provider.bookCovers.isNotEmpty)
              Positioned(
                top: -10,
                right: -15,
                child: GestureDetector(
                  onTap: () {
                    provider.removeImage(0);
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: MyAppColors.lightGreyColor,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(6),
                    child: const Icon(
                      Icons.close,
                      color: MyAppColors.blackColor,
                      size: 16,
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBoxExtensions.withHeight(16),
        const Padding(
          padding: EdgeInsets.only(left: 9),
          child: Text(
            'Upload cover image',
            style: TextStyle(color: MyAppColors.greyColor, fontSize: 14),
          ),
        ),
      ],
    );
  }

  /// Book Title Field
  Widget _buildBookTitleField(NovelInfoProvider provider) {
    return TextField(
      controller: bookTitleController,
      maxLines: 2,
      inputFormatters: [
        LengthLimitingTextInputFormatter(60),
      ],
      onChanged: (value) {
        if (value.length <= 60) {
          provider.restrictBookTitle(value);
        }
      },
      cursorColor: MyAppColors.darkGreyColor,
      decoration: InputDecoration(
        hintText: 'The title has a limit of 60 characters and 2 lines',
        hintStyle: const TextStyle(color: MyAppColors.greyColor, fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: MyAppColors.lightGreyColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: MyAppColors.lightGreyColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: MyAppColors.lightGreyColor),
        ),
      ),
    );
  }

  /// Language Selection Section
  Widget _buildLanguageSection(NovelInfoProvider provider) {
    return Padding(
      padding: const EdgeInsets.only(left: 250),
      child: Container(
        color: MyAppColors.whiteColor,
        child: DropdownButtonFormField<String>(
          value: provider.selectedLanguage,
          onChanged: (newValue) {
            if (newValue != null) {
              provider.updateSelectedLanguage(newValue);
            }
          },
          items: provider.languages.map((language) {
            return DropdownMenuItem<String>(
              value: language,
              child: Text(language),
            );
          }).toList(),
          decoration: const InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
            border: InputBorder.none,
          ),
          isDense: true,
          menuMaxHeight: 152,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          icon: const Icon(
            Icons.arrow_drop_down,
            color: MyAppColors.dullRedColor,
          ),
          dropdownColor: MyAppColors.whiteColor,
        ),
      ),
    );
  }

  /// Target Audience Section
  Widget _buildTargetAudience(NovelInfoProvider provider) {
    return Row(
      children: [
        _buildChoiceChip(
          'Male',
          provider.targetAudience,
          (value) => provider.updateTargetAudience(value),
        ),
        SizedBoxExtensions.withWidth(10),
        _buildChoiceChip(
          'Female',
          provider.targetAudience,
          (value) => provider.updateTargetAudience(value),
        ),
      ],
    );
  }

  /// Content Rating Section
  Widget _buildContentRating(NovelInfoProvider provider) {
    return Wrap(
      spacing: 10,
      children: ['4+', '12+', '16+', '18+']
          .map((rating) => _buildChoiceChip(
                rating,
                provider.contentRating,
                (value) => provider.updateContentRating(value),
              ))
          .toList(),
    );
  }

  /// Modern Next Button
  Widget _buildNextButton(BuildContext context, NovelInfoProvider provider) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 16, bottom: 16),
        child: ElevatedButton(
          onPressed: provider.isNextEnabled
              ? () async {
                  provider.setLoading(true);

                  if (provider.bookCovers.isEmpty) {
                    provider.setBookCoverToDefaultImage();
                  }

                  await Future.delayed(const Duration(seconds: 2));
                  provider.setLoading(false);

                  File imageFileToSend;

                  if (provider.bookCovers.isNotEmpty) {
                    if (!provider.bookCovers[0].startsWith('assets/')) {
                      imageFileToSend = File(provider.bookCovers[0]);
                    } else {
                      imageFileToSend =
                          await getAssetFile(provider.bookCovers[0]);
                    }
                  } else {
                    imageFileToSend = await getAssetFile(
                        'assets/logo/default_book_cover.png');
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DescriptionForm2(
                            image: imageFileToSend,
                            language: provider.selectedLanguage,
                            bookTitle: bookTitleController.text,
                            contentRating: provider.contentRating,
                            targetAudience: provider.targetAudience)),
                  );
                }
              : null,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(120, 48),
            backgroundColor: provider.isNextEnabled
                ? MyAppColors.dullRedColor
                : MyAppColors.lightGreyColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 4,
            shadowColor: Colors.black.withValues(alpha: 0.2),
          ),
          child: provider.isLoading
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: MyAppColors.whiteColor,
                    strokeWidth: 2.5,
                  ),
                )
              : Text(
                  'Next',
                  style: TextStyle(
                    color: provider.isNextEnabled
                        ? MyAppColors.whiteColor
                        : MyAppColors.darkGreyColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
        ),
      ),
    );
  }

  /// Choice Chip Widget
  Widget _buildChoiceChip(
      String label, String selectedValue, Function(String) onSelected) {
    final isSelected = selectedValue == label;
    return ChoiceChip(
      checkmarkColor: MyAppColors.whiteColor,
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? MyAppColors.whiteColor : MyAppColors.blackColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      selected: isSelected,
      onSelected: (bool selected) => onSelected(label),
      selectedColor: MyAppColors.dullRedColor,
      backgroundColor: MyAppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color:
              isSelected ? MyAppColors.whiteColor : MyAppColors.lightGreyColor,
        ),
      ),
    );
  }
}
