// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print
import 'package:laylah_app/ui/auth/login_screen.dart';
import 'package:laylah_app/utils/constants/exports.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.whiteColor,
      appBar: MyAppBar(
        title: "Profile",
        actions: [
          InkWell(
            onTap: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(builder: (context) => const GiftBoxScreen()),
              // );
            },
            child: Image.asset(
              'assets/icons/gift_box.png',
              width: 25,
              height: 25,
            ),
          ),
          SizedBoxExtensions.withWidth(20),
          IconButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                final authCenterProvider =
                    Provider.of<AuthorCenterProvider>(context, listen: false);
                authCenterProvider.clearChaptersForBook();
                await prefs.remove('user_id');
                print(
                    "user_id removed from SharedPreferences and chapter from author center map deleted");

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              icon: Icon(
                Icons.login,
                color: Colors.white,
              )),
          SizedBoxExtensions.withWidth(15),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(context),
            _buildFollowersSection(),
            const WalletSection(),
            const OptionList(),
            const MySocialLinks(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
      child: Stack(
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              gradient: const LinearGradient(
                colors: [MyAppColors.dullRedColor, MyAppColors.darkGreyColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/default_profile.png",
                      fit: BoxFit.cover,
                      width: 75,
                      height: 75,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Muhammad Anfal',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: MyAppColors.whiteColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'anfal.cs.31@gmail.com',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfileScreen()));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(8.0),
                child: const Icon(
                  Icons.edit,
                  color: MyAppColors.dullRedColor,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Followers section
  Widget _buildFollowersSection() {
    return const Padding(
      padding: EdgeInsets.symmetric(
          vertical: 10.0), // Added padding for better spacing
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FollowersCard(title: 'Followers', value: '0', icon: Icons.group),
          FollowersCard(
              title: 'Following', value: '63', icon: Icons.person_add),
        ],
      ),
    );
  }
}
