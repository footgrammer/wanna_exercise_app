import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanna_exercise_app/data/providers/chat_provider.dart';

class ChatRoomBottomsheet extends ConsumerStatefulWidget {
  final double bottomPadding;
  final String roomId;
  final String senderId;
  final String senderImageUrl;
  final String senderNickname;

  ChatRoomBottomsheet({
    required this.bottomPadding,
    required this.roomId,
    required this.senderId,
    required this.senderImageUrl,
    required this.senderNickname,
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

  // 메시지 전송 함수
  void onSend() async {
    final content = controller.text.trim();
    if (content.isEmpty) return;

    final viewModel = ref.read(chatViewModelProvider.notifier);

    // 실제로 사용자가 입력한 메시지를 보내기
    await viewModel.send(
      roomId: widget.roomId,
      senderId: widget.senderId,
      senderImageUrl: widget.senderImageUrl,
      content: content, // 사용자가 입력한 메시지 내용
    );

    controller.clear(); // 전송 후 입력창 비우기
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Container 높이 조정
      height: 70 + widget.bottomPadding, // bottomPadding이 너무 적거나 많으면 조정해보세요
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                // 프로필 이미지와 닉네임
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.senderImageUrl),
                ),
                SizedBox(width: 10),
                Text(widget.senderNickname), // senderNickname 표시
                Expanded(
                  child: TextField(
                    controller: controller,
                    onSubmitted: (_) => onSend(),
                    decoration: InputDecoration(
                      hintText: "메시지를 입력하세요",
                      border: InputBorder.none, // 기본 테두리 없애기
                    ),
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
          SizedBox(height: widget.bottomPadding), // 여백
        ],
      ),
    );
  }
}
