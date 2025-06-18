// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/library/provider/library_provider.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/library/widgets/library_grid_view.dart';
import 'package:laylah_app/utils/constants/exports.dart';
import 'package:provider/provider.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    final libraryProvider = Provider.of<LibraryBooksProvider>(context, listen: false);
    if (libraryProvider.getLibraryModel == null) {
      await libraryProvider.getLibraryBooks();
    }
  }

  Future<void> refreshScreen() async {
    final libraryProvider = Provider.of<LibraryBooksProvider>(context, listen: false);
    await libraryProvider.getLibraryBooks();
  }

  @override
  Widget build(BuildContext context) {
    final libraryProvider = Provider.of<LibraryBooksProvider>(context);
    return Scaffold(
      backgroundColor: MyAppColors.whiteColor,
      appBar: _buildAppBar(),
      body: libraryProvider.getLibraryModel == null
          ? Center(child: CupertinoActivityIndicator())
          : RefreshIndicator(
        onRefresh: refreshScreen,
        color: MyAppColors.dullRedColor,
        child: CustomScrollView(
          slivers: [
            // Banner Section (Ad Placeholder)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    color: Colors.redAccent.withOpacity(0.1),
                    alignment: Alignment.center,
                    child: Text(
                      '📚 Discover New Reads!\n(Sponsored Banner)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: MyAppColors.dullRedColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Library Grid Section
            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: LibraryGrid(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: MyAppColors.dullRedColor,
      title: const Text(
        'Library',
        style: TextStyle(
          color: MyAppColors.whiteColor,
          fontWeight: FontWeight.w400,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            // TODO: Implement search
          },
          icon: const Icon(
            Icons.search_rounded,
            color: MyAppColors.whiteColor,
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
