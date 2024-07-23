import 'dart:developer';

import 'package:flutter/material.dart';

/* Available dimensions of desktops:
 - Width * Height
 - 1024 * 768 MINIMUM DIMENSIONs
 - 1920 * 1080 MAXIMUM DIMENSIONS
 - 1792 * 957
 - 1366 * 641 
 */

enum DeviceType {
  mobile,
  tablet,
  desktopSmall,
  deskTopMedium,
  desktopLarge,
  desktopLarge1
}

class ResponsiveUi {
  static DeviceType getDeviceType(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w > 1650) {
      return DeviceType.desktopLarge1;
    } else if (w > 1500) {
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
}

class SignInRespUi {
  double respValSignPadding(BuildContext context, double percent,
      {bool respNotRequired = false}) {
    DeviceType type = ResponsiveUi.getDeviceType(context);
    final w = MediaQuery.of(context).size.width;
    if (respNotRequired) {
      return w * percent;
    }

    if (type == DeviceType.desktopLarge) {
      // log("Desktop Large:  ${w * percent}");
      return w * percent;
    } else if (type == DeviceType.deskTopMedium) {
      // log("Desktop Medium:  ${(w * percent) / 2}");
      return (w * percent);
    } else if (type == DeviceType.desktopSmall) {
      // log("Desktop Small:  ${(w * percent) / 3}");
      return (w * percent);
    } else if (type == DeviceType.tablet) {
      // log("Desktop large:  ${w * percent}");
      return (w * percent);
    } else {
      return w * percent;
    }
  }

  static double respValSignImage(BuildContext context,
      {bool respNotRequired = false}) {
    DeviceType type = ResponsiveUi.getDeviceType(context);
    final w = MediaQuery.of(context).size.width;
    if (respNotRequired) {
      return w * 0.33;
    }

    if (type == DeviceType.desktopLarge) {
      // log("Desktop Large:  ${w * 0.33}");
      return w * 0.35;
    } else if (type == DeviceType.deskTopMedium) {
      // log("Desktop Medium:  ${(w * 0.35)}");
      return (w * 0.35);
    } else if (type == DeviceType.desktopSmall) {
      // log("Desktop Small:  ${(w * 0.38)}");
      return (w * 0.38);
    } else if (type == DeviceType.tablet) {
      // log("Desktop large:  ${w * 0.3}");
      return w * 0.3;
    } else {
      return w * 0.3;
    }
  }

  static double respValSignImageLogo(BuildContext context,
      {bool respNotRequired = false}) {
    DeviceType type = ResponsiveUi.getDeviceType(context);
    final w = MediaQuery.of(context).size.width;
    if (respNotRequired) {
      return w * 0.1;
    }
    if (type == DeviceType.desktopLarge) {
      return w * 0.07;
    } else if (type == DeviceType.deskTopMedium) {
      return (w * 0.08);
    } else if (type == DeviceType.desktopSmall) {
      return (w * 0.09);
    } else if (type == DeviceType.tablet) {
      return w * 0.1;
    } else {
      return w * 0.1;
    }
  }

  static double respSignFont(BuildContext context, double fontSize) {
    DeviceType type = ResponsiveUi.getDeviceType(context);
    if (type == DeviceType.desktopLarge) {
      return fontSize;
    } else if (type == DeviceType.deskTopMedium) {
      return fontSize + 1;
    } else if (type == DeviceType.desktopSmall) {
      return fontSize + 2;
    } else if (type == DeviceType.tablet) {
      return fontSize + 3;
    } else {
      return fontSize + 3;
    }
  }
}

class HomePageRespUi {
  static int getCount(
      {required BuildContext context,
      required bool isNotExpanded,
      bool respNotRequired = false}) {
    DeviceType type = ResponsiveUi.getDeviceType(context);
    // final w = MediaQuery.of(context).size.width;
    if (respNotRequired) {
      return 5;
    }
    // log("Desktop Medium:  ${(w * percent) / 2}");
    if (type == DeviceType.desktopLarge1) {
      // log("Desktop Large:  ${w * percent}");
      return 6;
    } else if (type == DeviceType.desktopLarge) {
      // log("Desktop Large:  ${w * percent}");
      return 5;
    } else if (type == DeviceType.deskTopMedium) {
      return 5;
    } else if (type == DeviceType.desktopSmall) {
      // log("Desktop Small:  ${(w * percent) / 3}");
      return 5;
    } else if (type == DeviceType.tablet) {
      // log("Desktop large:  ${w * percent}");
      return 4;
    } else {
      return 4;
    }
  }

  static int getCount1(
      {required BuildContext context,
      required bool isNotExpanded,
      bool respNotRequired = false}) {
    DeviceType type = ResponsiveUi.getDeviceType(context);
    // final w = MediaQuery.of(context).size.width;
    if (respNotRequired) {
      return 5;
    }
    if (type == DeviceType.desktopLarge1) {
      // log("Desktop Large:  ${w * percent}");
      return 6;
    } else if (type == DeviceType.desktopLarge) {
      // log("Desktop Large:  ${w * percent}");
      return 5;
    } else if (type == DeviceType.deskTopMedium) {
      return 5;
    } else if (type == DeviceType.desktopSmall) {
      // log("Desktop Small:  ${(w * percent) / 3}");
      return 5;
    } else if (type == DeviceType.tablet) {
      // log("Desktop large:  ${w * percent}");
      return 4;
    } else {
      return 4;
    }
  }
}
