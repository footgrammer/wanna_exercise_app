import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanna_exercise_app/data/models/board.dart';
import 'package:wanna_exercise_app/data/repositories/board_repository.dart';

class BoardState {
  List<Board>? boards; //게시판글
  final String? filterType; //운동종류 필터
  BoardState({this.boards = const [], this.filterType});

  List<Board>? get filteredBoards {
    if (filterType == null) {
      return boards;
    } else {
      return boards!.where((board) => board.type == filterType).toList();
    }
  }

  BoardState copyWith({List<Board>? boards, String? filterType}) {
    return BoardState(boards: boards ?? this.boards, filterType: filterType);
  }
}

class BoardViewModel extends Notifier<BoardState> {
  @override
  build() {
    return BoardState(filterType: null);
  }

  void getBoards() async {
    BoardRepository boardRepository = BoardRepository();
    List<Board>? boards = await boardRepository.getBoardsData();
    state = state.copyWith(boards: boards);
  }

  void setFilter(String? type) {
    state = state.copyWith(filterType: type);
  }
}
