import 'package:flutter/material.dart';
import 'package:wanna_exercise_app/pages/chat/chat_room_page.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatRoomPage(roomId: 'roomId_here'),
                  ), // roomId 전달
                );
              },
            );
          },
        ),
      ),
    );
  }
}
