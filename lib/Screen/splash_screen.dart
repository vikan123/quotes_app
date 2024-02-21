import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:quotes_app/Screen/home_screen.dart';
import '../helper/splash_screen_helper.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    IsSplashScreenHelper.splashscreenHelper.doneFirst();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SizedBox(
        height: 800,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 200),
              SizedBox(
                height: 200,
                child: Hero(
                  tag: 'E',
                  child: AnimatedSplashScreen(
                    animationDuration: const Duration(
                      seconds: 1,
                    ),
                    // backgroundColor: Colors.black87,
                    splash: Transform.scale(
                      scale: 2,
                      child: Image.network(
                        "https://tse1.mm.bing.net/th?id=OIP.1S--vGrVH_hCBpzTyL2C_wHaF8&pid=Api&P=0&h=180",
                      ),
                    ),
                    curve: Curves.bounceInOut,
                    nextScreen:
                    IsSplashScreenHelper.splashscreenHelper.checkFirstTime
                        ? const HomeScreen()
                        : const SplashScreen(),
                    duration: 4000,
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: Hero(
                  tag: 'f',
                  child: Text(
                    "Welcome To Quotes App",
                    style: GoogleFonts.adventPro(
                      textStyle: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


