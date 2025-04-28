import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wanna_exercise_app/pages/chat/widgets/chat_room_bottomsheet.dart';
import 'package:wanna_exercise_app/pages/chat/widgets/chat_room_list_view.dart';
import 'package:wanna_exercise_app/data/providers/chat_user_provider.dart'; // 채팅 유저 프로바이더 (chatUserProvider)

class ChatRoomPage extends ConsumerWidget {
  final String roomId;

  ChatRoomPage({required this.roomId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    // 유저가 로그인하지 않은 경우
    if (uid == null) {
      return Scaffold(body: Center(child: Text('로그인이 필요합니다')));
    }

    final userAsync = ref.watch(chatUserProvider(uid));

    return userAsync.when(
      data: (user) {
        // 유저 정보가 null일 경우 처리
        if (user == null) {
          return Scaffold(body: Center(child: Text('유저 정보를 불러올 수 없습니다')));
        }

        // user가 null이 아니면 정상적으로 화면 구성
        return Scaffold(
          appBar: AppBar(title: Text('채팅방')),
          body: Column(
            children: [
              // ChatRoomListView
              ChatRoomListView(roomId: roomId, myUserId: uid),
              // ChatRoomBottomsheet
              ChatRoomBottomsheet(
                bottomPadding: MediaQuery.of(context).padding.bottom,
                roomId: roomId,
                senderId: user.uid,
                senderImageUrl:
                    user.profileImageUrl ??
                    'https://default-profile-image-url.com', // profileImageUrl이 없을 경우 기본 이미지 URL 사용
              ),
            ],
          ),
        );
      },
      loading: () => Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('유저 정보를 불러올 수 없습니다'))),
    );
  }
}
