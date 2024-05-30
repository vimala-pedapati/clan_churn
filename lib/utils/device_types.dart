import 'package:flutter/material.dart';

/* Available dimensions of desktops:
 - Width * Height
 - 1024 * 768 MINIMUM DIMENSIONs
 - 1920 * 1080 MAXIMUM DIMENSIONS
 */

enum DeviceType { mobile, tablet, desktopSmall, deskTopMedium, desktopLarge }

class GetDeviceType {
  static int getCount(
      {required BuildContext context, required bool isExpanded}) {
    double h = MediaQuery.of(context).size.height;
    if (h >= 900) {
      if (isExpanded) {
        return 7;
      } else {
        return 6;
      }
    } else if (h >= 700) {
      if (isExpanded) {
        return 6;
      } else {
        return 5;
      }
    } else {
      if (isExpanded) {
        return 5;
      } else {
        return 4;
      }
    }
  }

  static DeviceType getDeviceType({required BuildContext context}) {
    double h = MediaQuery.of(context).size.height;
    if (h >= 900) {
      return DeviceType.desktopLarge;
    } else if (h >= 700) {
      return DeviceType.deskTopMedium;
    } else {
      return DeviceType.desktopSmall;
    }
  }
}
