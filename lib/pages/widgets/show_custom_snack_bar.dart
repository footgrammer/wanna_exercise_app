import 'package:flutter/material.dart';

// 스낵바 텍스트(내용), 바텀 패딩을 받아 스낵바를 띄워주는 위젯
void showCustomSnackBar(
  BuildContext context, {
  required String text,
  required double bottomPadding,
}) {
  final snackBar = SnackBar(
    content: Text(text, style: TextStyle(color: Colors.white)),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.fromLTRB(20, 0, 20, bottomPadding),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.black.withValues(alpha: 0.7),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
