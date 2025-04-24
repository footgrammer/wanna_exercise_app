import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepository {
  Future<void> getaAll() async {
    final firestore = FirebaseFirestore.instance;
    final collectionRef = firestore.collection('chats');
    final result = await collectionRef.get();
    final docs = result.docs;

    for (var doc in docs) {
      print(doc.id);
      print(doc.data());
    }
  }
}