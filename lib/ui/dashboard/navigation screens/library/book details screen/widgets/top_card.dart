// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:laylah_app/ui/dashboard/navigation%20screens/library/book%20details%20screen/provider/book_detail_provider.dart';
import 'package:laylah_app/utils/constants/exports.dart';

import '../author profile/author_profile_screen.dart';

class TopCardWidget extends StatefulWidget {
  const TopCardWidget({super.key});

  @override
  State<TopCardWidget> createState() => _TopCardWidgetState();
}

class _TopCardWidgetState extends State<TopCardWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookDetailProvider>(context);
    final book = (provider.bookDetail?.data != null && provider.bookDetail!.data!.isNotEmpty)
        ? provider.bookDetail!.data!.first
        : null;

    if (book == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: SizedBox(
              height: 160,
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 130,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 20,
                              width: 150,
                              color: Colors.white,
                            ),
                            Container(
                              height: 14,
                              width: 100,
                              color: Colors.white,
                            ),
                            Container(
                              height: 12,
                              width: 180,
                              color: Colors.white,
                            ),
                            Container(
                              height: 12,
                              width: 200,
                              color: Colors.white,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 12,
                                  width: 40,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 8),
                                Container(
                                  height: 12,
                                  width: 40,
                                  color: Colors.white,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 15.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Column(
                children: List.generate(
                  3,
                  (index) => Container(
                    margin: EdgeInsets.only(bottom: 8),
                    height: 14,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: SizedBox(
            height: 160,
            child: Card(
              color: MyAppColors.whiteColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                children: [
                  if (book.bookCoverImage != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: SizedBox(
                        height: 130,
                        width: 100,
                        child: Image.network(
                          'https://laylahnovel.com/API/${book.bookCoverImage}',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: Colors.grey[300],
                            child: Icon(Icons.broken_image, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '${book.bookTitle}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AuthorProfileScreen()));
                          },
                          child: Text(
                            'Author: ${book.authorName}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: MyAppColors.greyColor,
                            ),
                          ),
                        ),
                        Text(
                          'language ${book.language} | Ratings ${book.contentRating}+',
                          style: TextStyle(
                            fontSize: 12,
                            color: MyAppColors.greyColor,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Words: ${book.words} | Ongoing:  ${book.ongoing}',
                              style: TextStyle(
                                fontSize: 12,
                                color: MyAppColors.greyColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${book.views} :',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(
                                  Icons.remove_red_eye_rounded,
                                  size: 20,
                                  color: MyAppColors.greyColor,
                                ),
                              ],
                            ),
                            SizedBox(width: 8),
                            Text(
                              '|',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 4),
                            Row(
                              children: [
                                Text(
                                  '${book.likes} :',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(Icons.thumb_up_alt_rounded,
                                    size: 20, color: MyAppColors.greyColor),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 15.0),
          child: Text(
            "${book.description}",
            style: TextStyle(
                wordSpacing: 6, fontWeight: FontWeight.w600, fontSize: 14),
            maxLines: 5,
          ),
        ),
      ],
    );
  }
}
