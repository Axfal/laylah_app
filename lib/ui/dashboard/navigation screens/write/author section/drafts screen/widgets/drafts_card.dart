// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:laylah_app/utils/constants/exports.dart';
import '../helper/status_icon.dart';

class DraftCard extends StatelessWidget {
  final String title;
  final String status;
  final String imagePath;
  final String likes;
  final String views;
  final VoidCallback onTap;
  final bool applyContract;
  final int bookId;

  const DraftCard(
      {super.key,
      required this.title,
      required this.views,
      required this.likes,
      required this.status,
      required this.imagePath,
      required this.onTap,
      required this.applyContract,
      required this.bookId});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      "https://laylahnovel.com/API/$imagePath",
                      width: screenWidth * 0.22,
                      height: screenWidth * 0.25,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: screenWidth * 0.22,
                        height: screenWidth * 0.25,
                        color: Colors.grey.shade300,
                        child: Icon(
                          Icons.broken_image,
                          size: screenWidth * 0.1,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.04),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: screenWidth * 0.033,
                          fontWeight: FontWeight.bold,
                          color: MyAppColors.blackColor,
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.01),
                      Text(
                        status,
                        style: TextStyle(
                          fontSize: screenWidth * 0.03,
                          color: MyAppColors.blackColor,
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.02),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              StatusIconWithText(
                                icon: Icons.favorite,
                                text: likes,
                              ),
                              StatusIconWithText(
                                icon: Icons.visibility,
                                text: views,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              StatusIconWithText(
                                icon: Icons.table_bar,
                                text: "0",
                              ),
                              StatusIconWithText(
                                icon: Icons.comment,
                                text: "0 ?",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_horiz),
                  onSelected: (value) {
                    switch (value) {
                      case 'edit':
                        break;
                      case 'delete':
                        break;
                      case 'save':
                        break;
                      case 'favorite':
                        break;
                      case 'share':
                        break;
                      case 'details':
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Text('Edit'),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                    const PopupMenuItem(
                      value: 'save',
                      child: Text('Save Offline'),
                    ),
                    const PopupMenuItem(
                      value: 'favorite',
                      child: Text('Mark as Favourite'),
                    ),
                    const PopupMenuItem(
                      value: 'share',
                      child: Text('Share'),
                    ),
                    const PopupMenuItem(
                      value: 'details',
                      child: Text('View Details'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: screenWidth * 0.04),
            Text(
              "Apply for contract and get a signing bonus of \$100 NOW!",
              style: TextStyle(
                fontSize: screenWidth * 0.03,
                color: MyAppColors.greyColor,
              ),
            ),
            SizedBox(height: screenWidth * 0.04),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: applyContract
                    ? null
                    : () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ApplyForContract(bookId: bookId)));
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyAppColors.dullRedColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: screenWidth * 0.03,
                    horizontal: screenWidth * 0.03,
                  ),
                ),
                child: Text(
                  "Apply for contract",
                  style: TextStyle(
                    color: MyAppColors.whiteColor,
                    fontSize: screenWidth * 0.03,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenWidth * 0.04),
            const Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "In Review",
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenWidth * 0.01),
                Text(
                  "Your book info is in review. It will be available soon.",
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
