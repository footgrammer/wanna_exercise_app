import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanna_exercise_app/data/providers/chat_provider.dart';

class ChatRoomBottomsheet extends ConsumerStatefulWidget {
  final double bottomPadding;
  final String roomId;
  final String senderId;
  final String senderImageUrl;
  final String senderNickname; // senderNickname 추가

  ChatRoomBottomsheet({
    required this.bottomPadding,
    required this.roomId,
    required this.senderId,
    required this.senderImageUrl,
    required this.senderNickname, // senderNickname 추가
  });

  @override
  ConsumerState<ChatRoomBottomsheet> createState() =>
      _ChatRoomBottomsheetState();
}

class _ChatRoomBottomsheetState extends ConsumerState<ChatRoomBottomsheet> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onSend() async {
    final content = controller.text.trim();
    if (content.isEmpty) return;

    final viewModel = ref.read(chatViewModelProvider.notifier);

    await viewModel.send(
      roomId: widget.roomId,
      senderId: widget.senderId,
      senderImageUrl: widget.senderImageUrl,
      content: content,
    );

    controller.clear(); // 전송 후 입력창 비우기
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70 + widget.bottomPadding,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                // 프로필 이미지와 닉네임 추가
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.senderImageUrl),
                ),
                SizedBox(width: 10),
                Text(widget.senderNickname), // senderNickname 표시
                Expanded(
                  child: TextField(
                    controller: controller,
                    onSubmitted: (_) => onSend(),
                  ),
                ),
                GestureDetector(
                  onTap: onSend,
                  child: Container(
                    width: 50,
                    height: 50,
                    color: Colors.transparent,
                    child: const Icon(Icons.send, color: Colors.amber),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: widget.bottomPadding),
        ],
      ),
    );
  }
}
