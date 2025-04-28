import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wanna_exercise_app/data/models/chat_user_model.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<ChatUser> getUserByUID(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();

      // doc이 존재하지 않으면 예외 처리
      if (!doc.exists) {
        throw Exception('User not found');
      }
      return ChatUser.fromMap(uid, doc.data()!);
    } catch (e) {
      print('Error fetching user: $e');
      throw Exception('Failed to fetch user');
    }
  }
}
