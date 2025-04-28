import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wanna_exercise_app/data/models/chat.dart';
import 'package:wanna_exercise_app/data/models/chat_user_model.dart';

class ChatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<ChatRoomModel>> getMessages(String roomId) {
    return _firestore
        .collection('chatRooms')
        .doc(roomId)
        .collection('messages')
        .orderBy('datetime', descending: true) // 최신 메시지가 먼저 오도록 변경
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => ChatRoomModel.fromMap(doc.data()))
                  .toList(),
        );
  }

  Future<ChatUser?> getUserByUID(String uid) async {
    try {
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (!doc.exists) {
        print('User not found for UID: $uid');
        return null;
      }
      return ChatUser.fromMap(uid, doc.data()!);
    } catch (e) {
      print('Error fetching user: $e');
      rethrow; // 에러를 다시 던져서 상위 레벨에서 처리할 수 있게 함
    }
  }

  Future<void> sendMessage({
    required String roomId,
    required String senderId,
    required String senderImageUrl,
    required String content,
  }) async {
    if (content.trim().isEmpty) {
      print('Cannot send an empty message.');
      return;
    }

    try {
      await _firestore
          .collection('chatRooms')
          .doc(roomId)
          .collection('messages')
          .add({
            'senderId': senderId,
            'senderImageUrl': senderImageUrl,
            'content': content,
            'datetime': FieldValue.serverTimestamp(),
          });
    } catch (e) {
      print('Error sending message: $e');
    }
  }
}
