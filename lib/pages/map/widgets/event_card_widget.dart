import 'package:flutter/material.dart';
import 'package:wanna_exercise_app/pages/chat/chat_page.dart';

class EventCardWidget extends StatelessWidget {
  //모달 표시 정보
  final String title;// 모임 제목
  final String content; // 모임 내용
  final String time; // 모임 시간
  final String myUserId; // 유저ID (채팅방 이동할 떄 사용)

  const EventCardWidget({
    super.key,
    required this.title,
    required this.content,
    required this.time,
    required this.myUserId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text('🕒 시간: $time'),
          const SizedBox(height: 10),
          Text(content),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);// 모달 닫기
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatPage(myUserId: myUserId),// 채팅 페이지로 이동
                  ),
                );
              },
              child: const Text('채팅하러 가기'),
            ),
          ),
        ],
      ),
    );
  }
}
