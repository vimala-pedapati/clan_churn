import 'package:flutter/material.dart';

/* Available dimensions of desktops:
 - Width * Height
 - 1024 * 768 MINIMUM DIMENSIONs
 - 1920 * 1080 MAXIMUM DIMENSIONS
 - 1792 * 957
 - 1366 * 641 
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
    double w = MediaQuery.of(context).size.width;
    // w - 1920, 1024 - 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900
    //  1000, 1200, 1400, 1600, 1800
    // 1000, 1300, 1600, 1900


  //  if(){

  //  }
  
    if (w >= 900) {
      return DeviceType.desktopLarge;
    } else if (w >= 700) {
      return DeviceType.deskTopMedium;
    } else {
      return DeviceType.desktopSmall;
    }
  }
}
