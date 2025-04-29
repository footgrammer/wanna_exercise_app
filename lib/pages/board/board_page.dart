import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanna_exercise_app/data/models/board.dart';
import 'package:wanna_exercise_app/data/providers/board_provider.dart';
import 'package:wanna_exercise_app/data/view_models/board_view_model.dart';
import 'package:wanna_exercise_app/pages/board/widgets/board_item.dart';
import 'package:wanna_exercise_app/pages/board/widgets/filter_button.dart';
import 'package:wanna_exercise_app/themes/light_theme.dart';

class BoardPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<BoardPage> createState() {
    return _BoardPageState();
  }
}

class _BoardPageState extends ConsumerState<BoardPage> {
  @override
  void initState() {
    super.initState();
    // 첫 프레임 렌더링 직후에 한 번만 실행
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(boardViewModelProvider.notifier).getBoards();
    });
  }

  @override
  Widget build(BuildContext context) {
    final boardState = ref.watch(boardViewModelProvider);
    return Scaffold(
      appBar: AppBar(),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Column(
          children: [
            getFilterButtonList(),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: boardState.boards?.length ?? 0,
                itemBuilder: (context, index) {
                  final List<Board> boards = boardState.boards!;
                  return BoardItem(boards[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row getFilterButtonList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FilterButton(
          text: '⚽️ 축구',
          filterFunction: () {
            print('축구 필터 function');
          },
        ),
        SizedBox(width: 8),
        FilterButton(
          text: '⚽️ 풋살',
          filterFunction: () {
            print('풋살 필터 function');
          },
        ),
        SizedBox(width: 8),
        FilterButton(
          text: '🏃‍♂️ 러닝',
          filterFunction: () {
            print('러닝 필터 function');
          },
        ),
        SizedBox(width: 8),
        FilterButton(
          text: '🏀 농구',
          filterFunction: () {
            print('농구 필터 function');
          },
        ),
        SizedBox(width: 8),
      ],
    );
  }
}
