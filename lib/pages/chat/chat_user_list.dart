import 'package:flutter/material.dart';
import 'package:wanna_exercise_app/data/repositories/chat_repository.dart';
import 'package:wanna_exercise_app/pages/chat/chat_room_page.dart';
import 'package:wanna_exercise_app/data/repositories/profile_repository.dart';

class UserListScreen extends StatelessWidget {
  final String myUserId;

  UserListScreen({required this.myUserId});

  @override
  Widget build(BuildContext context) {
    final _chatRepository = ChatRepository();
    final profileRepository = ProfileRepository();

    return Scaffold(
      appBar: AppBar(title: Text('상대방 선택')),
      body: FutureBuilder<List<Map<String, String>>>(
        // 모든 사용자 UID + 닉네임 리스트 불러오기
        future: profileRepository.getUserUidsWithNicknames(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('사용자 목록을 불러오는데 실패했습니다.'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('등록된 사용자가 없습니다.'));
          }

          final users = snapshot.data!;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final targetUid = user['uid']!;
              final nickname = user['nickname']!;

              return ListTile(
                title: Text(nickname),
                onTap: () async {
                  // 채팅방 ID 생성 및 Firestore에 방 생성
                  String roomId = _chatRepository.generateRoomId(
                    myUserId,
                    targetUid,
                  );
                  await _chatRepository.createChatRoom(myUserId, targetUid);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              ChatRoomPage(roomId: roomId, myUserId: myUserId),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
