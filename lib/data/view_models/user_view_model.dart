import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanna_exercise_app/data/models/profile.dart';
import 'package:wanna_exercise_app/data/repositories/profile_repository.dart';

class UserViewModel extends ChangeNotifier {
  final ProfileRepository _repository;

  UserViewModel(this._repository);

  File? _selectedImage;
  File? get selectedImage => _selectedImage;

  Profile? _profile;
  Profile? get profile => _profile;

  final TextEditingController nicknameController = TextEditingController();

  // 프로필 불러오기
  Future<void> loadProfile(String uid) async {
    _profile = await _repository.getProfile(uid);
    nicknameController.text = _profile?.nickname ?? '';
    notifyListeners();
  }

  // 이미지 선택 (갤러리)
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      _selectedImage = File(picked.path);
      notifyListeners();
    }
  }

  // 프로필 이미지 업로드 + Firestore 반영
 Future<void> uploadProfileImage(String uid) async {
  if (_selectedImage == null) return;

  try {
    final url = await _repository.uploadProfileImage(uid, _selectedImage!);
    _profile = _profile?.copyWith(profileImage: url);
    notifyListeners();
  } catch (e, s) {
    debugPrint('이미지 업로드 실패: $e');
    debugPrintStack(stackTrace: s);
  }
}

  // 닉네임 Firestore 업데이트
  Future<void> updateNickname(String uid) async {
    final nickname = nicknameController.text.trim();
    if (nickname.isEmpty) return;

    await _repository.updateNickname(uid, nickname);
    _profile = _profile?.copyWith(nickname: nickname);
    notifyListeners();
  }

  // 프로필 전체 업데이트 (이미지 + 닉네임)
  Future<void> updateProfile(String uid) async {
    if (_selectedImage != null) {
      await uploadProfileImage(uid);
    }
    await updateNickname(uid);
  }
}
