// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:laylah_app/ui/dashboard/navigation%20screens/discover/widgets/category/provider/tag_provider.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/discover/widgets/search_book/search_provider.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/library/book%20details%20screen/provider/book_detail_provider.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/library/provider/library_provider.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/write/author%20section/contract/apply%20for%20contract/providers/document_provider.dart';
import 'package:laylah_app/ui/dashboard/navigation%20screens/write/provider/author_center_provider.dart';
import 'package:laylah_app/utils/constants/exports.dart';
import 'dart:convert';
import 'dart:io' as io show Directory, File;

import 'package:flutter/foundation.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_quill_example/quill_delta_sample.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:path/path.dart' as path;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => BottomNavigationProvider()),
            ChangeNotifierProvider(create: (_) => CategoriesProvider()),
            ChangeNotifierProvider(create: (_) => BookmarkProvider()),
            ChangeNotifierProvider(create: (_) => NovelInfoProvider()),
            ChangeNotifierProvider(create: (_) => ContractProvider()),
            ChangeNotifierProvider(create: (_) => PersonalInfoProvider()),
            ChangeNotifierProvider(create: (_) => ChapterProvider()),
            ChangeNotifierProvider(create: (_) => SlidesProvider()),
            ChangeNotifierProvider(create: (_) => DocumentUploadProvider()),
            ChangeNotifierProvider(create: (_) => TagProvider()),
            ChangeNotifierProvider(create: (_) => ProfileProvider()),
            ChangeNotifierProvider(create: (_) => SearchBarProvider()),
            ChangeNotifierProvider(create: (_) => LibraryBooksProvider()),
            ChangeNotifierProvider(create: (_) => AuthorCenterProvider()),
            ChangeNotifierProvider(create: (_) => BookDetailProvider()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            scaffoldMessengerKey: GlobalVariables.scaffoldMessengerKey,
            home: const SplashScreen(),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              FlutterQuillLocalizations.delegate,
            ],
          ),
        );
      },
    );
  }
}

class GlobalVariables {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
}
