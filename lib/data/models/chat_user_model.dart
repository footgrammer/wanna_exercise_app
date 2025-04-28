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
      name: map['name'] ?? 'Unnamed User', // 이름이 없을 경우 기본값 설정
      profileImageUrl: map['profileImageUrl'] ?? '', // 기본 이미지 URL을 빈 문자열로 설정
    );
  }
}
