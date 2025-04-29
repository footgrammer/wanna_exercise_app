import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wanna_exercise_app/data/models/chat.dart';
import 'package:wanna_exercise_app/data/models/chat_user_model.dart';

class ChatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 메시지 스트림 가져오기
  Stream<List<ChatRoomModel>> getMessages(String roomId) {
    return _firestore
        .collection('chatRooms')
        .doc(roomId)
        .collection('messages')
        .orderBy('datetime', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => ChatRoomModel.fromMap(doc.data()))
                  .toList(),
        );
  }

  // UID로 사용자 정보 가져오기
  Future<ChatUser?> getUserByUID(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (!doc.exists) {
        print('User not found for UID: $uid');
        return null;
      }
      return ChatUser.fromMap(uid, doc.data()!);
    } catch (e) {
      print('Error fetching user: $e');
      rethrow;
    }
  }

  // 메시지 보내기 + 채팅방 업데이트
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

      // 채팅방에 최근 메시지 업데이트
      await _firestore.collection('chatRooms').doc(roomId).update({
        'lastMessage': content,
        'lastMessageTime': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  // 채팅방 ID 생성
  String generateRoomId(String uid1, String uid2) {
    List<String> uids = [uid1, uid2];
    uids.sort();
    return '${uids[0]}_${uids[1]}';
  }

  // 새로운 채팅방 생성
  Future<void> createChatRoom(String uid1, String uid2) async {
    try {
      String roomId = generateRoomId(uid1, uid2);

      var roomDoc = await _firestore.collection('chatRooms').doc(roomId).get();
      if (!roomDoc.exists) {
        await _firestore.collection('chatRooms').doc(roomId).set({
          'roomId': roomId,
          'users': [uid1, uid2],
          'createdAt': FieldValue.serverTimestamp(),
          'lastMessage': '',
          'lastMessageTime': null,
        });
      }
    } catch (e) {
      print('Error creating chat room: $e');
    }
  }

  // 채팅방 목록 가져오기 추가
  Stream<QuerySnapshot<Map<String, dynamic>>> getChatRooms(String uid) {
    return _firestore
        .collection('chatRooms')
        .where('users', arrayContains: uid)
        .orderBy('lastMessageTime', descending: true)
        .snapshots();
  }
}
