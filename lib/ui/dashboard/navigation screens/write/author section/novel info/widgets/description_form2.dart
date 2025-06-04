// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/discover/widgets/category/provider/tag_provider.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/write/author%20section/author_center/author_center_screen.dart';
import 'package:provider/provider.dart';
import 'package:laylah_app/utils/extensions/sized_box_extension.dart';
import 'package:laylah_app/utils/global%20helpers/section_title.dart';
import '../../../../../../../utils/constants/app_colors.dart';

import '../providers/novel_info_provider.dart';

class DescriptionForm2 extends StatelessWidget {
  final File image;
  final String bookTitle;
  final String language;
  final String targetAudience;
  final String contentRating;
  DescriptionForm2(
      {super.key,
      required this.image,
      required this.language,
      required this.bookTitle,
      required this.contentRating,
      required this.targetAudience});

  final TextEditingController _synopsisController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.whiteColor,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionWithDropdown(context, 'Novel Type',
                          'Select Novel Type', 'novelType'),
                      _buildSectionWithDropdown(
                          context, 'Genre', 'Select Genre', 'genre'),
                      _buildSectionWithDropdown(
                          context, 'Tags', 'Add Tags', 'tags'),
                      _buildDescriptionSection(context),
                      _buildWordCountDisplay(context),
                    ],
                  ),
                ),
              ),
            ),
            _buildNavigationButtons(context),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: MyAppColors.dullRedColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Novel Information',
        style: TextStyle(
          color: MyAppColors.whiteColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildSectionWithDropdown(
      BuildContext context, String title, String placeholder, String type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleHelper.buildSectionTitle(title),
        _buildDropdownField(context, placeholder, type),
        SizedBoxExtensions.withHeight(16),
      ],
    );
  }

  Widget _buildDropdownField(
      BuildContext context, String placeholder, String type) {
    return Consumer<NovelInfoProvider>(
      builder: (context, provider, child) {
        String selectedValue = '';
        List<String> options = [];

        // Assign appropriate values based on dropdown type
        if (type == 'novelType') {
          selectedValue = provider.selectedNovelType.isNotEmpty
              ? provider.selectedNovelType
              : placeholder;
          options = provider.novelTypes;
        } else if (type == 'genre') {
          selectedValue = provider.selectedGenre.isNotEmpty
              ? provider.selectedGenre
              : placeholder;
          options = provider.genres;
        } else if (type == 'tags') {
          final tagProvider = Provider.of<TagProvider>(context, listen: false);
          selectedValue = tagProvider.selectedTags.isNotEmpty
              ? tagProvider.selectedTags.join(', ')
              : placeholder;
          options = tagProvider.tags;
        }

        return GestureDetector(
          onTap: () {
            if (type == 'tags') {
              _showMultiSelectDialog(context, options, provider.toggleTag);
            } else {
              _showDropdownDialog(context, options, (value) {
                if (type == 'novelType') {
                  provider.updateNovelType(value);
                } else if (type == 'genre') {
                  provider.updateGenre(value);
                }
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: MyAppColors.lightGreyColor, width: 1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(selectedValue,
                      style: const TextStyle(color: MyAppColors.blackColor)),
                  const Icon(Icons.arrow_forward_ios,
                      size: 14, color: MyAppColors.blackColor),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showDropdownDialog(
      BuildContext context, List<String> options, Function(String) onSelected) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Select an Option'),
          children: options.map((option) {
            return SimpleDialogOption(
              onPressed: () {
                onSelected(option);
                Navigator.pop(context);
              },
              child: Text(option),
            );
          }).toList(),
        );
      },
    );
  }

  void _showMultiSelectDialog(
      BuildContext context, List<String> options, Function(String) onToggle) {
    showDialog(
      context: context,
      builder: (context) {
        return Consumer<NovelInfoProvider>(
          builder: (context, provider, child) {
            return AlertDialog(
              title: const Text('Select Tags'),
              content: SingleChildScrollView(
                child: Column(
                  children: options.map((option) {
                    bool isSelected = provider.selectedTags.contains(option);
                    return CheckboxListTile(
                      value: isSelected,
                      title: Text(option),
                      onChanged: (selected) {
                        onToggle(option);
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildDescriptionSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleHelper.buildSectionTitle('Description'),
        const Padding(
          padding: EdgeInsets.only(left: 9, bottom: 5),
          child: Text(
            'Please write a description for your story with 20\nto 300 words.',
            style: TextStyle(color: MyAppColors.greyColor),
          ),
        ),
        SizedBoxExtensions.withHeight(8),
        Container(
          height: 150,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: MyAppColors.lightGreyColor),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Consumer<NovelInfoProvider>(
            builder: (context, provider, child) {
              return TextField(
                controller: _synopsisController,
                maxLines: null,
                keyboardType: TextInputType.text,
                cursorColor: MyAppColors.darkGreyColor,
                onChanged: (text) {
                  provider.updateWordCount(text);
                },
                decoration: const InputDecoration.collapsed(
                  hintText: 'Write here...',
                  hintStyle:
                      TextStyle(color: MyAppColors.blackColor, fontSize: 14),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWordCountDisplay(BuildContext context) {
    return Consumer<NovelInfoProvider>(
      builder: (context, provider, child) {
        return Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, right: 5),
            child: Text(
              '${provider.wordCount} Words',
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavigationButtons(BuildContext context) {
    final addBookProvider = Provider.of<NovelInfoProvider>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: const BoxDecoration(
        color: MyAppColors.whiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildButton(
            context,
            'BACK',
            MyAppColors.whiteColor,
            MyAppColors.dullRedColor,
            () {
              Navigator.pop(context);
            },
          ),
          _buildButton(
            context,
            addBookProvider.isLoading ? '' : 'COMPLETE',
            MyAppColors.dullRedColor,
            MyAppColors.whiteColor,
            addBookProvider.isLoading
                ? null
                : () async {
                    try {
                      await addBookProvider.addBook(
                        bookTitle,
                        language,
                        targetAudience,
                        contentRating,
                        addBookProvider.selectedNovelType,
                        addBookProvider.selectedGenre,
                        _synopsisController.text, // description
                        true, // ongoing
                        "authorName",
                        "123", // words
                        "123", // views
                        "234", // likes
                        "12", // numOfChapter
                        image,
                      );
                      if (addBookProvider.addBookModel != null &&
                          addBookProvider.addBookModel!.data != null) {
                        if (kDebugMode) {
                          print("book added successfully");
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Book added successfully"),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AuthorCenterScreen(),
                          ),
                        );
                      }
                    } catch (e) {
                      if (kDebugMode) {
                        print("error while hitting the API $e");
                      }
                    }
                  },
            isLoading: addBookProvider.isLoading, // Pass the loading state
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
    BuildContext context,
    String label,
    Color bgColor,
    Color textColor,
    VoidCallback? onPressed, {
    bool isLoading = false,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        side: const BorderSide(color: MyAppColors.dullRedColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      ),
      child: isLoading
          ? SizedBox(
              width: 50.0,
              height: 20.0,
              child: CupertinoActivityIndicator(color: textColor),
            )
          : Text(
              label,
              style: TextStyle(color: textColor, fontSize: 14),
            ),
    );
  }
}
