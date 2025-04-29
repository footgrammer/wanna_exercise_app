import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wanna_exercise_app/pages/chat/chat_user_list.dart';
import 'package:wanna_exercise_app/pages/chat/chat_room_page.dart';
import 'package:wanna_exercise_app/data/repositories/chat_repository.dart';
import 'package:wanna_exercise_app/data/repositories/profile_repository.dart';

class ChatPage extends StatelessWidget {
  final String myUserId;
  final ChatRepository _chatRepository = ChatRepository();
  final ProfileRepository _profileRepository = ProfileRepository();

  ChatPage({required this.myUserId});

  // Firestore에서 상대방 닉네임 조회
  Future<String> _getOtherUserNickname(String otherUserId) async {
    final profile = await _profileRepository.getProfile(otherUserId);
    return profile?.nickname ?? '알 수 없음';
  }

  // Firestore에서 마지막 메시지 가져오기
  Future<Map<String, dynamic>> _getLastMessage(String roomId) async {
    final messagesSnapshot =
        await FirebaseFirestore.instance
            .collection('chatRooms')
            .doc(roomId)
            .collection('messages')
            .orderBy('datetime', descending: true)
            .limit(1)
            .get();

    if (messagesSnapshot.docs.isNotEmpty) {
      final lastMessage = messagesSnapshot.docs.first.data();
      return {
        'content': lastMessage['content'] ?? '',
        'datetime': lastMessage['datetime'] ?? Timestamp(0, 0),
      };
    } else {
      return {'content': '', 'datetime': Timestamp(0, 0)};
    }
  }

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
          // Firestore 실시간 채팅방 스트림
          stream:
              FirebaseFirestore.instance
                  .collection('chatRooms')
                  .where('users', arrayContains: myUserId)
                  .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('채팅방이 없습니다.'));
            }

            final chatRoomDocs = snapshot.data!.docs;

            return FutureBuilder<List<Map<String, dynamic>>>(
              // 각 채팅방의 마지막 메시지, 닉네임 정리 및 정렬
              future: _buildSortedChatRooms(chatRoomDocs),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final chatRooms = snapshot.data!;

                return ListView.builder(
                  itemCount: chatRooms.length,
                  itemBuilder: (context, index) {
                    final room = chatRooms[index];
                    return ListTile(
                      leading: Icon(
                        Icons.account_circle,
                        size: 40,
                        color: Color(0xFF1414b8),
                      ),
                      title: Text(room['nickname']),
                      subtitle: Text(
                        room['lastMessage'].isNotEmpty
                            ? room['lastMessage']
                            : '메시지가 없습니다.',
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => ChatRoomPage(
                                  roomId: room['roomId'],
                                  myUserId: myUserId,
                                ),
                          ),
                        );
                      },
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

  // 채팅방 정렬용 리스트 생성 (닉네임, 마지막 메시지 포함)
  Future<List<Map<String, dynamic>>> _buildSortedChatRooms(
    List<QueryDocumentSnapshot> docs,
  ) async {
    final List<Map<String, dynamic>> rooms = [];

    for (final doc in docs) {
      final roomId = doc['roomId'];
      final users = List<String>.from(doc['users'] ?? []);
      final otherUserId = users.firstWhere(
        (id) => id != myUserId,
        orElse: () => '알 수 없음',
      );

      final nickname = await _getOtherUserNickname(otherUserId);
      final lastMessageData = await _getLastMessage(roomId);

      rooms.add({
        'roomId': roomId,
        'nickname': nickname,
        'lastMessage': lastMessageData['content'],
        'lastTime': lastMessageData['datetime'],
      });
    }

    // 마지막 메시지 시간 기준으로 최신순 정렬
    rooms.sort(
      (a, b) =>
          (b['lastTime'] as Timestamp).compareTo(a['lastTime'] as Timestamp),
    );
    return rooms;
  }
}
