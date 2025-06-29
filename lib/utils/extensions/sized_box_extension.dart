import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
extension SizedBoxExtensions on SizedBox {
  /// Create a SizedBox with a specific width.
  static SizedBox withWidth(double width) {
    return SizedBox(width: width);
  }

  /// Create a SizedBox with a specific height.
  static SizedBox withHeight(double height) {
    return SizedBox(height: height);
  }

  /// Create a SizedBox with specific width and height.
  static SizedBox withSize(double width, double height) {
    return SizedBox(width: width, height: height);
  }
}


extension SizedBoxExtension on num {
  SizedBox get ph => SizedBox(height: toDouble());
  SizedBox get pw => SizedBox(width: toDouble());
}
