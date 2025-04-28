import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanna_exercise_app/data/models/chat_user_model.dart';
import 'package:wanna_exercise_app/data/repositories/chat_user_repository.dart';

final userRepositoryProvider = Provider((ref) => UserRepository());

final chatUserProvider = FutureProvider.family<ChatUser, String>((ref, uid) {
  return ref.read(userRepositoryProvider).getUserByUID(uid);
});
