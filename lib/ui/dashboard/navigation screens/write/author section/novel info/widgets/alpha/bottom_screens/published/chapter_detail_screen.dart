// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_declarations

import 'package:laylah_app/ui/dashboard/navigation%20screens/write/author%20section/novel%20info/widgets/alpha/bottom_screens/published/comment_screen.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/write/provider/author_center_provider.dart';
import 'package:laylah_app/utils/constants/exports.dart';

import '../../../../model/chapter_details_model.dart';

class ReadingModeScreen extends StatefulWidget {
  final ChapterDetailModel chapter;
  const ReadingModeScreen({super.key, required this.chapter});

  @override
  ReadingModeScreenState createState() => ReadingModeScreenState();
}

class ReadingModeScreenState extends State<ReadingModeScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  double progress = 0.0;
  int wordLimit = 5000;

  bool _isDarkMode = false;
  Color? _customBackgroundColor;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.chapter.chapterTitle ?? '';
    _contentController.text = widget.chapter.chapterContent ?? '';
    _updateProgress();
  }

  Color get _backgroundColor => _isDarkMode
      ? Colors.black
      : (_customBackgroundColor ?? const Color(0xFFFDF8DC));
  Color get _textColor => _isDarkMode ? Colors.white : Colors.black;
  Color get _hintColor => _isDarkMode ? Colors.white54 : Colors.black45;
  Color get _appBarColor =>
      _isDarkMode ? Colors.grey[900]! : MyAppColors.dullRedColor;
  Color get _bottomBarColor =>
      _isDarkMode ? Colors.grey[900]! : const Color(0xFFD66B6B);
  Color get _iconColor => Colors.white;

  final List<Color> _availableColors = [
    Colors.white,
    Color(0xFFE0F7FA),
    Color(0xFFD0F0C0),
    Color(0xFFFFF9C4),
    Color(0xFFF3E5F5),
    Color(0xFFFFCDD2),
    Color(0xFFFFF0F0),
    Color(0xFFE0F2F1),
    Color(0xFFB2EBF2),
    Color(0xFFB3E5FC),
    Color(0xFFFFF8E1),
    Color(0xFFF1F8E9),
    Color(0xFFECEFF1),
    Color(0xFFCFD8DC),
    Color(0xFFFBE9E7),
    Color(0xFFFFFDE7),
  ];

  void _updateProgress() {
    int wordCount = _contentController.text
        .trim()
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .length;
    setState(() {
      progress = (wordCount / wordLimit).clamp(0.0, 1.0);
    });
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: _isDarkMode ? Colors.grey[850] : Colors.white,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Choose a color', style: TextStyle(color: _textColor)),
          content: SizedBox(
            width: double.maxFinite,
            child: GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: _availableColors.map((color) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _isDarkMode = false;
                      _customBackgroundColor = color;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _contentController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _appBarColor,
        title: Text("Reading Mode",
            style: TextStyle(color: _iconColor, fontSize: 18)),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: _iconColor),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.update, color: _iconColor),
            onPressed: () async {
              final provider = Provider.of<AuthorCenterProvider>(
                  context,
                  listen: false);
              final chapterTitle = _titleController.text;
              final chapterContent = _contentController.text;
              int chapterId = widget.chapter.chapterId ?? 1;
              final String status = "published";
              try {
                await provider.updateChapter(
                    chapterId, chapterTitle, chapterContent, status);
              } catch (e) {
                print("error: $e");
              }
            },
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _titleController,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: _textColor,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Title",
                        hintStyle: TextStyle(color: _hintColor),
                      ),
                    ),
                    TextField(
                      controller: _contentController,
                      maxLines: null,
                      onChanged: (text) => _updateProgress(),
                      style: TextStyle(color: _textColor),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Start typing...",
                        hintStyle: TextStyle(color: _hintColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: _bottomBarColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: progress,
                          color: Colors.white,
                          backgroundColor: Colors.white24,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text("${(progress * 100).toStringAsFixed(0)}%",
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.grid_view, color: _iconColor),
                      ),
                      IconButton(
                        icon:
                        Icon(Icons.color_lens_outlined, color: _iconColor),
                        onPressed: _showColorPicker,
                      ),
                      IconButton(
                        icon: Icon(Icons.nightlight_round, color: _iconColor),
                        onPressed: () {
                          setState(() {
                            _isDarkMode = !_isDarkMode;
                          });
                        },
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CommentScreen()));
                          },
                          icon: Icon(Icons.chat_bubble_outline,
                              color: _iconColor))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
