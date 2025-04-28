class ChatUser {
  final String uid;
  final String name;
  final String profileImageUrl;

  ChatUser({
    required this.uid,
    required this.name,
    required this.profileImageUrl,
  });

  factory ChatUser.fromMap(String uid, Map<String, dynamic> map) {
    return ChatUser(
      uid: uid,
      name: map['name'] ?? '',
      profileImageUrl: map['profileImageUrl'] ?? '',
    );
  }
}
