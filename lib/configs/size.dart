import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double bodyWidth;
  static double bodyHeight;
  static double defaultSize;
  static Orientation orientation;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// بتعطيه الارتفاع يلي بلصميم يلي شتغلتو اول شي وبيرجعلك ياه حسب جهازك
double getHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the  height that designer use
  return (inputHeight / 770) * screenHeight;
}

// بتعطيه العرض يلي بلصميم يلي شتغلتو اول شي وبيرجعلك ياه حسب جهازك
double getWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the  width that designer use
  return (inputWidth / 410) * screenWidth;
}
