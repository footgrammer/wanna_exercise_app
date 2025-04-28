import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanna_exercise_app/data/models/chat_message_model.dart';
import 'package:wanna_exercise_app/data/repositories/chat_repository.dart';
import 'package:wanna_exercise_app/pages/chat/widgets/chat_room_bottomsheet.dart';
import 'package:wanna_exercise_app/pages/chat/widgets/chat_room_receive.dart';
import 'package:wanna_exercise_app/pages/chat/widgets/chat_room_send.dart';

class ChatRoomListView extends ConsumerStatefulWidget {
  // ConsumerWidget -> ConsumerStatefulWidget
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
    loadMyProfile();
  }

  Future<void> loadMyProfile() async {
    try {
      final userDoc =
          await FirebaseFirestore.instance
              .collection('profile') // <-- 너의 사용자 정보가 저장된 collection 이름
              .doc(widget.myUserId)
              .get();

      if (userDoc.exists) {
        final data = userDoc.data()!;
        setState(() {
          senderNickname = data['nickname'] ?? '알 수 없음'; // <-- 너의 DB 필드명 맞춰야 함
          senderImageUrl = data['profileImage'] ?? ''; // <-- 너의 DB 필드명 맞춰야 함
          isLoading = false;
        });
      } else {
        throw Exception('사용자 정보 없음');
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
    final _chatRepository = ChatRepository();

    if (isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Column(
        children: [
          // 채팅 메시지 리스트
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance
                      .collection('chatRooms')
                      .doc(widget.roomId)
                      .collection('messages')
                      .orderBy('datetime', descending: false)
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('아직 메시지가 없습니다'));
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final docs = snapshot.data!.docs;

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

          // 메시지 입력란
        ],
      ),
    );
  }

  bool _shouldShowProfile(List<QueryDocumentSnapshot> docs, int index) {
    if (index == 0) return true;

    final current = docs[index].data() as Map<String, dynamic>;
    final previous = docs[index - 1].data() as Map<String, dynamic>;

    return current['senderId'] != previous['senderId'];
  }
}
