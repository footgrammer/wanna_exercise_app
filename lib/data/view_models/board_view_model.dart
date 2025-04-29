import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanna_exercise_app/data/models/board.dart';
import 'package:wanna_exercise_app/data/repositories/board_repository.dart';

class BoardState {
  List<Board>? boards;
  BoardState(this.boards);
}

class BoardViewModel extends Notifier<BoardState> {
  @override
  build() {
    return BoardState(null);
  }

  void getBoards() async {
    BoardRepository boardRepository = BoardRepository();
    List<Board>? boards = await boardRepository.getBoardsData();
    state = BoardState(boards);
    print('boards : $boards');
  }
}
