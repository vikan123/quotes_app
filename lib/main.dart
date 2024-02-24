import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quotes_app/Screen/detail_screen.dart';
import 'package:quotes_app/Screen/splash_screen.dart';
import 'package:quotes_app/helper/db_helper.dart';

import 'Screen/home_screen.dart';
import 'Screen/save_screen.dart';
import 'helper/splash_screen_helper.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DBHelper.dbHelper.initDB();

  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      getPages: [
        GetPage(
            name: "/",
            page: () => IsSplashScreenHelper.splashscreenHelper.isSplashScreens
                ? const HomeScreen()
                : const SplashScreen()
        ),

        GetPage(
          name: "/FavoritesPage",
          page: () => SaveScreen(),
        ),

        GetPage(
          name: "/DetailPage",
          page: () => DetailScreen(),
        ),
      ],
    );
  }
}