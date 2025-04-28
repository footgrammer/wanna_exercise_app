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

  // Firestore에서 메시지를 받아올 때 사용되는 factory
  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      senderId: map['senderId'] ?? '',
      senderImageUrl: map['senderImageUrl'] ?? '',
      content: map['content'] ?? '',
      sentAt: map['sentAt'] ?? Timestamp.now(), // `sentAt`은 Timestamp 형식
    );
  }

  // JSON 데이터를 받아서 객체로 변환하는 fromJson
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      senderId: json['senderId'] ?? '',
      senderImageUrl: json['senderImageUrl'] ?? '',
      content: json['content'] ?? '',
      sentAt: json['sentAt'] ?? Timestamp.now(),
    );
  }

  // 객체를 Map으로 변환할 때 사용하는 toMap
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderImageUrl': senderImageUrl,
      'content': content,
      'sentAt': sentAt,
    };
  }

  // 객체를 JSON으로 변환할 때 사용하는 toJson
  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'senderImageUrl': senderImageUrl,
      'content': content,
      'sentAt': sentAt,
    };
  }
}
