import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wanna_exercise_app/pages/chat/%08chat_user_list.dart';
import 'package:wanna_exercise_app/pages/chat/chat_room_page.dart';
import 'package:wanna_exercise_app/data/repositories/chat_repository.dart';

class ChatPage extends StatelessWidget {
  final String myUserId;
  final ChatRepository _chatRepository = ChatRepository();

  ChatPage({required this.myUserId});

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
            icon: Icon(Icons.people),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UserListScreen(myUserId: myUserId),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance
                  .collection('chatRooms')
                  .where('users', arrayContains: myUserId)
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // 로딩 중이면 로딩 표시
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              // 데이터가 없으면 메시지
              return Center(child: Text('채팅방이 없습니다.'));
            }

            final chatRooms = snapshot.data!.docs;

            return ListView.builder(
              itemCount: chatRooms.length,
              itemBuilder: (context, index) {
                final chatRoom = chatRooms[index];
                final users = List<String>.from(chatRoom['users'] ?? []);

                // 상대방 UID 가져오기
                final otherUserId = users.firstWhere(
                  (id) => id != myUserId,
                  orElse: () => '알 수 없음',
                );

                return ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    size: 40,
                    color: Color(0xFF1414b8),
                  ),
                  title: Text(
                    '상대방 UID: $otherUserId',
                  ), // 여기서 나중에 상대방 닉네임을 가져오게 수정 가능
                  subtitle: Text('채팅방 ID: ${chatRoom['roomId']}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => ChatRoomPage(
                              roomId: chatRoom['roomId'],
                              myUserId: myUserId,
                            ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
