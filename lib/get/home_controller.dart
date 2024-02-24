
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
//
// class HomeController extends GetxController {
//   ThemeMode _themeMode = ThemeMode.light;
//
//   ThemeMode get themeMode => _themeMode;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _loadTheme();
//   }
//
//   Future<void> _loadTheme() async {
//     final box = GetStorage();
//     ThemeMode savedThemeMode = ThemeMode.values[box.read('theme') ?? 0];
//     _setTheme(savedThemeMode);
//   }
//
//   Future<void> _toggleTheme(ThemeMode themeMode) async {
//     final box = GetStorage();
//     await box.write('theme', themeMode.index);
//     _setTheme(themeMode);
//   }
//
//   void _setTheme(ThemeMode themeMode) {
//     _themeMode = themeMode;
//     update();
//   }
//
//   void toggleTheme(int value) {
//     _toggleTheme(value == 1 ? ThemeMode.light : ThemeMode.dark);
//   }
// }
