import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app_project/controller/navigation/bottom_navigation_bar_controller.dart';

class MyBottomNavigationBar extends GetView<BottomNavigationBarController> {
  const MyBottomNavigationBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomNavigationBar (
      currentIndex: controller.selectedIndex.value,
      onTap: controller.changeIndex,
      selectedItemColor: context.theme.colorScheme.onBackground,
      unselectedItemColor: context.theme.colorScheme.onSurfaceVariant,
      unselectedLabelStyle: const TextStyle (
        fontSize: 10,
      ),

      selectedLabelStyle: const TextStyle (
        fontSize: 10,
      ),
      type: BottomNavigationBarType.shifting,
      backgroundColor: context.theme.colorScheme.background,

      items: [
        BottomNavigationBarItem (
          icon: controller.selectedIndex.value == 0 ? const Icon (Icons.home): const Icon(Icons.home_outlined),
          label: '홈',
        ),

        BottomNavigationBarItem (
          icon: controller.selectedIndex.value == 1 ? const Icon (Icons.saved_search_outlined) : const Icon(Icons.search),
          label: '검색',
        ),

        BottomNavigationBarItem (
          icon: controller.selectedIndex.value == 2 ? const Icon(Icons.favorite) : const Icon(Icons.favorite_outline),
          label: '좋아요',
        ),

        BottomNavigationBarItem (
          icon: controller.selectedIndex.value == 3 ? const Icon(Icons.person) : const Icon(Icons.person_outlined),
          label: '프로필',
        )
      ],
    ));
  }
}