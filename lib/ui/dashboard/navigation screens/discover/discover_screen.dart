// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables

import 'package:laylah_app/ui/dashboard/navigation%20screens/discover/widgets/search_book/search_book_screen.dart';
import 'package:laylah_app/utils/constants/exports.dart';

import 'widgets/category/provider/tag_provider.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  bool _showSearchOverlay = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;

      final slidesProvider =
          Provider.of<SlidesProvider>(context, listen: false);
      if (slidesProvider.slidesModel == null) {
        slidesProvider.getSlides();
      }
    });
  }

  void _toggleSearchOverlay() {
    setState(() {
      _showSearchOverlay = !_showSearchOverlay;
    });
  }

  Future<void> refreshScreen() async {
    final slidesProvider = Provider.of<SlidesProvider>(context, listen: false);
    final tagProvider = Provider.of<TagProvider>(context, listen: false);
    final categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);

    await slidesProvider.getSlides();

    if (!mounted) return;

    await tagProvider.getTags();

    if (!mounted) return;

    await categoriesProvider.getCategoryBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        onNotificationPressed: _toggleSearchOverlay,
      ),
      backgroundColor: MyAppColors.whiteColor,
      body: RefreshIndicator(
        color: MyAppColors.dullRedColor,
        onRefresh: refreshScreen,
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    CategoriesWidget(),
                    BannerWidget(),
                    BooksListWidget(),
                  ]),
                ),
              ],
            ),
            if (_showSearchOverlay)
              SearchOverlay(
                onClose: _toggleSearchOverlay,
              ),
          ],
        ),
      ),
    );
  }
}
