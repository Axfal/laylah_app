// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/library/provider/library_provider.dart';
import 'package:laylah_app/utils/constants/app_colors.dart';
import 'package:provider/provider.dart';
import '../book details screen/book_details.dart';
import 'title.dart';

class LibraryGrid extends StatefulWidget {
  const LibraryGrid({super.key});

  @override
  State<LibraryGrid> createState() => _LibraryGridState();
}

class _LibraryGridState extends State<LibraryGrid> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Consumer<LibraryBooksProvider>(
        builder: (context, libraryProvider, child) {
          if (libraryProvider.loading) {
            return Center(child: CupertinoActivityIndicator());
          }
          if (libraryProvider.getLibraryModel == null ||
              libraryProvider.getLibraryModel!.books == null ||
              libraryProvider.getLibraryModel!.books!.isEmpty) {
            return Center(child: Text('No books in library.'));
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: libraryProvider.getLibraryModel!.books!.length,
            itemBuilder: (context, index) {
              final item = libraryProvider.getLibraryModel!.books![index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookDetailsScreen(
                        bookId: item.bookId!,libraryStatus: item.libraryStatus!,
                      ),
                    ),
                  );
                },
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Consumer<LibraryBooksProvider>(
                        builder: (context, provider, _) => _buildAlertDialog(
                            context,
                            provider,
                            item.bookId!,
                            item.libraryStatus!),
                      );
                    },
                  );
                },
                child: BookTile(
                  title: item.bookTitle ?? '',
                  imagePath: item.bookCoverImage ?? '',
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildAlertDialog(BuildContext context,
      LibraryBooksProvider libraryProvider, int bookId, String libraryStatus) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      titleTextStyle: const TextStyle(
        color: MyAppColors.blackColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      contentTextStyle: const TextStyle(
        color: MyAppColors.greyColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      title: const Text('Remove Book?'),
      content: const Text(
          'Are you sure you want to remove this book from your library?'),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: libraryProvider.loading
              ? null
              : () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
            backgroundColor: MyAppColors.lightGreyColor,
            minimumSize: const Size(100, 45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: MyAppColors.blackColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: libraryProvider.loading
              ? null
              : () async {
                  if (libraryStatus != "yes") {
                    await libraryProvider.removeLibraryBook(context, bookId);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "This item cannot be removed from your library."),
                        backgroundColor: Colors.red));
                  }
                  Navigator.of(context).pop();
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: MyAppColors.dullRedColor,
            minimumSize: const Size(100, 45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: libraryProvider.loading
              ? const CupertinoActivityIndicator(
                  color: Colors.white,
                )
              : const Text(
                  'Remove',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ],
    );
  }
}
