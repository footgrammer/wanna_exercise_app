import 'package:flutter/material.dart';

class ChatRoomSend extends StatelessWidget {
  ChatRoomSend({
    required this.content, 
    required this.dateTime
    });
  final String content;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 224, 224, 224),
            borderRadius: BorderRadius.circular(16)
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(content,
          style: TextStyle(fontSize: 13),),
        ),
        Text(dateTime.toIso8601String(),
        style: TextStyle(
          fontSize: 13,
          color: Colors.black
        ),)
      ],
    );
  }
}
