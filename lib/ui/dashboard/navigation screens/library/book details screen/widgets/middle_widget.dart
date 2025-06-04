// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:laylah_app/ui/dashboard/navigation%20screens/library/book%20details%20screen/provider/book_detail_provider.dart';
import 'bottom_card.dart';
import 'category_list.dart';
import 'package:laylah_app/utils/constants/exports.dart';

class MiddleWidget extends StatefulWidget {
  @override
  State<MiddleWidget> createState() => _MiddleWidgetState();
}

class _MiddleWidgetState extends State<MiddleWidget> {
  final List<Map<String, String>> books = [
    {
      'imageUrl': 'assets/images/boook1 (1).jpg',
      'title': 'Love Of Nature',
      'subtitle': 'Mafia',
    },
    {
      'imageUrl': 'assets/images/boook1 (1).jpg',
      'title': 'Computer Science',
      'subtitle': 'Reginal',
    },
    {
      'imageUrl': 'assets/images/boook1 (1).jpg',
      'title': 'Positive Thinking',
      'subtitle': 'CEO',
    },
    {
      'imageUrl': 'assets/images/boook1 (1).jpg',
      'title': 'Space Adventure',
      'subtitle': 'Sci-Fi',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookDetailProvider>(context);
    final book = (provider.bookDetail?.data != null && provider.bookDetail!.data!.isNotEmpty)
        ? provider.bookDetail!.data!.first
        : null;

    if (book == null) {
      // Optional: return a shimmer, empty widget, or Text('No data')
      return _MiddleWidgetShimmer();
    }

// Now safely use `book` below

    // if (book == null) {
    //   return _MiddleWidgetShimmer();
    // }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Categories list
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: SizedBox(
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CategoryList(label: books[index]['title']!),
                  );
                },
              ),
            ),
          ),

          /// Chapters and Update Info
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Total chapters
              Text(
                '${book.numberOfChapters} Chapters',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),

              /// Status
              Expanded(
                child: Text(
                  'updated ${book.updated}',
                  style: TextStyle(
                    fontSize: 16,
                    color: MyAppColors.greyColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              ),


              /// View updated Chapters
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: MyAppColors.greyColor,
                ),
              ),
            ],
          ),

          /// "You Might Like" Section
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Center(
              child: Text(
                'You Might Like',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          /// Book list dynamically managed by the admin
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: books.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: BottomCardWidget(
                    imageUrl: books[index]['imageUrl']!,
                    title: books[index]['title']!,
                    subtitle: books[index]['subtitle']!,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------
// SHIMMER VERSION
// ------------------------------

class _MiddleWidgetShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories shimmer
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: SizedBox(
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ShimmerWidget.rectangular(height: 30, width: 100),
                ),
              ),
            ),
          ),

          // Chapter and status shimmer
          Row(
            children: [
              ShimmerWidget.rectangular(height: 16, width: 100),
              const Spacer(),
              ShimmerWidget.rectangular(height: 16, width: 80),
              const SizedBox(width: 10),
              const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 16),

          // Title shimmer
          Center(
            child: ShimmerWidget.rectangular(height: 20, width: 140),
          ),
          const SizedBox(height: 10),

          // Horizontal book card shimmer
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: ShimmerWidget.rectangular(height: 180, width: 120),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------
// SHIMMER WIDGET UTILITY
// ------------------------------

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular({
    super.key,
    required this.width,
    required this.height,
  }) : shapeBorder = const RoundedRectangleBorder();

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: Colors.grey[400]!,
        shape: shapeBorder,
      ),
    ),
  );
}
