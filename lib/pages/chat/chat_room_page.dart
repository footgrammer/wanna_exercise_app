import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanna_exercise_app/data/repositories/profile_repository.dart';
import 'package:wanna_exercise_app/pages/chat/widgets/chat_room_bottomsheet.dart';
import 'package:wanna_exercise_app/pages/chat/widgets/chat_room_list_view.dart';
import 'package:wanna_exercise_app/data/models/profile.dart';

class ChatRoomPage extends ConsumerWidget {
  final String roomId;
  final String myUserId;

  ChatRoomPage({required this.roomId, required this.myUserId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      return Scaffold(body: Center(child: Text('로그인이 필요합니다')));
    }

    final profileRepository = ProfileRepository();

    return FutureBuilder<Profile?>(
      // 현재 로그인된 사용자 프로필 정보 불러오기
      future: profileRepository.getProfile(uid),
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

        final targetUserId = _getTargetUserId(uid, roomId);

        return Scaffold(
          appBar: AppBar(title: Text('채팅방')),
          body: Column(
            children: [
              Expanded(
                child: ChatRoomListView(
                  roomId: roomId,
                  myUserId: myUserId,
                  targetUserId: targetUserId,
                ),
              ),
              ChatRoomBottomsheet(
                bottomPadding: MediaQuery.of(context).padding.bottom,
                roomId: roomId,
                senderId: myUserId,
                senderImageUrl:
                    profile?.profileImage ??
                    'https://default-profile-image-url.com',
                senderNickname: profile?.nickname ?? 'Unknown',
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
