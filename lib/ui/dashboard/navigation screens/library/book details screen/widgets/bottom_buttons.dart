// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/library/provider/library_provider.dart';
import 'package:laylah_app/utils/constants/app_colors.dart';
import 'package:provider/provider.dart';

class BottomButtonsWidget extends StatefulWidget {
  final int bookId;
  final String libraryStatus;
  const BottomButtonsWidget(
      {super.key, required this.bookId, this.libraryStatus = "no"});

  @override
  State<BottomButtonsWidget> createState() => _BottomButtonsWidgetState();
}

class _BottomButtonsWidgetState extends State<BottomButtonsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          /// Bookmark Button
          Consumer<LibraryBooksProvider>(
            builder: (context, libraryProvider, child) {
              final isInLibrary = libraryProvider.inLibrary(widget.bookId);
              final isLoading = libraryProvider.isBookLoading(widget.bookId);

              return ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        if (isInLibrary) {
                          if (widget.libraryStatus == "yes") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "This item cannot be removed from your library."),
                                backgroundColor: Colors.red));
                          } else {
                            await libraryProvider.removeLibraryBook(
                                context, widget.bookId);
                          }
                        } else {
                          await libraryProvider.addBookToLibrary(
                              context, widget.bookId);
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyAppColors.dullRedColor,
                  side: const BorderSide(color: MyAppColors.dullRedColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  minimumSize: const Size(110, 50),
                ),
                child: isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CupertinoActivityIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Icon(
                        isInLibrary
                            ? Icons.bookmark_added_outlined
                            : Icons.bookmark_outline,
                        color: MyAppColors.whiteColor,
                      ),
              );
            },
          ),

          /// Read Button
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: MyAppColors.dullRedColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              minimumSize: const Size(200, 50),
            ),
            child: const Text(
              'Read',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
