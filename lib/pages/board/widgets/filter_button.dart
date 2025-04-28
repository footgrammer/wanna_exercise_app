import 'package:flutter/material.dart';
import 'package:wanna_exercise_app/themes/light_theme.dart';

class FilterButton extends StatelessWidget {
  final String text;
  final void Function()? filterFunction;

  FilterButton({required this.text, required this.filterFunction});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = primaryColor;
    if (text == '⚽️ 축구') {
      backgroundColor = primaryColor;
    } else if (text == '⚽️ 풋살') {
      backgroundColor = accentColor3;
    } else if (text == '🏀 농구') {
      backgroundColor = accentColor2;
    } else if (text == '🏃‍♂️ 러닝') {
      backgroundColor = accentColor1;
    }

    return GestureDetector(
      onTap: filterFunction,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),

        child: SizedBox(
          width: 80,
          height: 48,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
