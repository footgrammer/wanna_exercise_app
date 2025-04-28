import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wanna_exercise_app/data/models/chat.dart';

class ChatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<ChatRoomModel>> getMessages(String roomId) {
    return _firestore
        .collection('chatRooms')
        .doc(roomId)
        .collection('messages')
        .orderBy('datetime', descending: false)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => ChatRoomModel.fromMap(doc.data()))
                  .toList(),
        );
  }

  Future<void> sendMessage({
    required String roomId,
    required String senderId,
    required String senderImageUrl,
    required String content,
  }) async {
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
  }
}
