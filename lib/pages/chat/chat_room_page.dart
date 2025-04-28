import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanna_exercise_app/data/repositories/profile_repository.dart'; // ProfileRepository 임포트
import 'package:wanna_exercise_app/pages/chat/widgets/chat_room_bottomsheet.dart';
import 'package:wanna_exercise_app/pages/chat/widgets/chat_room_list_view.dart';
import 'package:wanna_exercise_app/data/models/profile.dart'; // Profile 모델 임포트

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

    final profileRepository = ProfileRepository();

    return FutureBuilder<Profile?>(
      future: profileRepository.getProfile(uid), // `uid`로 프로필 정보 가져오기
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text('유저 정보를 불러올 수 없습니다')));
        }

        if (!snapshot.hasData) {
          return Scaffold(body: Center(child: Text('유저 정보가 존재하지 않습니다')));
        }

        final profile = snapshot.data;

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
                senderId: uid,
                senderImageUrl:
                    profile?.profileImage ??
                    'https://default-profile-image-url.com', // 프로필 이미지 URL
                senderNickname: profile?.nickname ?? 'Unknown', // 닉네임
              ),
            ],
          ),
        );
      },
    );
  }
}
