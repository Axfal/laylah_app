// ignore_for_file: prefer_const_constructors

import 'package:laylah_app/utils/constants/exports.dart';
import 'dart:convert';
import 'dart:io' as io show Directory, File;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:path/path.dart' as path;

class WritingSectionEditScreen extends StatefulWidget {
  const WritingSectionEditScreen({super.key});

  @override
  State<WritingSectionEditScreen> createState() =>
      _WritingSectionEditScreenState();
}

class _WritingSectionEditScreenState extends State<WritingSectionEditScreen> {
  final QuillController _controller = QuillController.basic();
  final FocusNode _editorFocusNode = FocusNode();
  final ScrollController _editorScrollController = ScrollController();

  bool _showTextFormattingOptions = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: MyAppColors.dullRedColor,
        centerTitle: true,
        title: Text(
          'Writing Section',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 22,
            letterSpacing: 1,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: QuillEditor(
                focusNode: _editorFocusNode,
                scrollController: _editorScrollController,
                controller: _controller,
                config: QuillEditorConfig(
                  placeholder: 'Start writing your chapter...',
                  padding: const EdgeInsets.all(16),
                  embedBuilders: FlutterQuillEmbeds.editorBuilders(),
                ),
              ),
            ),
            if (_showTextFormattingOptions)
              Container(
                color: MyAppColors.dullRedColor.withValues(alpha: 0.4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    QuillToolbarToggleStyleButton(
                      controller: _controller,
                      attribute: Attribute.bold,
                      options: QuillToolbarToggleStyleButtonOptions(
                        iconData: Icons.format_bold,
                      ),
                    ),
                    QuillToolbarToggleStyleButton(
                      controller: _controller,
                      attribute: Attribute.italic,
                      options: QuillToolbarToggleStyleButtonOptions(
                        iconData: Icons.format_italic,
                      ),
                    ),
                    QuillToolbarToggleStyleButton(
                      controller: _controller,
                      attribute: Attribute.underline,
                      options: QuillToolbarToggleStyleButtonOptions(
                        iconData: Icons.format_underline,
                      ),
                    ),
                  ],
                ),
              ),
            Divider(height: 1, color: MyAppColors.dullRedColor),
            Container(
              color: MyAppColors.dullRedColor,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.undo, color: Colors.white),
                    onPressed: () => _controller.undo(),
                  ),
                  IconButton(
                    icon: Icon(Icons.redo, color: Colors.white),
                    onPressed: () => _controller.redo(),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.text_format,
                      color: Colors.white,
                      size: 35,
                    ),
                    onPressed: () {
                      setState(() {
                        _showTextFormattingOptions =
                            !_showTextFormattingOptions;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _editorScrollController.dispose();
    _editorFocusNode.dispose();
    super.dispose();
  }
}
