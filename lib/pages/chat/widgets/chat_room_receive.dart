import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wanna_exercise_app/pages/widgets/user_profile_image.dart';

class ChatRoomReceive extends StatelessWidget {
  const ChatRoomReceive({
    super.key,
    required this.imgUrl,
    required this.showProfile,
    required this.content,
    required this.dateTime,
  });

  final String imgUrl;
  final bool showProfile;
  final String content;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        showProfile
            ? UserProfileImage(demension: 50, imgUrl: imgUrl)
            : SizedBox(width: 50),

        SizedBox(width: 8),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 224, 224, 224),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(content, style: TextStyle(fontSize: 13)),
              ),

              Text(DateFormat('yyyy-MM-dd HH:mm').format(dateTime)),
            ],
          ),
        ),
      ],
    );
  }
}
