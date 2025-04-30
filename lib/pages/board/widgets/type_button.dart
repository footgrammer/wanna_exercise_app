import 'package:flutter/material.dart';
import 'package:wanna_exercise_app/themes/light_theme.dart';

class TypeButton extends StatelessWidget {
  String type;
  String selectedType;
  ValueChanged<String> changeSelectedType;

  TypeButton({
    required this.type,
    required this.selectedType,
    required this.changeSelectedType,
  });

  @override
  Widget build(BuildContext context) {
    String text = '축구';
    String symbol = '⚽️';
    Color borderColor = primaryColor;
    Color buttonBackgroundColor = Colors.white;
    if (selectedType == 'soccer') {
      buttonBackgroundColor = primaryColor;
    } else if (selectedType == 'futsal') {
      buttonBackgroundColor = accentColor3;
    } else if (selectedType == 'basketball') {
      buttonBackgroundColor = accentColor2;
    } else if (selectedType == 'running') {
      buttonBackgroundColor = accentColor1;
    }

    if (type == 'soccer') {
      text = '축구';
      symbol = '⚽️';
      borderColor = primaryColor;
    } else if (type == 'futsal') {
      text = '풋살';
      symbol = '⚽️';
      borderColor = accentColor3;
    } else if (type == 'basketball') {
      text = '농구';
      symbol = '🏀';
      borderColor = accentColor2;
    } else if (type == 'running') {
      text = '러닝';
      symbol = '🏃‍♂️';
      borderColor = accentColor1;
    }
    return GestureDetector(
      onTap: () {
        changeSelectedType(type);
      },
      child: SizedBox(
        width: 84,
        height: 84,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: type == selectedType ? buttonBackgroundColor : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 2.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(symbol, style: TextStyle(fontSize: 24)),
              const SizedBox(height: 4),
              Text(
                text,
                style: TextStyle(
                  color: type == selectedType ? Colors.white : textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
