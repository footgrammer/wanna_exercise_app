import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String senderId;
  final String senderImageUrl;
  final String content;
  final Timestamp sentAt;

  ChatMessage({
    required this.senderId,
    required this.senderImageUrl,
    required this.content,
    required this.sentAt,
  });

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      senderId: map['senderId'] ?? '',
      senderImageUrl: map['senderImageUrl'] ?? '',
      content: map['content'] ?? '',
      sentAt: map['datetime'] ?? Timestamp.now(), // ← 수정
    );
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      senderId: json['senderId'] ?? '',
      senderImageUrl: json['senderImageUrl'] ?? '',
      content: json['content'] ?? '',
      sentAt: json['datetime'] ?? Timestamp.now(), // ← 수정
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderImageUrl': senderImageUrl,
      'content': content,
      'datetime': sentAt, // ← 저장할 때도 datetime으로
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'senderImageUrl': senderImageUrl,
      'content': content,
      'datetime': sentAt, // ← 저장할 때도 datetime으로
    };
  }
}
