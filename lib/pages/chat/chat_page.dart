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

  Future<Map<String, String>> _getOtherUserInfo(String otherUserId) async {
    final profile = await _profileRepository.getProfile(otherUserId);
    return {
      'nickname': profile?.nickname ?? '알 수 없음',
      'profileImage': profile?.profileImage ?? '', // Firestore에서 불러온 이미지 URL
    };
  }

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
                                color: Color.fromARGB(255, 134, 134, 245),
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
