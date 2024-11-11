import 'dart:math';

import 'package:flutter/material.dart';

class ClanChurnTypography {
  static TextStyle font4600 = const TextStyle(
    fontSize: 4,
    fontWeight: FontWeight.w600,
  );
  static TextStyle font8600 = const TextStyle(
    fontSize: 8,
    fontWeight: FontWeight.w600,
  );
  static TextStyle font10600 = const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );
  static TextStyle font12500 = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
  static TextStyle font12600 = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
  static TextStyle font13500 = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );
  static TextStyle font13600 = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
  );
  static TextStyle font14400 = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static TextStyle font14500 = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static TextStyle font14600 = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
  static TextStyle font14900 = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w900,
  );
  static TextStyle font15600 = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );
  static TextStyle font15500 = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );
  static TextStyle font15400 = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );
  static TextStyle font15900 = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w900,
  );
  static TextStyle font16700 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
  static TextStyle font16500 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static TextStyle font16600 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  static TextStyle font18500 = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  static TextStyle font18600 = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
  static TextStyle font18900 = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w900,
  );
  static TextStyle font20600 = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  static TextStyle font22600 = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
  );
  static TextStyle font22700 = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );
  static TextStyle font24600 = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );
  static TextStyle font48400 = const TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w400,
  );
}

class ScaleSize {
  static double textScaleFactor(BuildContext context, {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}
