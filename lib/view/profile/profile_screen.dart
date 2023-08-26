import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_app_project/controller/image/image_controller.dart';
import 'package:movie_app_project/view/board_screen.dart';
import 'package:movie_app_project/view/movie_screen.dart';
import 'package:movie_app_project/view/profile/profile_content_screen.dart';
import 'package:movie_app_project/view/favorite_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late LocalizationDelegate delegate;

  // 다국어 관련 설정
  void localSettings() async {
    delegate = await LocalizationDelegate.create (
      fallbackLocale: 'en_US',
      supportedLocales: ['en_US', 'ko_KR'],
    );
  }

  // 다크 모드 적용하기
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

  final PageController _pageController = PageController(initialPage: 0);

  String? data = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController profileNicknameController =
      TextEditingController();

  final ImageController controller = ImageController();

  String profileImageUrl = '';

  String? url;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    localSettings();

    loadDataFromSharedPreferences();

    getDataFromFirebase();
  }

  void loadDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      data = prefs.getString('data') ?? '';
    });
  }

  void getDataFromFirebase() {
    DatabaseReference starCountRef = FirebaseDatabase.instance
        .reference()
        .child(_auth.currentUser!.uid.toString())
        .child('nickname');

    starCountRef.onValue.listen((event) {
      String newData = event.snapshot.value.toString() ?? '';
      setState(() {
        data = newData;
        saveDataToSharedPreferences(newData);
      });
    });
  }

  void saveDataToSharedPreferences(String newData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('data', newData);
  }

  Future<String> getProfileNickNameData() async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Call Profile NickName';
  }

  Future<String> getProfileImageData() async {
    await Future.delayed(const Duration(seconds: 2));
    return 'Call Profile Image';
  }

  @override
  Widget build(BuildContext context) {

    Color _selectedItemColor = Colors.grey;
    Color _unselectedItemCoolor = Colors.grey;

    DatabaseReference ref =
        FirebaseDatabase.instance.ref(_auth.currentUser!.uid.toString());

    return ValueListenableBuilder<ThemeMode> (
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp (
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData.dark(),
          themeMode: currentMode,
          home: Scaffold (
            body: PageView.builder (
              physics: const BouncingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return MovieScreen(themeNotifier: themeNotifier);
                } else if (index == 1) {
                  return FavoriteScreen(themeNotifier: themeNotifier);
                } else if (index == 2) {
                  return BoardScreen(themeNotifier: themeNotifier,);
                } else {
                  return ProfileContentScreen(themeNotifier: themeNotifier);
                }
              },
            ),

            bottomNavigationBar: BottomNavigationBar (
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });

                _pageController.animateToPage (
                  index,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                );
              },

              selectedItemColor: _selectedItemColor,
              unselectedItemColor: _unselectedItemCoolor,

              items: const [

                BottomNavigationBarItem (
                  icon: Icon(Icons.home),
                  label: '홈',
                ),

                BottomNavigationBarItem (
                  icon: Icon(Icons.favorite),
                  label: '좋아요',
                ),

                BottomNavigationBarItem (
                  icon: Icon(Icons.chat_bubble),
                  label: '게시판',
                ),

                BottomNavigationBarItem (
                  icon: Icon(Icons.account_circle),
                  label: '프로필',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _onImageTap(Reference mountainsRef) async {
    var imageUrl = await mountainsRef.getDownloadURL();

    setState(() {
      url = imageUrl;
    });

    controller.getImage(ImageSource.gallery, _auth);
  }
}
