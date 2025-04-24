class Profile {
  Profile({required this.email, required this.nickname, required this.imgUrl});

  final String email;
  final String nickname;
  final String imgUrl;

  Profile.fromJson(Map<String, dynamic> json)
    : this(
        email: json['email'],
        nickname: json['nickname'],
        imgUrl: json['imgUrl'],
      );

  Map<String, dynamic> toJson() => {
    'email': email,
    'nickname': nickname,
    'imgUrl': imgUrl,
  };
}
