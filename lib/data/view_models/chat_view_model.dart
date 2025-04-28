import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanna_exercise_app/data/repositories/chat_repository.dart';

class ChatViewModel extends StateNotifier<AsyncValue<void>> {
  final ChatRepository _repo;
  ChatViewModel(this._repo) : super(const AsyncValue.data(null));

  // ViewModel에서 send() 수정
  Future<void> send({
    required String roomId,
    required String senderId,
    required String senderImageUrl,
    required String content,
  }) async {
    try {
      state = const AsyncValue.loading();
      // 메시지 전송
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
