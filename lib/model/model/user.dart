// 이메일
// 전화번호
// 비밀번호
// 닉네임
// 프로필 이미지

class User {
  User({
    required this.email,
    required this.phoneNumber,
    required this.pw,
    required this.nickname,
    required this.imgUrl,
  });

  final String email;
  final int phoneNumber;
  final String pw;
  final String nickname;
  final String imgUrl;

  // User.fromJson(Map<String, dynamic> json)
  //   : this(
  //       email: json['email'],
  //       phoneNumber: json['phoneNumber'],
  //       pw: json['pw'],
  //       nickname: json['nickname'],
  //       imgUrl: json['imgUrl'],
  //     );

  // Map<String, dynamic> toJson() => {
  //   'email': email,
  //   'phoneNumber': phoneNumber,
  //   'pw': pw,
  //   'nickname': nickname,
  //   'imgUrl': imgUrl,
  // };
}
