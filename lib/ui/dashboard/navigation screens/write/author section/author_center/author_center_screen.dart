// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/write/author%20section/drafts%20screen/widgets/drafts_card.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/write/author%20section/novel%20info/widgets/alpha/alpha.dart';
import 'package:laylah_app/utils/constants/exports.dart';
import '../novel info/novel_information_screen.dart';
import '../splash_writing_screen.dart';
// import 'package:laylah_app/utils/constants/exports.dart';

class AuthorCenterScreen extends StatefulWidget {
  const AuthorCenterScreen({super.key});

  @override
  State<AuthorCenterScreen> createState() => _AuthorCenterScreenState();
}

class _AuthorCenterScreenState extends State<AuthorCenterScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    final provider = Provider.of<BookDetailProvider>(context, listen: false);
    await provider.getBookDetails(context, null);
  }

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookDetailProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Author Center",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24),
        ),
        backgroundColor: MyAppColors.dullRedColor,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NovelInformationScreen()));
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      body: bookProvider.bookDetail?.data == null
          ? Center(child: CupertinoActivityIndicator())
          : bookProvider.bookDetail!.data!.isEmpty
              ? SplashWritingScreen()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: bookProvider.bookDetail!.data!.length,
                      itemBuilder: (context, index) {
                        final book = bookProvider.bookDetail!.data![index];
                        return DraftCard(
                          likes: "${book.likes}",
                          views: '${book.views}',
                          title: book.bookTitle ?? "",
                          status:
                              book.ongoing != null ? "ongoing" : "completed",
                          imagePath: book.bookCoverImage ?? "",
                          applyContract: book.contractStatus ?? false,
                          bookId: book.bookId ?? 0,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookManagementScreen(
                                          bookId: book.bookId ?? 0,
                                        )));
                          },
                        );
                      }),
                ),
    );
  }

  Widget dynamicIcons(IconData icon) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black45,
              size: 20,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              '0 ?',
              style: TextStyle(fontSize: 14, color: Colors.black45),
            )
          ],
        ),
      );
}
