import 'package:flutter/material.dart';
import 'package:wanna_exercise_app/data/models/board.dart';
import 'package:wanna_exercise_app/pages/board/board_detail_page.dart';
import 'package:wanna_exercise_app/themes/light_theme.dart';

class BoardItem extends StatelessWidget {
  Board board;
  BoardItem(this.board);
  @override
  Widget build(BuildContext context) {
    Color boardItemColor = primaryColor;
    if (board.type == 'soccer') {
      boardItemColor = primaryColor;
    } else if (board.type == 'futsal') {
      boardItemColor = accentColor3;
    } else if (board.type == 'basketball') {
      boardItemColor = accentColor2;
    } else if (board.type == 'running') {
      boardItemColor = accentColor1;
    }

    int participantsNumber = 7;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BoardDetailPage(board);
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),

        child: SizedBox(
          width: double.infinity,
          height: 80,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: boardItemColor, width: 2.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (board.type == 'soccer') ...[
                      Text('⚽️', style: TextStyle(fontSize: 28)),
                      Text(
                        '축구',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: boardItemColor,
                        ),
                      ),
                    ] else if (board.type == 'futsal') ...[
                      Text('⚽️', style: TextStyle(fontSize: 28)),
                      Text(
                        '풋살',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: boardItemColor,
                        ),
                      ),
                    ] else if (board.type == 'basketball') ...[
                      Text('🏀', style: TextStyle(fontSize: 28)),
                      Text(
                        '농구',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: boardItemColor,
                        ),
                      ),
                    ] else if (board.type == 'running') ...[
                      Text('🏃‍♂️', style: TextStyle(fontSize: 28)),
                      Text(
                        '러닝',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: boardItemColor,
                        ),
                      ),
                    ],
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${board.date.month.toString()}월 ${board.date.day}일 ${board.timeFrom}:00 - ${board.timeTo}:00',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: boardItemColor,
                      ),
                    ),
                    Text(
                      board.location,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$participantsNumber / ${board.number}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // 참가가능인원이 4명보다 적으면
                    if ((board.number - participantsNumber) < 4)
                      Text(
                        '마감입박',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: negativeColor,
                        ),
                      )
                    else if ((board.number - participantsNumber) >= 4)
                      Text(
                        '모집 중',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
