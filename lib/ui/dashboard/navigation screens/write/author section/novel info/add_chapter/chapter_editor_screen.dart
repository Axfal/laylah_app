// ignore_for_file: prefer_const_constructors

import 'package:laylah_app/ui/dashboard/navigation%20screens/write/provider/author_center_provider.dart';
import 'package:laylah_app/utils/constants/exports.dart';

class ChapterEditorScreen extends StatefulWidget {
  final int bookId;
  const ChapterEditorScreen({super.key, required this.bookId});

  @override
  State<ChapterEditorScreen> createState() => _ChapterEditorScreenState();
}

class _ChapterEditorScreenState extends State<ChapterEditorScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  int wordCount = 0;
  bool autoPublish = false;

  @override
  void initState() {
    super.initState();
    contentController.addListener(updateWordCount);
  }

  void updateWordCount() {
    final text = contentController.text.trim();
    setState(() {
      wordCount = text.isEmpty ? 0 : text.split(RegExp(r'\s+')).length;
    });
  }

  void showPublishBottomSheet(int bookId) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const Text(
                  'Publish',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  titleController.text.isEmpty ? "Alpha" : titleController.text,
                  style:
                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Text(
                  'Title',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Chapter Type',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('Normal Type', style: TextStyle(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Words Count',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('$wordCount',
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Auto-Publish',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Switch(
                      value: autoPublish,
                      activeColor: Colors.red.shade400,
                      onChanged: (value) {
                        setState(() {
                          autoPublish = value;
                        });
                        Navigator.pop(context);
                        showPublishBottomSheet(widget.bookId);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text('Cancel',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final provider =
                              Provider.of<AuthorCenterProvider>(context,
                                  listen: false);
                          final String chapterTitle = titleController.text;
                          final String chapterContent = contentController.text;
                          String status = "published";
                          await provider.addChapters(
                              context, bookId, chapterTitle, chapterContent, status);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyAppColors.dullRedColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          'Publish',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red.shade400,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () async {
            final chapterProvider =
                Provider.of<AuthorCenterProvider>(context, listen: false);
            final bookId = widget.bookId;
            final chapterTitle = titleController.text;
            final chapterDescription = contentController.text;
            String status = "draft";
            Navigator.pop(context);
            if (chapterTitle.isNotEmpty && chapterDescription.isNotEmpty) {
              await chapterProvider.addChapters(
                  context, bookId, chapterTitle, chapterDescription, status);
            }
          },
        ),
        title: const Text(
          'Save & Exit',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // Handle settings
            },
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.white),
            onPressed: () {
              showPublishBottomSheet(widget.bookId);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.grey.shade200,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: TextField(
                controller: titleController,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                decoration: const InputDecoration.collapsed(
                  hintText: 'Chapter Title',
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: contentController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      expands: true,
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Start writing...',
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: Text(
                      '$wordCount Words',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
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
