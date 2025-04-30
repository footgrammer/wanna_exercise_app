import 'package:flutter/material.dart';
import 'package:wanna_exercise_app/themes/light_theme.dart';

class TimeSelector extends StatelessWidget {
  String? selectedType;
  List<Map> timeList;
  ValueChanged<int> checkTime;
  TimeSelector({
    required this.selectedType,
    required this.timeList,
    required this.checkTime,
  });

  Color get mainColor {
    if (selectedType == 'soccer') {
      return primaryColor;
    } else if (selectedType == 'basketball') {
      return accentColor2;
    } else if (selectedType == 'running') {
      return accentColor1;
    } else if (selectedType == 'futsal') {
      return accentColor3;
    } else {
      return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Row(children: [for (int i = 0; i < 24; i++) getTimeBox(i)]),
    );
  }

  GestureDetector getTimeBox(int index) => GestureDetector(
    onTap: () {
      checkTime(index);
    },
    child: Container(
      height: 60,
      width: 60,
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: timeList[index]['isChecked'] == true ? mainColor : Colors.white,
        border: Border.all(color: mainColor, width: 2),
      ),
      child: Center(
        child: Text(
          timeList[index]['time'].toString(),
          style: TextStyle(
            color:
                timeList[index]['isChecked'] == true ? Colors.white : textColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    ),
  );
}
