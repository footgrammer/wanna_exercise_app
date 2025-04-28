import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanna_exercise_app/data/providers/user_provider.dart';
import 'package:wanna_exercise_app/pages/login/login_page.dart';
import 'package:wanna_exercise_app/pages/profile/edit_profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wanna_exercise_app/pages/widgets/show_confirm_pop_up.dart';
import 'package:wanna_exercise_app/pages/widgets/show_custom_snack_bar.dart';
import 'package:wanna_exercise_app/themes/light_theme.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  late final String uid;

  @override
  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
    }

    // ViewModel 통해 프로필 불러오기
    Future.microtask(() {
      ref.read(userViewModelProvider.notifier).loadProfile(uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(userViewModelProvider);
    final profile = viewModel.profile;

    const Color mainColor = Color(0xFF007AFF);

    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE5E5E5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF007AFF)),
          onPressed: () => Navigator.pop(context),
        ),

        title: const Text(
          '프로필',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF007AFF),
          ),
        ),
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () async {
              final bool? confirm = await showConfirmPopUp(
                context,
                title: '로그아웃',
                content: '로그아웃하시겠습니까?',
              );
              if (confirm != null && confirm) {
                await FirebaseAuth.instance.signOut();
                showCustomSnackBar(
                  context,
                  text: '로그아웃되었습니다.',
                  bottomPadding: 100,
                );
              }
            },
            child: Container(
              width: 80,
              height: 50,
              color: Colors.transparent,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '로그아웃',
                  style: TextStyle(color: textColor.withValues(alpha: 0.7)),
                ),
              ),
            ),
          ),
        ],
      ),
      body:
          profile == null
              ? const Center(child: CircularProgressIndicator())
              : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundColor: const Color.fromARGB(255, 169, 211, 255),
                      backgroundImage:
                          profile.profileImage.isNotEmpty
                              ? NetworkImage(profile.profileImage)
                              : null,
                      child:
                          profile.profileImage.isEmpty
                              ? const Icon(
                                Icons.person,
                                size: 100,
                                color: Color(0xFF007AFF),
                              )
                              : null,
                    ), // 로그인한 사용자 프로필 이미지와 닉네임을 설정하지 않았을 때, 프로필 이미지 = 기본 아바타
                    const SizedBox(height: 16),
                    Text(
                      profile.nickname.isNotEmpty ? profile.nickname : '김운동',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF252524),
                      ), // 로그인한 사용자가 닉네임을 설정하지 않았을 때, 닉네임 = 김운동
                    ),
                    const SizedBox(height: 4),
                    Text(
                      profile.phone,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EditProfilePage()),
            );
          },
          backgroundColor: mainColor.withOpacity(0.2),
          child: const Icon(Icons.edit, color: mainColor),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
