import 'package:flutter/cupertino.dart';
import 'package:laylah_app/utils/extensions/sized_box_extension.dart';

class BookTile extends StatelessWidget {
  final String title;
  final String imagePath;

  const BookTile({super.key, required this.title, required this.imagePath});



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            child: Image.network(
              "https://laylahnovel.com/API/$imagePath",
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBoxExtensions.withHeight(5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}