import 'package:flutter/material.dart';

class AppSizes {
  static const double spacing = 20.0;
  static const double spacingSmall = 10.0;
  static const double spacingMedium = 30.0;
  static const double spacingLarge = 40.0;

  static const double padding = 20.0;
  static const double paddingSmall = 10.0;
  static const double paddingMedium = 30.0;
  static const double paddingLarge = 40.0;

  static const double margin = 20.0;
  static const double marginSmall = 10.0;
  static const double marginMedium = 30.0;
  static const double marginLarge = 40.0;

  static const double borderRadius = 18.0;
  static const double borderRadiusSmall = 10.0;
  static const double borderRadiusMedium = 20.0;
  static const double borderRadiusLarge = 30.0;

  static const double fontSize = 16.0;
  static const double fontSizeSmall = 14.0;
  static const double fontSizeMedium = 18.0;
  static const double fontSizeLarge = 20.0;

  static const double iconSize = 24.0;
  static const double iconSizeSmall = 20.0;
  static const double iconSizeMedium = 28.0;
  static const double iconSizeLarge = 32.0;

  static const double circularAvatarSize = 20.0;
  static const double circularAvatarSizeSmall = 12.0;
  static const double circularAvatarSizeMedium = 40.0;
  static const double circularAvatarSizeLarge = 60.0;

  static const double shadowBlurRadius = 10.0;
  static const double shadowBlurRadiusSmall = 5.0;
  static const double shadowBlurRadiusMedium = 15.0;
  static const double shadowBlurRadiusLarge = 20.0;

  static const double buttonHeight = 50.0;
  static const double buttonHeightSmall = 40.0;
  static const double buttonHeightMedium = 60.0;
  static const double buttonHeightLarge = 70.0;

  static const double buttonWidth = 150.0;
  static const double buttonWidthSmall = 140.0;
  static const double buttonWidthMedium = 160.0;
  static const double buttonWidthLarge = 170.0;

  static const double textFieldHeight = 50.0;
  static const double textFieldHeightSmall = 40.0;
  static const double textFieldHeightMedium = 60.0;
  static const double textFieldHeightLarge = 70.0;

  static const double textFieldWidth = 200.0;
  static const double textFieldWidthSmall = 190.0;
  static const double textFieldWidthMedium = 210.0;
  static const double textFieldWidthLarge = 220.0;

  static const double appBarHeight = 50.0;
  static const double appBarHeightSmall = 40.0;
  static const double appBarHeightMedium = 60.0;
  static const double appBarHeightLarge = 70.0;

  static const double appBarWidth = 200.0;
  static const double appBarWidthSmall = 190.0;
  static const double appBarWidthMedium = 210.0;
  static const double appBarWidthLarge = 220.0;

  static const double snackBarHeight = 50.0;
  static const double snackBarHeightSmall = 40.0;
  static const double snackBarHeightMedium = 60.0;
  static const double snackBarHeightLarge = 70.0;

  static const double snackBarWidth = 200.0;
  static const double snackBarWidthSmall = 190.0;
  static const double snackBarWidthMedium = 210.0;
  static const double snackBarWidthLarge = 220.0;

  static const double dialogHeight = 50.0;
  static const double dialogHeightSmall = 40.0;
  static const double dialogHeightMedium = 60.0;
  static const double dialogHeightLarge = 70.0;

  static const double idealModileWidth = 360.0;
  static const double idealModileHeight = 640.0;

  static const double idealTabletWidth = 768.0;
  static const double idealTabletHeight = 1024.0;

  static const double idealDesktopWidth = 1440.0;
  static const double idealDesktopHeight = 900.0;

  static double getIdealWidth(double size, BuildContext context) {
    return size * MediaQuery.of(context).size.width / idealModileWidth;
  }

  static double getIdealHeight(double size, BuildContext context) {
    return size * MediaQuery.of(context).size.height / idealModileHeight;
  }

  static double getDeviceWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getDeviceHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
