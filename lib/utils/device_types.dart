import 'dart:developer';

import 'package:flutter/material.dart';

/* Available dimensions of desktops:
 - Width * Height
 - 1024 * 768 MINIMUM DIMENSIONs
 - 1920 * 1080 MAXIMUM DIMENSIONS
 - 1792 * 957
 - 1366 * 641 
 */

enum DeviceType { mobile, tablet, desktopSmall, deskTopMedium, desktopLarge }

class ResponsiveUi {
  static int getCount(
      {required BuildContext context, required bool isNotExpanded}) {
    double h = MediaQuery.of(context).size.height;
    if (h >= 900) {
      if (isNotExpanded) {
        return 7;
      } else {
        return 6;
      }
    } else if (h >= 700) {
      if (isNotExpanded) {
        return 6;
      } else {
        return 5;
      }
    } else {
      if (isNotExpanded) {
        return 5;
      } else {
        return 4;
      }
    }
  }

  static DeviceType getDeviceType(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w > 1500) {
      return DeviceType.desktopLarge;
    } else if (w > 1400 && w < 1500) {
      return DeviceType.deskTopMedium;
    } else if (w > 1300 && w < 1400) {
      return DeviceType.desktopSmall;
    } else if (w > 600 && w < 1300) {
      return DeviceType.tablet;
    } else {
      return DeviceType.mobile;
    }
  }

  double respValSignPadding(BuildContext context, double percent,
      {bool respNotRequired = false}) {
    DeviceType type = ResponsiveUi.getDeviceType(context);
    final w = MediaQuery.of(context).size.width;
    if (respNotRequired) {
      return w * percent;
    }

    if (type == DeviceType.desktopLarge) {
      log("Desktop Large:  ${w * percent}");
      return w * percent;
    } else if (type == DeviceType.deskTopMedium) {
      log("Desktop Medium:  ${(w * percent) / 2}");
      return (w * percent) / 1.5;
    } else if (type == DeviceType.desktopSmall) {
      log("Desktop Small:  ${(w * percent) / 3}");
      return (w * percent);
    } else if (type == DeviceType.tablet) {
      log("Desktop large:  ${w * percent}");
    } else {
      return w * percent;
    }
    return w * percent;
  }

 static  double respValSignImage(BuildContext context,
      {bool respNotRequired = false}) {
    DeviceType type = ResponsiveUi.getDeviceType(context);
    final w = MediaQuery.of(context).size.width;
    if (respNotRequired) {
      return w * 0.33;
    }

    if (type == DeviceType.desktopLarge) {
      log("Desktop Large:  ${w * 0.33}");
      return w * 0.33;
    } else if (type == DeviceType.deskTopMedium) {
      log("Desktop Medium:  ${(w * 0.35)}");
      return (w * 0.35);
    } else if (type == DeviceType.desktopSmall) {
      log("Desktop Small:  ${(w * 0.38)}");
      return (w * 0.38);
    } else if (type == DeviceType.tablet) {
      log("Desktop large:  ${w * 0.3}");
    } else {
      return w * 0.33;
    }
    return w * 0.33;
  }
}
