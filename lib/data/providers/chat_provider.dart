import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanna_exercise_app/data/models/chat.dart';
import 'package:wanna_exercise_app/data/repositories/chat_repository.dart';
import 'package:wanna_exercise_app/data/view_models/chat_view_model.dart';

final chatRepositoryProvider = Provider((ref) => ChatRepository());

final chatMessagesProvider = StreamProvider.family<List<ChatRoomModel>, String>(
  (ref, roomId) {
    return ref.watch(chatRepositoryProvider).getMessages(roomId);
  },
);

final chatViewModelProvider =
    StateNotifierProvider<ChatViewModel, AsyncValue<void>>((ref) {
      final repo = ref.watch(chatRepositoryProvider);
      return ChatViewModel(repo);
    });
