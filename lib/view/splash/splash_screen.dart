import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_project/firebase_options.dart';
import 'package:movie_app_project/view/register/register_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  await Firebase.initializeApp (
    options: DefaultFirebaseOptions.currentPlatform,
  );
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