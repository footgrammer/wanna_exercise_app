import 'package:flutter/material.dart';

class ChatRoomBottomsheet extends StatefulWidget {
  ChatRoomBottomsheet(this.bottomPadding);

  final double bottomPadding;

  @override
  State<ChatRoomBottomsheet> createState() => _ChatRoomBottomsheetState();
}

class _ChatRoomBottomsheetState extends State<ChatRoomBottomsheet> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onSend() {
    print('onSend 터치됌');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70 + widget.bottomPadding,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    onSubmitted: (v)=>onSend(),
                  ),
                ),
                GestureDetector(
                  onTap: onSend,
                  child: Container(
                    width: 50,
                    height: 50,
                    color: Colors.transparent,
                    child: Icon(Icons.send, color: Colors.amber),
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
