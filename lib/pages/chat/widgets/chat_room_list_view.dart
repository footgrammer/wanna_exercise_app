import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanna_exercise_app/data/models/chat_message_model.dart';
import 'package:wanna_exercise_app/pages/chat/widgets/chat_room_receive.dart';
import 'package:wanna_exercise_app/pages/chat/widgets/chat_room_send.dart';

class ChatRoomListView extends ConsumerWidget {
  final String roomId;
  final String myUserId;

  ChatRoomListView({required this.roomId, required this.myUserId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance
                .collection('chatRooms')
                .doc(roomId)
                .collection('messages')
                .orderBy('datetime', descending: false) // ← 여기만 바꾼다!
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

              if (message.senderId == myUserId) {
                // 내가 보낸 메시지
                return ChatRoomSend(
                  content: message.content,
                  dateTime: message.sentAt.toDate(),
                );
              } else {
                // 상대방이 보낸 메시지
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
    );
  }

  bool _shouldShowProfile(List<QueryDocumentSnapshot> docs, int index) {
    // 첫 번째 메시지는 항상 프로필을 보여줍니다.
    if (index == 0) return true;

    // 이전 메시지와 현재 메시지가 동일한 사용자인지 비교
    final current = docs[index].data() as Map<String, dynamic>;
    final previous = docs[index - 1].data() as Map<String, dynamic>;

    return current['senderId'] != previous['senderId'];
  }
}
