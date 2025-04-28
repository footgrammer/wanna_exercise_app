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
  final List<Board> boards = [
    Board(
      type: 'soccer',
      title: '친목 축구 모임',
      content: '신규 회원 환영! 편하게 오세요.',
      date: DateTime.parse('2025-05-03'),
      timeFrom: 10,
      timeTo: 12,
      location: '월드컵공원 축구장',
      locationAddress: '서울특별시 마포구 성산동 682-3',
      number: 14,
    ),
    Board(
      type: 'futsal',
      title: '주말 풋살 데이',
      content: '풋살화만 챙겨오세요!',
      date: DateTime.parse('2025-05-10'),
      timeFrom: 18,
      timeTo: 20,
      location: '강남실내풋살센터',
      locationAddress: '서울특별시 강남구 역삼동 712-14',
      number: 8,
    ),
    Board(
      type: 'basketball',
      title: '농구 스크리밍',
      content: '3대3 농구 즐기실 분 모집합니다.',
      date: DateTime.parse('2025-05-15'),
      timeFrom: 15,
      timeTo: 17,
      location: '잠실실내체육관',
      locationAddress: '서울특별시 송파구 올림픽로 25',
      number: 6,
    ),
    Board(
      type: 'running',
      title: '한강 러닝 모임',
      content: '한강변 10km 러닝 같이 하실 분!',
      date: DateTime.parse('2025-05-20'),
      timeFrom: 7,
      timeTo: 9,
      location: '여의도 한강공원',
      locationAddress: '서울특별시 영등포구 여의동로 330',
      number: 20,
    ),
    Board(
      type: 'soccer',
      title: '저녁 축구 레슨',
      content: '초보자도 환영하는 축구 레슨.',
      date: DateTime.parse('2025-05-25'),
      timeFrom: 19,
      timeTo: 21,
      location: '상암월드컵경기장',
      locationAddress: '서울특별시 마포구 성산동 255-10',
      number: 12,
    ),
    Board(
      type: 'futsal',
      title: '친선 풋살 대회',
      content: '소규모 풋살 대회 참가자 모집.',
      date: DateTime.parse('2025-06-01'),
      timeFrom: 14,
      timeTo: 17,
      location: '수원 실내 풋살장',
      locationAddress: '경기도 수원시 팔달구 고등동 987-5',
      number: 10,
    ),
    Board(
      type: 'basketball',
      title: '아침 농구클럽',
      content: '1시간 슛 훈련 및 경기 진행.',
      date: DateTime.parse('2025-06-05'),
      timeFrom: 8,
      timeTo: 9,
      location: '건대입구 농구장',
      locationAddress: '서울특별시 광진구 화양동 8-11',
      number: 10,
    ),
    Board(
      type: 'running',
      title: '산책 겸 러닝',
      content: '초급 러닝 및 산책 코스.',
      date: DateTime.parse('2025-06-10'),
      timeFrom: 10,
      timeTo: 12,
      location: '북한산 둘레길',
      locationAddress: '서울특별시 강북구 우이동 산1-1',
      number: 15,
    ),
    Board(
      type: 'soccer',
      title: '풋사커 혼합 경기',
      content: '축구와 풋살의 중간 형태 경기.',
      date: DateTime.parse('2025-06-15'),
      timeFrom: 16,
      timeTo: 18,
      location: '인천 축구센터',
      locationAddress: '인천광역시 서구 석남동 1234',
      number: 16,
    ),
    Board(
      type: 'basketball',
      title: '농구 3점슛 챌린지',
      content: '3점슛 고수 모여랏!',
      date: DateTime.parse('2025-06-20'),
      timeFrom: 17,
      timeTo: 19,
      location: '천안유량실내체육관',
      locationAddress: '충청남도 천안시 동남구 유량동 456-2',
      number: 8,
    ),
  ];
  // List<DropdownMenuItem> locations = [
  //   DropdownMenuItem(value: '서울시 용산구', child: Text('서울시 용산구')),
  //   DropdownMenuItem(value: '천안시 동남구', child: Text('천안시 동남구')),
  //   DropdownMenuItem(value: '천안시 서북구', child: Text('천안시 서북구')),
  // ];
  // String _locationValue = '서울시 용산구';
  // List<String> date = ['서울시 용산구', '천안시 동남구', '천안시 서북구'];

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
      // 장소 및 날짜 필터링
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       DropdownButton(
      //         value: _locationValue,
      //         items: locations,
      //         onChanged: (value) {
      //           setState(() {
      //             _locationValue = value;
      //           });
      //         },
      //       ),
      //       DropdownButton(
      //         value: _locationValue,
      //         items: locations,
      //         onChanged: (value) {
      //           setState(() {
      //             _locationValue = value;
      //           });
      //         },
      //       ),
      //     ],
      //   ),
      // ),
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
