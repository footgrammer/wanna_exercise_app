import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanna_exercise_app/data/repositories/profile_repository.dart'; // ProfileRepository 임포트
import 'package:wanna_exercise_app/pages/chat/widgets/chat_room_bottomsheet.dart';
import 'package:wanna_exercise_app/pages/chat/widgets/chat_room_list_view.dart';
import 'package:wanna_exercise_app/data/models/profile.dart'; // Profile 모델 임포트

class ChatRoomPage extends ConsumerWidget {
  final String roomId;
  final String myUserId;

  ChatRoomPage({
    required this.roomId,
    required this.myUserId,
  }); // myUserId를 생성자에 추가

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

        // `roomId`에서 상대방 UID 추출 (두 UID 중 하나가 내 UID이고, 다른 하나가 상대방 UID)
        final targetUserId = _getTargetUserId(uid!, roomId);

        // user가 null이 아니면 정상적으로 화면 구성
        return Scaffold(
          appBar: AppBar(title: Text('채팅방')),
          body: Column(
            children: [
              // ChatRoomListView에 상대방 UID(targetUserId) 추가
              Expanded(
                child: ChatRoomListView(
                  roomId: roomId,
                  myUserId: myUserId, // myUserId 전달
                  targetUserId: targetUserId, // 상대방 UID 넘기기
                ),
              ),
              // ChatRoomBottomsheet
              ChatRoomBottomsheet(
                bottomPadding: MediaQuery.of(context).padding.bottom,
                roomId: roomId,
                senderId: myUserId, // myUserId 전달
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

  // roomId에서 상대방 UID 추출
  String _getTargetUserId(String myUserId, String roomId) {
    List<String> uids = roomId.split('_');
    return uids.first == myUserId ? uids.last : uids.first;
  }
}
