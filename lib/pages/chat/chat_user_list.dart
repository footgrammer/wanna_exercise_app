import 'package:flutter/material.dart';
import 'package:wanna_exercise_app/data/repositories/chat_repository.dart';
import 'package:wanna_exercise_app/pages/chat/chat_room_page.dart';
import 'package:wanna_exercise_app/data/repositories/profile_repository.dart'; // ProfileRepository 임포트

class UserListScreen extends StatelessWidget {
  final String myUserId;

  UserListScreen({required this.myUserId});

  @override
  Widget build(BuildContext context) {
    final _chatRepository = ChatRepository();
    final profileRepository = ProfileRepository(); // ProfileRepository 인스턴스화

    return Scaffold(
      appBar: AppBar(title: Text('상대방 선택')),
      body: FutureBuilder<List<Map<String, String>>>(
        future:
            profileRepository.getUserUidsWithNicknames(), // UID와 닉네임 목록 가져오기
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
                title: Text(nickname), // 닉네임을 표시
                onTap: () async {
                  // 여기부터 수정됨 (async 추가)
                  String roomId = _chatRepository.generateRoomId(
                    myUserId,
                    targetUid,
                  );

                  // 1. 채팅방 생성 먼저
                  await _chatRepository.createChatRoom(myUserId, targetUid);

                  // 2. 채팅방으로 이동
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
