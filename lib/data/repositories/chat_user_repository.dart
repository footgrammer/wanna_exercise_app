import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wanna_exercise_app/data/models/chat_user_model.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<ChatUser> getUserByUID(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    return ChatUser.fromMap(uid, doc.data()!);
  }
}
