import 'package:flutter/material.dart';
import 'package:wanna_exercise_app/pages/chat/%08chat_user_list.dart';
// 정상적인 경로로 수정
import 'package:wanna_exercise_app/pages/chat/chat_room_page.dart'; // 정상적인 경로로 수정

class ChatPage extends StatelessWidget {
  final String myUserId;

  ChatPage({required this.myUserId}); // myUserId 인자를 생성자로 추가

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '채팅 목록',
            style: TextStyle(
              color: Color(0xFF1414b8),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.people), // 유저리스트 아이콘
            onPressed: () {
              // 유저 리스트 화면으로 이동, myUserId 전달
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => UserListScreen(myUserId: myUserId), // myUserId 전달
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(
                Icons.account_circle,
                size: 40,
                color: Color(0xFF1414b8),
              ),
              title: Text('축구차실분'),
              subtitle: Text('마지막에 한말....'),
              trailing: Text('2025.04.23'),
              onTap: () {
                // roomId를 생성하고, myUserId를 ChatRoomPage로 전달
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => ChatRoomPage(
                          roomId: 'roomId_here', // 여기서 roomId를 설정해야 합니다.
                          myUserId: myUserId, // myUserId를 전달
                        ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
