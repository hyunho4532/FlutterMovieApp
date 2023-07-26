import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app_project/firebase_options.dart';
import 'package:movie_app_project/view/login/login_screen.dart';
import 'package:movie_app_project/view/register/register_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp (
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SplashScreen());
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp (
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.green,
      ),

      getPages: [
        GetPage(name: '/register', page: () => const RegisterScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
      ],

      home: AnimatedSplashScreen (
        splash: Image.asset('asset/profile.png', width: 300, height: 300,),
        nextScreen: auth.currentUser!.email!.isEmpty ? const RegisterScreen() : const RegisterScreen(),
        splashTransition: SplashTransition.sizeTransition,
        pageTransitionType: PageTransitionType.bottomToTop,
      ),
    );
  }
}