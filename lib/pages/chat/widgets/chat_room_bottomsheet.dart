import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanna_exercise_app/data/providers/chat_provider.dart';

class ChatRoomBottomsheet extends ConsumerStatefulWidget {
  final double bottomPadding;
  final String roomId;
  final String senderId;
  final String senderImageUrl;

  ChatRoomBottomsheet({
    required this.bottomPadding,
    required this.roomId,
    required this.senderId,
    required this.senderImageUrl,
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

// 상위 위젯에서 예시
// return user.when(
//   data: (userModel) => ChatRoomBottomsheet(
//     bottomPadding: MediaQuery.of(context).padding.bottom,
//     roomId: 'exampleRoomId',
//     senderId: userModel.uid,
//     senderImageUrl: userModel.profileImageUrl,
//   ),
//   loading: () => CircularProgressIndicator(),
//   error: (e, _) => Text('유저 정보를 불러올 수 없습니다'),
// );
