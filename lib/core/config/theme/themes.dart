import 'package:flutter/material.dart';
import 'package:group_exito/core/resources/foundations/font_foundation.dart';
import 'package:group_exito/core/resources/gen/colors.gen.dart';

class Themes {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: ColorToken.exitoWhite,
    appBarTheme: const AppBarTheme(backgroundColor: ColorToken.exitoYellow),
    textSelectionTheme: TextSelectionThemeData(cursorColor: ColorToken.spectrum600, selectionColor: ColorToken.spectrum600.withOpacity(0.4), selectionHandleColor: ColorToken.spectrum600),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorToken.darkSurface800,
      contentPadding: const EdgeInsets.all(16),
      suffixIconConstraints: const BoxConstraints(minHeight: 24, minWidth: 24),
      hintStyle: FontFoundation.paragraph.regular14Lato.copyWith(color: ColorToken.neutral500),
      errorStyle: const TextStyle(color: Colors.transparent, fontSize: 0, height: 0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: ColorToken.darkSurface400, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: ColorToken.error500, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: ColorToken.error500, width: 2),
      ),
    ),
    textTheme: TextTheme(
      bodyMedium: FontFoundation.paragraph.medium16Lato.copyWith(color: ColorToken.neutral500),
      labelMedium: FontFoundation.label.medium14Lato.copyWith(color: ColorToken.neutral200),
    ),
    splashFactory: NoSplash.splashFactory,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: ColorToken.darkSurface900,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
    textSelectionTheme: TextSelectionThemeData(cursorColor: ColorToken.spectrum600, selectionColor: ColorToken.spectrum600.withOpacity(0.4), selectionHandleColor: ColorToken.spectrum600),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorToken.darkSurface800,
      contentPadding: const EdgeInsets.all(16),

      suffixIconConstraints: const BoxConstraints(minHeight: 24, minWidth: 24),
      hintStyle: FontFoundation.paragraph.regular14Lato.copyWith(color: ColorToken.neutral500),
      errorStyle: const TextStyle(color: Colors.transparent, fontSize: 0, height: 0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: ColorToken.darkSurface400, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: ColorToken.error500, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: ColorToken.error500, width: 2),
      ),
    ),
    textTheme: TextTheme(
      bodyMedium: FontFoundation.paragraph.medium16Lato.copyWith(color: ColorToken.neutral500),
      labelMedium: FontFoundation.label.medium14Lato.copyWith(color: ColorToken.neutral200),
    ),
    splashFactory: NoSplash.splashFactory,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  );
}
