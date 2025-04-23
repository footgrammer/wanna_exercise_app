import 'package:flutter/material.dart';
import 'package:wanna_exercise_app/UI/pages/chat/widgets/chat_room_bottomsheet.dart';
import 'package:wanna_exercise_app/UI/pages/chat/widgets/chat_room_list_view.dart';

class ChatRoomPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('채팅방'),
        centerTitle: true,
      ),
      bottomSheet: ChatRoomBottomsheet(),
      body: Column(
        children: [
          ChatRoomListView()
        ],
      ),
    );
  }
}