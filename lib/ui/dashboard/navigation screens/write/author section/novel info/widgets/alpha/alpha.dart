// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:laylah_app/ui/dashboard/navigation%20screens/write/author%20section/drafts%20screen/drafts_screen.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/write/author%20section/novel%20info/widgets/alpha/bottom_screens/published/published_screen.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/write/author%20section/novel%20info/widgets/alpha/bottom_screens/trash_screen.dart';
import 'package:laylah_app/utils/constants/exports.dart';
import '../../add_chapter/chapter_editor_screen.dart';

class BookManagementScreen extends StatefulWidget {
  final int bookId;
  const BookManagementScreen({super.key, required this.bookId});

  @override
  BookManagementScreenState createState() => BookManagementScreenState();
}

class BookManagementScreenState extends State<BookManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: MyAppColors.dullRedColor,
        title: const Text(
          'Alpha',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 24,
            letterSpacing: 1,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black12, width: 0.5),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: MyAppColors.dullRedColor,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorWeight: 3,
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              tabs: [
                Tab(text: 'Draft'),
                Tab(text: 'Published'),
                Tab(text: 'Trash'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                DraftScreen(bookId: widget.bookId),
                PublishedScreen(bookId: widget.bookId),
                TrashScreen(bookId: widget.bookId),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _tabController.index == 0
          ? FloatingActionButton(
              backgroundColor: MyAppColors.dullRedColor,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChapterEditorScreen(
                              bookId: widget.bookId,
                            )));
              },
              shape: CircleBorder(),
              child: Icon(
                Icons.add,
                size: 24,
                color: Colors.white,
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
