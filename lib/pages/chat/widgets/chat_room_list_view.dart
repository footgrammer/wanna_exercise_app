import 'package:flutter/material.dart';
import 'package:wanna_exercise_app/UI/pages/chat/widgets/chat_room_receive.dart';
import 'package:wanna_exercise_app/UI/pages/chat/widgets/chat_room_send.dart';

class ChatRoomListView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    final children = [
          ChatRoomReceive(
            imgUrl: "https://picsum.photos/200/300",
            showProfile: true,
            content: "안녕하세요",
            dateTime: DateTime.now(),
          ),

          ChatRoomReceive(
            imgUrl: "https://picsum.photos/200/300",
            showProfile: false,
            content: "홍길동입니다",
            dateTime: DateTime.now(),
          ),
          ChatRoomSend(
            content: '안녕하세요 네',
            dateTime: DateTime.now(),
          ),
          ChatRoomSend(
            content: '손진성입니다',
            dateTime: DateTime.now(),
          )
        ];

    return Expanded(
      child: ListView.separated(
        itemCount: children.length,
        separatorBuilder: (context, index) => SizedBox(height: 4,),
        itemBuilder: (context, index) {
          return children[index];
          
        },
      ));
  }
}