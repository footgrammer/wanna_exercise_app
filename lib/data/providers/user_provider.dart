import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanna_exercise_app/data/repositories/profile_repository.dart';
import 'package:wanna_exercise_app/data/view_models/user_view_model.dart';

// ProfileRepository Provider
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository();
});

// UserViewModel Provider
final userViewModelProvider = ChangeNotifierProvider<UserViewModel>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return UserViewModel(repository);
});
