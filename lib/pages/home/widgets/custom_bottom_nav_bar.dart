import 'package:flutter/material.dart';
import 'package:wanna_exercise_app/pages/home/widgets/home_content_page.dart';
import 'package:wanna_exercise_app/pages/post/post_page.dart';
import 'package:wanna_exercise_app/pages/map/map_page.dart';
import 'package:wanna_exercise_app/pages/chat/chat_page.dart';
import 'package:wanna_exercise_app/pages/profile/profile_page.dart';
import 'package:wanna_exercise_app/themes/light_theme.dart';

class CustomBottomNavBar extends StatefulWidget {
  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeContentPage(),
    PostPage(),
    MapPage(),
    ChatPage(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: appTheme.primaryColor,
        unselectedItemColor: appTheme.colorScheme.tertiary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
          BottomNavigationBarItem(icon: Icon(Icons.post_add), label: "게시판"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "지도"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "채팅"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "프로필"),
        ],
      ),
    );
  }
}
