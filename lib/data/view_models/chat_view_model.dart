import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanna_exercise_app/data/repositories/chat_repository.dart';

class ChatViewModel extends StateNotifier<AsyncValue<void>> {
  final ChatRepository _repo;
  ChatViewModel(this._repo) : super(const AsyncValue.data(null));

  Future<void> send({
    required String roomId,
    required String senderId,
    required String senderImageUrl,
    required String content,
  }) async {
    try {
      state = const AsyncValue.loading();
      await _repo.sendMessage(
        roomId: roomId,
        senderId: senderId,
        senderImageUrl: senderImageUrl,
        content: content,
      );
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
