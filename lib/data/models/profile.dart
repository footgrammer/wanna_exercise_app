// imgUr -> profileImage로 변경
class Profile {
  final String email;
  final String nickname;
  final String profileImage;

  Profile({
    required this.email,
    required this.nickname,
    required this.profileImage,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      email: json['email'] ?? '',
      nickname: json['nickname'] ?? '',
      profileImage: json['profileImage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'nickname': nickname,
        'profileImage': profileImage,
      };

        Profile copyWith({
    String? email,
    String? nickname,
    String? profileImage,
  }) {
    return Profile(
      email: email ?? this.email,
      nickname: nickname ?? this.nickname,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}



// class Profile {
//   Profile({required this.email, required this.nickname, required this.imgUrl});

//   final String email;
//   final String nickname;
//   final String imgUrl;

//   Profile.fromJson(Map<String, dynamic> json)
//     : this(
//         email: json['email'],
//         nickname: json['nickname'],
//         imgUrl: json['imgUrl'],
//       );

//   Map<String, dynamic> toJson() => {
//     'email': email,
//     'nickname': nickname,
//     'imgUrl': imgUrl,
//   };
// }
