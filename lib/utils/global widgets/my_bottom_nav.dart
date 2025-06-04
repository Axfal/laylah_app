import 'package:laylah_app/utils/constants/exports.dart';

class MyBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemTapped;

  const MyBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: MyAppColors.whiteColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: MyAppColors.dullRedColor,
          unselectedItemColor: MyAppColors.darkGreyColor.withValues(alpha: 0.7),
          selectedFontSize: 14,
          unselectedFontSize: 12,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined, size: 24),
              activeIcon: Icon(Icons.explore, size: 24),
              label: 'Discover',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined, size: 24),
              activeIcon: Icon(Icons.menu_book_rounded, size: 24),
              label: 'Library',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit_note_outlined, size: 24),
              activeIcon: Icon(Icons.edit_note_rounded, size: 24),
              label: 'Write',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, size: 24),
              activeIcon: Icon(Icons.person, size: 24),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
