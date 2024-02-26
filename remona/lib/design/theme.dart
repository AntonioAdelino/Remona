import 'package:flutter/material.dart';
import 'package:remona/design/theme_colors.dart';

class RemonaTheme {
  static const TextStyle buttonTextStyle = TextStyle(
    fontWeight: FontWeight.w600,
  );

  static OutlinedBorder buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),
  );

  static final primary = ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light(
      primary: ThemeColors.greenPrimaryColor,
      secondary: ThemeColors.purpleSecondaryColor,
      tertiary: ThemeColors.greenTertiaryColor,
      background: ThemeColors.whiteColor,
      surface: ThemeColors.whiteColor,
      onPrimary: ThemeColors.whiteColor,
      onSecondary: ThemeColors.blackColor,
      onBackground: ThemeColors.lightGreyColor,
      onSurface: ThemeColors.whiteColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ThemeColors.purpleSecondaryColor,
        foregroundColor: ThemeColors.whiteColor,
        shape: buttonShape,
        textStyle: buttonTextStyle,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ThemeColors.greenPrimaryColor,
        shape: buttonShape,
        textStyle: buttonTextStyle,
      ),
    ),
  );
}
