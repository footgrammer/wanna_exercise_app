import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String nickname = '닉네임'; // 임시
    final String email = 'abcd@google.com'; // 임시
    const Color mainColor = Color(0xFF007AFF);

    return Scaffold(
      backgroundColor: Color(0xFFe5e5e5),
      appBar: AppBar(
        backgroundColor: Color(0xFFe5e5e5),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF252524)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '프로필',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF252524),
          ),
        ),
        centerTitle: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: mainColor.withOpacity(0.2),
              child: Icon(
                Icons.person,
                size: 60,
                color: mainColor,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              nickname,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF252524),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              email,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: FloatingActionButton(
          onPressed: () {
            // 수정 페이지 이동
          },
          backgroundColor: mainColor.withOpacity(0.2),
          child: Icon(Icons.edit, color: mainColor),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
