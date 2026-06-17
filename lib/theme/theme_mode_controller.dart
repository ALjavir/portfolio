import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/style/color_style.dart';

class ThemeModeController extends GetxController {
  RxBool isDarkMode = false.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;

    Get.changeTheme(isDarkMode.value ? darkTheme : lightTheme);
  }

  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,

    scaffoldBackgroundColor: ColorStyle.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorStyle.white,
      foregroundColor: ColorStyle.black,
      elevation: 0,
    ),
  );

  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    scaffoldBackgroundColor: ColorStyle.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorStyle.black,
      foregroundColor: ColorStyle.white,
      elevation: 0,
    ),
  );
}
