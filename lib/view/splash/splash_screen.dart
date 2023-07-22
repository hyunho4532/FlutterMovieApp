import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_project/const/widget/bottom_navi_bar.dart';
import 'package:movie_app_project/view/register/register_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const SplashScreen());
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.green,
      ),
      home: AnimatedSplashScreen (
        splash: Image.asset('asset/profile.png', width: 300, height: 300,),
        nextScreen: const RegisterScreen(),
        splashTransition: SplashTransition.sizeTransition,
        pageTransitionType: PageTransitionType.bottomToTop,
      ),
    );
  }
}