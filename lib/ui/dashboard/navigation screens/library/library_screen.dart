// ignore_for_file: avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/library/provider/library_provider.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/library/widgets/library_grid_view.dart';
import 'package:laylah_app/utils/constants/exports.dart';
import '../../../../utils/extensions/sized_box_extension.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    final libraryProvider =
        Provider.of<LibraryBooksProvider>(context, listen: false);
    if (libraryProvider.getLibraryModel == null) {
      await libraryProvider.getLibraryBooks();
    }
  }

  Future<void> refreshScreen() async {
    final libraryProvider =
        Provider.of<LibraryBooksProvider>(context, listen: false);
    await libraryProvider.getLibraryBooks();
  }

  @override
  Widget build(BuildContext context) {
    final libraryProvider = Provider.of<LibraryBooksProvider>(context);
    return Scaffold(
      backgroundColor: MyAppColors.whiteColor,
      appBar: _buildAppBar(context),
      body: libraryProvider.getLibraryModel == null
          ? Center(child: CupertinoActivityIndicator())
          : RefreshIndicator(
              onRefresh: refreshScreen,
              color: MyAppColors.dullRedColor,
              child: Column(
                children: [
                  Expanded(
                    child: LibraryGrid(),
                  ),
                ],
              ),
            ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: MyAppColors.dullRedColor,
      title: const Text(
        'Library',
        style: TextStyle(
          color: MyAppColors.whiteColor,
          fontWeight: FontWeight.w400,
        ),
      ),
      // actions: [
      //   IconButton(
      //     onPressed: () {},
      //     icon: const Icon(
      //       Icons.search_rounded,
      //       color: MyAppColors.whiteColor,
      //     ),
      //   ),
      //   SizedBoxExtensions.withWidth(10),
      // ],
    );
  }
}
