// ignore_for_file: prefer_const_constructors, prefer_final_fields, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/discover/widgets/search_book/search_provider.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/library/book%20details%20screen/book_details.dart';
import 'package:laylah_app/utils/constants/app_colors.dart';
import 'package:provider/provider.dart';

class SearchOverlay extends StatefulWidget {
  final VoidCallback onClose;

  const SearchOverlay({super.key, required this.onClose});

  @override
  State<SearchOverlay> createState() => _SearchOverlayState();
}

class _SearchOverlayState extends State<SearchOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    _searchController.addListener(() {
      final query = _searchController.text.trim();
      if (query.isNotEmpty) {
        setState(() => _isSearching = true);
        Provider.of<SearchBarProvider>(context, listen: false)
            .searchQuery(query)
            .then((_) {
          if (mounted) setState(() => _isSearching = false);
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Widget buildSearchBar() {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              style: TextStyle(fontSize: 16.sp, color: Colors.black87),
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                suffixIcon: _searchController.text.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          Provider.of<SearchBarProvider>(context, listen: false)
                              .searchQuery('');
                        },
                        child: Icon(Icons.close, color: Colors.grey[600]),
                      )
                    : null,
                hintText: 'Search for books...',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildResults() {
    final searchModel = Provider.of<SearchBarProvider>(context).searchModel;

    if (_isSearching) {
      return Center(child: CupertinoActivityIndicator());
    }

    if (searchModel == null ||
        searchModel.data == null ||
        searchModel.data!.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off,
                  color: MyAppColors.dullRedColor, size: 80.sp),
              SizedBox(height: 24.h),
              Text(
                "No results found!",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: MyAppColors.dullRedColor,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "Try searching for something else, or check your spelling.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: searchModel.data!.length,
      padding: EdgeInsets.only(top: 8.h, left: 16.w, right: 16.w),
      itemBuilder: (context, index) {
        final book = searchModel.data![index];

        return GestureDetector(
          onTap: () async {
            final bookId = book.bookId ?? 0;
            print("book id => $bookId");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailsScreen(bookId: bookId),
                ),
              );

          },
          child: Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.bookmark,
                    size: 40.sp, color: MyAppColors.dullRedColor),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.bookTitle ?? 'Unnamed Book',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        "Tap to see details",
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey[600],
                        ),
                      )
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded,
                    size: 16.sp, color: Colors.grey),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.white.withValues(alpha: 0.96),
        child: SafeArea(
          child: Column(
            children: [
              buildSearchBar(),
              Expanded(child: buildResults()),
              SizedBox(height: 10.h),
              TextButton(
                onPressed: widget.onClose,
                child: Text(
                  "Close",
                  style: TextStyle(color: MyAppColors.dullRedColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
