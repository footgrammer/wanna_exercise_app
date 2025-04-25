import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanna_exercise_app/data/providers/user_provider.dart';
import 'package:wanna_exercise_app/pages/profile/edit_profile_page.dart';

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

    // 임시 uid 사용
    uid = 'k0pb7JaMYSMXsRm3BN3E'; // Firestore에 존재하는 문서 ID

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
          icon: const Icon(Icons.arrow_back, color: Color(0xFF252524)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '프로필',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF252524),
          ),
        ),
        centerTitle: false,
      ),
      body: profile == null
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: mainColor.withOpacity(0.2),
                    backgroundImage: profile.profileImage.isNotEmpty
                        ? NetworkImage(profile.profileImage)
                        : null,
                    child: profile.profileImage.isEmpty
                        ? Icon(Icons.person, size: 60, color: mainColor)
                        : null,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    profile.nickname,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF252524),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    profile.email,
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
