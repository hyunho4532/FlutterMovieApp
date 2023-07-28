import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app_project/const/widget/bottom_navigation_bar.dart';
import 'package:movie_app_project/controller/navigation/bottom_navigation_bar_controller.dart';
import 'package:movie_app_project/view/favorite_screen.dart';
import 'package:movie_app_project/view/movie_screen.dart';
import 'package:movie_app_project/view/profile_screen.dart';
import 'package:movie_app_project/view/search_screen.dart';

class BottomNaviBar extends StatefulWidget {
  const BottomNaviBar({Key? key}) : super(key: key);

  @override
  State<BottomNaviBar> createState() => _BottomNaviBarState();
}

class _BottomNaviBarState extends State<BottomNaviBar> with SingleTickerProviderStateMixin {

  static List<Widget> tabPages = [
    const MovieScreen(),
    const SearchScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    Get.put(BottomNavigationBarController());

    return Scaffold (
      backgroundColor: context.theme.colorScheme.background,

      body: Obx(() => SafeArea (
        child: tabPages[BottomNavigationBarController.to.selectedIndex.value],
      )),

      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
