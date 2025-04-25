import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomModel {
  final String senderId;
  final String senderImageUrl;
  final String content;
  final String datetime;

  ChatRoomModel({
    required this.senderId,
    required this.senderImageUrl,
    required this.content,
    required this.datetime,
  });

  factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
    return ChatRoomModel(
      senderId: map['senderId'] ?? '',
      senderImageUrl: map['senderImageUrl'] ?? '',
      content: map['content'] ?? '',
      datetime: (map['datetime'] as Timestamp).toDate().toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderImageUrl': senderImageUrl,
      'content': content,
      'datetime': datetime,
    };
  }
}
