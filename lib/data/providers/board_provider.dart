import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanna_exercise_app/data/view_models/board_view_model.dart';

final boardViewModelProvider = NotifierProvider<BoardViewModel, BoardState>(() {
  return BoardViewModel();
});
