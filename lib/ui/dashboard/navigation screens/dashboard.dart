// ignore_for_file: prefer_const_constructors

import 'package:laylah_app/ui/dashboard/navigation%20screens/write/author%20section/splash_writing_screen.dart';
import '../../../utils/global widgets/my_bottom_nav.dart';
import 'discover/discover_screen.dart';
import 'library/library_screen.dart';
import 'package:laylah_app/utils/constants/exports.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() async {
    _loadBookDetails();
    _userContractExists();
  }

  Future<void> _loadBookDetails() async {
    final bookDetailProvider =
        Provider.of<BookDetailProvider>(context, listen: false);
    await bookDetailProvider.getBookDetails(context, null);
  }

  Future<void> _userContractExists() async {
    final contractProvider =
        Provider.of<ContractProvider>(context, listen: false);
    await contractProvider.checkUserContract();
  }

  @override
  Widget build(BuildContext context) {
    final bookDetailProvider = Provider.of<BookDetailProvider>(context);
    final List<Widget> screens = [
      DiscoverScreen(),
      LibraryScreen(),
      bookDetailProvider.bookDetail!.data!.isEmpty
          ? SplashWritingScreen()
          : AuthorCenterScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      body: Consumer<BottomNavigationProvider>(
        builder: (context, navigationProvider, _) {
          return screens[navigationProvider.currentIndex];
        },
      ),
      bottomNavigationBar: Consumer<BottomNavigationProvider>(
        builder: (context, navigationProvider, _) {
          return MyBottomNavigation(
            currentIndex: navigationProvider.currentIndex,
            onItemTapped: (index) {
              navigationProvider.updateIndex(index);
            },
          );
        },
      ),
    );
  }
}
