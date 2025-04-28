import 'package:flutter/material.dart';
import 'package:wanna_exercise_app/pages/board/board_page.dart';
import 'package:wanna_exercise_app/pages/home/widgets/home_content_page.dart';
import 'package:wanna_exercise_app/pages/map/map_page.dart';
import 'package:wanna_exercise_app/pages/chat/chat_page.dart';
import 'package:wanna_exercise_app/pages/profile/profile_page.dart';
import 'package:wanna_exercise_app/themes/light_theme.dart';
import 'package:firebase_auth/firebase_auth.dart'; // FirebaseAuth 임포트

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  // Firebase에서 myUserId를 가져오는 함수
  String? get myUserId {
    final user = FirebaseAuth.instance.currentUser;
    return user?.uid; // 로그인된 유저의 UID 반환
  }

  // myUserId를 가져와서 ChatPage에 전달하도록 수정
  final List<Widget> _pages = [
    HomeContentPage(),
    BoardPage(),
    MapPage(),
    ChatPage(myUserId: FirebaseAuth.instance.currentUser?.uid ?? ''),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // 선택된 페이지 표시
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
