// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/write/author%20section/novel%20info/model/chapter_details_model.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/write/author%20section/novel%20info/widgets/alpha/bottom_screens/published/chapter_detail_screen.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/write/provider/author_center_provider.dart';
import 'package:laylah_app/utils/constants/exports.dart';

class PublishedScreen extends StatefulWidget {
  final int bookId;
  const PublishedScreen({super.key, required this.bookId});

  @override
  State<PublishedScreen> createState() => _PublishedScreenState();
}

class _PublishedScreenState extends State<PublishedScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    final provider = Provider.of<AuthorCenterProvider>(context, listen: false);
    final bookId = widget.bookId;
    String status = "published";
    bool trash = false;
    if (provider.publishedChapter[widget.bookId] == null) {
      await provider.getChapters(bookId, status, trash);
    }
  }

  // void _showTrashDialog(BuildContext context, int chapterId) {
  //   showDialog(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  //       title: Text("Move to Trash"),
  //       content: Text("Are you sure you want to move this chapter to trash?"),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: Text("Cancel"),
  //         ),
  //         ElevatedButton(
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: MyAppColors.dullRedColor,
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(10),
  //             ),
  //           ),
  //           onPressed: () async {
  //             Navigator.pop(context);
  //             final provider =
  //                 Provider.of<AuthorCenterProvider>(context, listen: false);
  //             await provider.trashDraftChapter(context, chapterId);
  //             final bookId = widget.bookId;
  //             String status = "published";
  //             bool trash = false;
  //             await provider.getChapters(bookId, status, trash);
  //           },
  //           child: Text(
  //             "Move to Trash",
  //             style: TextStyle(color: Colors.white),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthorCenterProvider>(context);
    final chapters = provider.publishedChapter[widget.bookId]?.chapters;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: provider.isLoading
          ? Center(child: CupertinoActivityIndicator())
          : chapters == null
              ? Center(child: Text("No chapter available"))
              : RefreshIndicator(
                  backgroundColor: MyAppColors.dullRedColor,
                  color: Colors.white,
                  onRefresh: () async {
                    final bookId = widget.bookId;
                    String status = "published";
                    bool trash = false;
                    await provider.getChapters(bookId, status, trash);
                  },
                  child: ListView.separated(
                    padding: EdgeInsets.all(16),
                    itemCount: chapters.length,
                    separatorBuilder: (_, __) => SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final chapter = chapters[index];
                      final date = DateFormat.yMMMd()
                          .format(DateTime.parse(chapter.createdAt!));
                      final preview = chapter.chapterContent ?? '';
                      final previewText = preview.length > 120
                          ? "${preview.substring(0, 120)}..."
                          : preview;

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReadingModeScreen(
                                chapter: ChapterDetailModel(
                                  chapterId: chapter.chapterId,
                                  userId: chapter.userId,
                                  bookId: chapter.bookId,
                                  chapterTitle: chapter.chapterTitle,
                                  chapterContent: chapter.chapterContent,
                                  createdAt: chapter.createdAt,
                                  updatedAt: chapter.updatedAt,
                                ),
                              ),
                            ),
                          );
                        },
                        onLongPress: () {
                          // if (chapter.chapterId != null) {
                          //   _showTrashDialog(context, chapter.chapterId!);
                          // }
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                MyAppColors.dullRedColor.withOpacity(0.03),
                                Colors.white.withOpacity(0.6),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                                color: Colors.blueGrey.shade100, width: 0.8),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    MyAppColors.dullRedColor.withOpacity(0.08),
                                blurRadius: 12,
                                offset: Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${index + 1}. ${chapter.chapterTitle}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Icon(CupertinoIcons.chevron_forward,
                                      size: 18, color: Colors.grey.shade400),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                previewText,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                  height: 1.5,
                                ),
                              ),
                              SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(CupertinoIcons.calendar,
                                      size: 14, color: Colors.grey.shade500),
                                  SizedBox(width: 4),
                                  Text(
                                    date,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
