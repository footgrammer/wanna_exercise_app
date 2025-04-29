import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanna_exercise_app/data/models/chat_message_model.dart';
import 'package:wanna_exercise_app/data/repositories/chat_repository.dart';
import 'package:wanna_exercise_app/pages/chat/widgets/chat_room_receive.dart';
import 'package:wanna_exercise_app/pages/chat/widgets/chat_room_send.dart';

class ChatRoomListView extends ConsumerStatefulWidget {
  final String roomId;
  final String myUserId;
  final String targetUserId;

  ChatRoomListView({
    required this.roomId,
    required this.myUserId,
    required this.targetUserId,
  });

  @override
  _ChatRoomListViewState createState() => _ChatRoomListViewState();
}

class _ChatRoomListViewState extends ConsumerState<ChatRoomListView> {
  String? senderNickname;
  String? senderImageUrl;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMyProfile(); // 사용자 프로필 로딩
  }

  // Firebase에서 사용자 프로필을 가져오는 함수
  Future<void> loadMyProfile() async {
    try {
      final userDoc =
          await FirebaseFirestore.instance
              .collection('profile') // Firebase의 'profile' 컬렉션에서
              .doc(widget.myUserId) // 내 사용자 ID로 문서 조회
              .get();

      if (userDoc.exists) {
        // 사용자 정보가 존재하면
        final data = userDoc.data()!;
        setState(() {
          senderNickname = data['nickname'] ?? '알 수 없음';
          senderImageUrl = data['profileImage'] ?? '';
          isLoading = false;
        });
      } else {
        throw Exception('사용자 정보 없음'); // 사용자 정보가 없으면 예외 처리
      }
    } catch (e) {
      print('프로필 로딩 에러: $e');
      // 에러 상황 처리 (예: 기본값 설정)
      setState(() {
        senderNickname = '알 수 없음';
        senderImageUrl = '';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _chatRepository = ChatRepository(); // 채팅 리포지토리 객체

    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ); // 로딩 중에는 스피너 표시
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              // Firebase의 'chatRooms' 컬렉션에서 해당 채팅방의 메시지를 실시간으로 가져옴
              stream:
                  FirebaseFirestore.instance
                      .collection('chatRooms')
                      .doc(widget.roomId) // 방 ID로 해당 채팅방 문서 조회
                      .collection('messages') // 해당 채팅방의 메시지 컬렉션
                      .orderBy('datetime', descending: false) // 메시지 시간 순으로 정렬
                      .snapshots(), // 실시간 업데이트
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator()); // 로딩 중일 때
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('아직 메시지가 없습니다')); // 메시지가 없으면 안내 텍스트
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  ); // 에러 발생 시
                }

                final docs = snapshot.data!.docs; // 메시지 목록 가져오기

                return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  itemCount: docs.length,
                  separatorBuilder: (context, index) => SizedBox(height: 4),
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;
                    final message = ChatMessage.fromJson(data);

                    if (message.senderId == widget.myUserId) {
                      return ChatRoomSend(
                        content: message.content,
                        dateTime: message.sentAt.toDate(),
                      );
                    } else {
                      return ChatRoomReceive(
                        imgUrl: message.senderImageUrl,
                        showProfile: _shouldShowProfile(docs, index),
                        content: message.content,
                        dateTime: message.sentAt.toDate(),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 현재 메시지와 이전 메시지의 보낸 사람 ID가 다르면 프로필 사진을 보여주는 함수
  bool _shouldShowProfile(List<QueryDocumentSnapshot> docs, int index) {
    if (index == 0) return true; // 첫 번째 메시지는 항상 프로필 표시

    final current = docs[index].data() as Map<String, dynamic>;
    final previous = docs[index - 1].data() as Map<String, dynamic>;

    return current['senderId'] != previous['senderId']; // 보낸 사람 ID가 다르면 프로필 표시
  }
}
