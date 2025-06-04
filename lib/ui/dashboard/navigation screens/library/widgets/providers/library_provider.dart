// import 'package:flutter/material.dart';
//
// class LibraryProvider extends ChangeNotifier {
//   /// Initial list of items
//   final List<Map<String, String>> _items = [
//     {'title': 'New books for motivation', 'image': 'assets/images/boook1 (1).jpg'},
//     {'title': 'Look is everything', 'image': 'assets/images/book.jpg'},
//     {'title': 'Sometimes it happens', 'image': 'assets/images/boook1 (2).jpg'},
//     {'title': 'Good To Go', 'image': 'assets/images/boook1 (1).jpg'},
//     {'title': 'Ready To Learn', 'image': 'assets/images/book.jpg'},
//     {'title': 'Sometimes it happens', 'image': 'assets/images/boook1 (2).jpg'},
//     {'title': 'Look is everything', 'image': 'assets/images/book.jpg'},
//     {'title': 'Sometimes it happens', 'image': 'assets/images/book.jpg'},
//     {'title': 'Good To Go', 'image': 'assets/images/boook1 (2).jpg'},
//   ];
//
//   /// Getter for items
//   List<Map<String, String>> get items => List.unmodifiable(_items);
//
//   /// Method to remove an item
//   void removeItem(int index) {
//     _items.removeAt(index);
//     notifyListeners();
//   }
//
//   /// Method to add a new item
//   void addItem(Map<String, String> newItem) {
//     _items.add(newItem);
//     notifyListeners();
//   }
// }
