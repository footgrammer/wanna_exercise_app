// 이메일
// 비밀번호
// 닉네임
// 프로필 이미지

class User {
  User({
    required this.id,
    required this.email,
    required this.pw,
    required this.nickname,
    required this.imgUrl,
  });

  final String id;
  final String email;
  final String pw;
  final String nickname;
  final String imgUrl;

  // User.fromJson(Map<String, dynamic> json)
  //   : this(
  //       id: json['id']
  //       email: json['email'],
  //       pw: json['pw'],
  //       nickname: json['nickname'],
  //       imgUrl: json['imgUrl'],
  //     );

  // Map<String, dynamic> toJson() => {
  //   'id': id,
  //   'email': email,
  //   'pw': pw,
  //   'nickname': nickname,
  //   'imgUrl': imgUrl,
  // };
}
