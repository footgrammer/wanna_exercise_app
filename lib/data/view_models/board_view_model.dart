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
    // copyWith을 써서 filterType은 그대로 두고 boards만 업데이트
    state = state.copyWith(boards: boards);
  }

  void setFilter(String? type) {
    // filterType만 바뀌면 자동으로 filteredBoards가 바뀜
    state = state.copyWith(filterType: type);
  }
}
