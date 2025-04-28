import 'package:flutter/material.dart';
import 'package:wanna_exercise_app/data/models/board.dart';
import 'package:wanna_exercise_app/themes/light_theme.dart';

class BoardDetailPage extends StatelessWidget {
  Board board;
  BoardDetailPage(this.board);
  @override
  Widget build(BuildContext context) {
    const List<String> koreanWeekdays = [
      '일요일',
      '월요일',
      '화요일',
      '수요일',
      '목요일',
      '금요일',
      '토요일',
    ];

    int participantsNumber = 7;
    Color mainColor;
    if (board.type == 'soccer') {
      mainColor = primaryColor;
    } else if (board.type == 'futsal') {
      mainColor = accentColor3;
    } else if (board.type == 'basketball') {
      mainColor = accentColor2;
    } else if (board.type == 'running') {
      mainColor = accentColor1;
    } else {
      mainColor = primaryColor;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '게시판 상세 페이지',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 게시글 제목 가져오기
          getBoardTitle(),
          // 게시글 날짜 가져오기
          getBoardDate(mainColor, koreanWeekdays),
          // 게시글 장소
          getBoardLocation(mainColor),
          // 참가인원
          getBoardParticipants(mainColor, participantsNumber),
          // 모집글 내용
          getBoardContent(mainColor),
          // 참가버튼
          getBoardButton(),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  Container getBoardButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: participateExercise,
          child: Text('참가하기'),
        ),
      ),
    );
  }

  Expanded getBoardContent(Color mainColor) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 32, right: 32, top: 16, bottom: 16),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: mainColor, width: 2.0),
            borderRadius: BorderRadius.circular(12),
          ),
          width: double.infinity,
          child: Text(board.content, style: TextStyle(fontSize: 14)),
        ),
      ),
    );
  }

  Container getBoardParticipants(Color mainColor, int participantsNumber) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: strokeColor, width: 2.0)),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: mainColor, width: 2.0),
          borderRadius: BorderRadius.circular(12),
        ),
        width: double.infinity,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: mainColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.group, size: 48, color: mainColor),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if ((board.number - participantsNumber) < 4)
                  Text(
                    '마감임박',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: negativeColor,
                    ),
                  )
                else
                  Text(
                    '모집 중',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                Text(
                  '$participantsNumber / ${board.number}',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container getBoardLocation(Color mainColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: strokeColor, width: 2.0)),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: mainColor, width: 2.0),
          borderRadius: BorderRadius.circular(12),
        ),
        width: double.infinity,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: mainColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.location_on, size: 48, color: mainColor),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${board.location}일',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${board.locationAddress}',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container getBoardDate(Color mainColor, List<String> koreanWeekdays) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: strokeColor, width: 2.0)),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: mainColor, width: 2.0),
          borderRadius: BorderRadius.circular(12),
        ),
        width: double.infinity,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: mainColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.calendar_month, size: 48, color: mainColor),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${board.date.year}년 ${board.date.month}월 ${board.date.day}일',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${koreanWeekdays[board.date.weekday - 1]}, ${board.timeFrom}:00 - ${board.timeTo}:00',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container getBoardTitle() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: strokeColor, width: 2.0)),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          board.title,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void participateExercise() {
    print('참가합니다.');
  }
}
