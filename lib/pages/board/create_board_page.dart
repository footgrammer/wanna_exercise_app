import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanna_exercise_app/data/repositories/board_repository.dart';
import 'package:wanna_exercise_app/pages/board/address_search_page.dart';
import 'package:wanna_exercise_app/pages/board/widgets/time_selector.dart';
import 'package:wanna_exercise_app/pages/board/widgets/type_button.dart';
import 'package:wanna_exercise_app/themes/light_theme.dart';

class CreateBoardPage extends StatefulWidget {
  final String initialType; // ⭐ 운동 종류 초기값 받기

  const CreateBoardPage({super.key, required this.initialType});

  @override
  State<CreateBoardPage> createState() => _CreateBoardPageState();
}

class _CreateBoardPageState extends State<CreateBoardPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  late String selectedType;
  DateTime? selectedDate;

  int? timeFrom;
  int? timeTo;
  String? location;
  String? locationAddress;
  int number = 5;

  String get typeText {
    if (selectedType == 'soccer') {
      return '축구';
    } else if (selectedType == 'futsal') {
      return '풋살';
    } else if (selectedType == 'running') {
      return '러닝';
    } else {
      return '농구';
    }
  }

  Color get mainColor {
    if (selectedType == 'soccer') {
      return primaryColor;
    } else if (selectedType == 'futsal') {
      return accentColor3;
    } else if (selectedType == 'running') {
      return accentColor1;
    } else {
      return accentColor2;
    }
  }

  List<String> koreanWeekdays = [
    '월요일',
    '화요일',
    '수요일',
    '목요일',
    '금요일',
    '토요일',
    '일요일',
  ];

  List<Map> timeList = [
    for (int i = 0; i < 24; i++) {'time': i, 'isChecked': false},
  ];

  @override
  void initState() {
    super.initState();
    selectedType = widget.initialType; // ⭐ 초기 선택값 설정
  }

  Future<void> pickDate() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  void changeSelectedType(String type) {
    setState(() {
      selectedType = type;
    });
  }

  void checkTime(int index) {
    setState(() {
      final isNowChecked = timeList[index]['isChecked'] as bool;
      // 현재 선택된 인덱스 목록
      final checkedIndexes = [
        for (var i = 0; i < timeList.length; i++)
          if (timeList[i]['isChecked'] == true) i,
      ];

      if (!isNowChecked) {
        // false -> true 로직
        if (checkedIndexes.isEmpty ||
            (index > 0 && timeList[index - 1]['isChecked'] == true) ||
            (index < timeList.length - 1 &&
                timeList[index + 1]['isChecked'] == true)) {
          timeList[index]['isChecked'] = true;
        } else {
          showAlertDialog('연속된 시간을 선택해 주세요!');
        }
      } else {
        // true -> false 로직
        if (checkedIndexes.length == 1) {
          // 유일한 하나라면 당연히 해제 가능
          timeList[index]['isChecked'] = false;
        } else {
          final minIdx = checkedIndexes.first;
          final maxIdx = checkedIndexes.last;
          if (index == minIdx || index == maxIdx) {
            // 블록의 양 끝이라면 해제 가능
            timeList[index]['isChecked'] = false;
          } else {
            //블록 중간 해제는 금지
            showAlertDialog('중간에 있는 시간을 선택취소할 수 없습니다.');
          }
        }
      }

      final newChecked = [
        for (var i = 0; i < timeList.length; i++)
          if (timeList[i]['isChecked'] == true) i,
      ];
      if (newChecked.isNotEmpty) {
        // 최솟값 = 시작, 최댓값 = 끝
        timeFrom = newChecked.first;
        timeTo = newChecked.last + 1;
      } else {
        timeFrom = null;
        timeTo = null;
      }
    });
  }

  Future<dynamic> showAlertDialog(String text) {
    return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('확인'),
          content: Text(text),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(ctx).pop(true), // true 리턴
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          '게시물 작성',
          style: TextStyle(
            color: textColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$typeText Let's go",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TypeButton(
                  type: 'soccer',
                  selectedType: selectedType,
                  changeSelectedType: changeSelectedType,
                ),
                TypeButton(
                  type: 'futsal',
                  selectedType: selectedType,
                  changeSelectedType: changeSelectedType,
                ),
                TypeButton(
                  type: 'running',
                  selectedType: selectedType,
                  changeSelectedType: changeSelectedType,
                ),
                TypeButton(
                  type: 'basketball',
                  selectedType: selectedType,
                  changeSelectedType: changeSelectedType,
                ),
              ],
            ),
            SizedBox(height: 16),
            Divider(color: strokeColor, thickness: 1),
            SizedBox(height: 16),

            Expanded(
              child: ListView(
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent, // 빈 영역도 터치 가능
                    onTap: pickDate,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '날짜',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: mainColor,
                              ),
                            ),
                            Text(
                              selectedDate == null
                                  ? '날짜를 선택해 주세요.'
                                  : '${selectedDate!.year}년 ${selectedDate!.month}월 ${selectedDate!.day}일 ${koreanWeekdays[selectedDate!.weekday - 1]}',
                              style: TextStyle(fontSize: 18, color: textColor),
                            ),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios, color: mainColor),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Divider(color: strokeColor, thickness: 1),
                  SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '시간',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                        ),
                      ),
                      Text(
                        timeFrom == null && timeTo == null
                            ? '시간을 선택해 주세요.'
                            : '${timeFrom.toString()}:00 ~ ${timeTo.toString()}:00',
                        style: TextStyle(fontSize: 18, color: textColor),
                      ),
                      SizedBox(height: 16),
                      TimeSelector(
                        selectedType: selectedType,
                        timeList: timeList,
                        checkTime: checkTime,
                      ),

                      SizedBox(height: 16),
                      Divider(color: strokeColor, thickness: 1),
                      SizedBox(height: 16),

                      GestureDetector(
                        behavior: HitTestBehavior.translucent, // 빈 영역도 터치 가능
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddressSearchPage(),
                            ),
                          );

                          if (result != null) {
                            setState(() {
                              location = result['location'] ?? '';
                              locationAddress = result['locationAddress'] ?? '';
                            });
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '장소',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: mainColor,
                                  ),
                                ),
                                Text(
                                  location == null ? '장소를 선택해 주세요.' : location!,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                locationAddress != null
                                    ? Text(
                                      locationAddress!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: textColor,
                                      ),
                                    )
                                    : SizedBox(),
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios, color: mainColor),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Divider(color: strokeColor, thickness: 1),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '모집인원',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: mainColor,
                            ),
                          ),
                          Text(
                            '모집인원 : ${number.toString()}명',
                            style: TextStyle(
                              fontSize: 18,
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                number--;
                              });
                            },
                            icon: Icon(CupertinoIcons.minus_circled, size: 28),
                          ),
                          SizedBox(width: 8),
                          Text(
                            number.toString(),
                            style: TextStyle(fontSize: 32),
                          ),
                          SizedBox(width: 8),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                number++;
                              });
                            },
                            icon: Icon(Icons.add_circle, size: 28),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Divider(color: strokeColor, thickness: 1),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: '제목',
                      labelStyle: TextStyle(
                        color: mainColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: mainColor, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: contentController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: '내용',
                      labelStyle: TextStyle(
                        color: mainColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: mainColor, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 16),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (titleController.text.isEmpty ||
                      contentController.text.isEmpty ||
                      location == null ||
                      locationAddress == null ||
                      selectedDate == null ||
                      timeFrom == null ||
                      timeTo == null) {
                    showAlertDialog('모든 항목을 입력해 주세요');
                  } else {
                    BoardRepository boardRepo = BoardRepository();

                    bool result = await boardRepo.createBoard(
                      type: selectedType,
                      title: titleController.text,
                      content: contentController.text,
                      date: selectedDate!,
                      timeFrom: timeFrom!,
                      timeTo: timeTo!,
                      location: location!,
                      locationAddress: locationAddress!,
                      number: number,
                    );
                    if (result) {
                      await showAlertDialog('성공적으로 작성되었습니다.');
                    } else {
                      await showAlertDialog('작성에 실패했습니다.');
                    }
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('작성 완료'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
