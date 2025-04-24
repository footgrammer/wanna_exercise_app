import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wanna_exercise_app/model/model/profile.dart';

class ProfileRepository {
  const ProfileRepository();
  Future<List<Profile>> getAll() async {
    final firestore = FirebaseFirestore.instance;

    final collectionRef = firestore.collection('user');
    final snapshot = await collectionRef.get();
    final documentSnapshots = snapshot.docs;

    return documentSnapshots.map((e) {
      final map = {...e.data()};
      return Profile.fromJson(map);
    }).toList(); // Profile 전체 리스트 반환
  }
}
