import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class AppThemes {
  /// The AppThemes class is implemented to contain the themes which used inside the app
  /// particularly for this app is going to be a Dark Theme and light theme

  /// thanks to ColorsInspo.com the colors where chosen for both Dark and Light themes

  static Color lightBackgroundColor = const Color.fromRGBO(226, 243, 245, 1);
  static Color lightButtonColor = const Color.fromRGBO(34, 209, 238, 1);
  static Color lightAccentColor = const Color.fromRGBO(61, 90, 241, 1);
  static Color lightElementsColor = const Color.fromRGBO(14, 21, 58, 1);
  static Color lightTileColor = Colors.grey.shade300;


  static Color darkBackgroundColor = const Color.fromRGBO(52, 34, 46, 1);
  static Color darkButtonColor = const Color.fromRGBO(249, 191, 143, 1);
  static Color darkAccentColor = const Color.fromRGBO(226, 67, 75, 1);
  static Color darkElementsColor = const Color.fromRGBO(254, 233, 215, 1);
  static Color darkTileColor = const Color.fromRGBO(86 , 86, 86, 0.8) ;


  const AppThemes._();

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    buttonColor: lightButtonColor,
    accentColor: lightAccentColor,
    backgroundColor: lightBackgroundColor,
    cardColor: lightTileColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    buttonColor: darkButtonColor,
    accentColor: darkAccentColor,
    cardColor: darkTileColor,
    backgroundColor: darkBackgroundColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static setStatusBarAndNavigationBar(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
        systemNavigationBarIconBrightness:
            themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: themeMode == ThemeMode.light
            ? lightBackgroundColor
            : darkBackgroundColor,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
  }





}
