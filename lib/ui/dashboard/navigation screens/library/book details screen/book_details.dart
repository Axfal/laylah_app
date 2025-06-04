// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/library/book%20details%20screen/widgets/bottom_buttons.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/library/book%20details%20screen/widgets/middle_widget.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/library/book%20details%20screen/widgets/top_card.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/library/provider/library_provider.dart';
import 'package:laylah_app/utils/extensions/sized_box_extension.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/constants/app_colors.dart';
import 'provider/book_detail_provider.dart';

class BookDetailsScreen extends StatefulWidget {
  final int bookId;
  final String libraryStatus;
  const BookDetailsScreen({super.key, required this.bookId, this.libraryStatus = 'no'});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    final provider = Provider.of<BookDetailProvider>(context, listen: false);
    await provider.getBookDetails(context, widget.bookId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.whiteColor,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopCardWidget(),
            MiddleWidget(),
            BottomButtonsWidget(bookId: widget.bookId, libraryStatus: widget.libraryStatus)
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final provider = Provider.of<BookDetailProvider>(context);
    return AppBar(
      backgroundColor: MyAppColors.dullRedColor,
      title: Text(
        'Book Details',
        style: TextStyle(
            color: MyAppColors.whiteColor, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          provider.disposeData();
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: MyAppColors.whiteColor,
        ),
      ),
      actions: [
        Row(
          children: [
            /// Bookmark button
            Consumer<LibraryBooksProvider>(
              builder: (context, libraryProvider, child) {
                final isInLibrary = libraryProvider.inLibrary(widget.bookId);
                final isLoading = libraryProvider.isBookLoading(widget.bookId);

                return IconButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          if (isInLibrary) {
                            if(widget.libraryStatus == "yes"){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "This item cannot be removed from your library."),
                                  backgroundColor: Colors.red));
                            }else {
                              await libraryProvider.removeLibraryBook(
                                context, widget.bookId);
                            }
                          } else {
                            await libraryProvider.addBookToLibrary(
                                context, widget.bookId);
                          }
                        },
                  icon: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
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

            /// Search button
            IconButton(
              onPressed: () {
                // final provider = Provider.of<BookDetailProvider>(context, listen: false);
                // final book = provider.bookDetail?.data?.first;
                // if (book != null) {
                //   Share.share(
                //     'Check out this book: Available now on Laylah!',
                // subject: book.bookTitle ?? 'Book',
                // );
                // }
              },
              icon: const Icon(
                Icons.share_rounded,
                color: MyAppColors.whiteColor,
              ),
            ),

            SizedBoxExtensions.withWidth(10),
          ],
        ),
      ],
    );
  }
}
