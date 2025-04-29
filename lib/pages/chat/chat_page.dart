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

  // Firebase Firestore에서 사용자 정보를 가져오는 함수입니다.
  Future<Map<String, String>> _getOtherUserInfo(String otherUserId) async {
    final profile = await _profileRepository.getProfile(otherUserId);
    return {
      'nickname': profile?.nickname ?? '알 수 없음', // 사용자 닉네임
      'profileImage': profile?.profileImage ?? '', // 사용자 프로필 이미지 URL
    };
  }

  // Firebase Firestore에서 채팅방의 마지막 메시지를 가져오는 함수입니다.
  Future<Map<String, dynamic>> _getLastMessage(String roomId) async {
    final messagesSnapshot =
        await FirebaseFirestore.instance
            .collection('chatRooms')
            .doc(roomId)
            .collection('messages')
            .orderBy('datetime', descending: true) // 최신 메시지를 가져오기 위해 날짜 기준으로 정렬
            .limit(1) // 마지막 메시지 하나만 가져오기
            .get();

    if (messagesSnapshot.docs.isNotEmpty) {
      final lastMessage = messagesSnapshot.docs.first.data();
      return {
        'content': lastMessage['content'] ?? '', // 메시지 내용
        'datetime': lastMessage['datetime'] ?? Timestamp(0, 0), // 메시지 시간
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
              fontWeight: FontWeight.bold,
              color: Color(0xFF007AFF),
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
          // Firebase Firestore에서 채팅방 데이터를 실시간으로 받아옵니다.
          stream:
              FirebaseFirestore.instance
                  .collection('chatRooms')
                  .where(
                    'users',
                    arrayContains: myUserId,
                  ) // 내 사용자 ID가 포함된 채팅방만 가져옵니다.
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
              future: _buildSortedChatRooms(chatRoomDocs), // 채팅방을 정렬해서 가져옵니다.
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
                      // 프로필 이미지를 불러오거나 기본 아이콘을 표시합니다.
                      leading:
                          room['profileImage'].isNotEmpty
                              ? CircleAvatar(
                                backgroundImage: NetworkImage(
                                  room['profileImage'],
                                ),
                                radius: 20,
                              )
                              : Icon(
                                Icons.account_circle,
                                size: 40,
                                color: Color(0xFF1414b8),
                              ),
                      title: Text(
                        room['nickname'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        room['lastMessage'].isNotEmpty
                            ? room['lastMessage']
                            : '메시지가 없습니다.',
                      ),
                      onTap: () {
                        // 채팅방을 클릭하면 해당 채팅방으로 이동합니다.
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

  // Firebase Firestore에서 채팅방들을 가져와서 정렬합니다.
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

      final otherUserInfo = await _getOtherUserInfo(otherUserId);
      final lastMessageData = await _getLastMessage(roomId);

      rooms.add({
        'roomId': roomId,
        'nickname': otherUserInfo['nickname'],
        'profileImage': otherUserInfo['profileImage'],
        'lastMessage': lastMessageData['content'],
        'lastTime': lastMessageData['datetime'],
      });
    }

    rooms.sort(
      (a, b) =>
          (b['lastTime'] as Timestamp).compareTo(a['lastTime'] as Timestamp),
    );

    return rooms;
  }
}
