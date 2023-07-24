import 'package:flutter/material.dart';
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

  int _selectedIdx = 0;

  final List _screens = [
    const MovieScreen(),
    const SearchScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Colors.white,
      body: Center (
        child: _screens[_selectedIdx],
      ),

      bottomNavigationBar: BottomNavigationBar (
        onTap: onItemTapped,

        currentIndex: _selectedIdx,

        items: const [
          BottomNavigationBarItem (
            icon: Icon (
              Icons.home,
            ),
            label: '홈'
          ),

          BottomNavigationBarItem (
              icon: Icon (
                Icons.search,
              ),
              label: '검색'
          ),

          BottomNavigationBarItem (
            icon: Icon (
              Icons.favorite
            ),
            label: '좋아요'
          ),

          BottomNavigationBarItem (
              icon: Icon (
                Icons.account_circle,
              ),
              label: '프로필'
          ),
        ],
      )
    );
  }

  void onItemTapped(int idx) {
    setState(() {
      _selectedIdx = idx;
    });
  }
}
