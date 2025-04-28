import 'package:flutter/material.dart';
import 'package:wanna_exercise_app/themes/light_theme.dart';

// '취소' 클릭 시 false, '확인' 클릭 시 true를 반환하여 사용하는 팝업 위젯

Future<bool?> showConfirmPopUp(
  BuildContext context, {
  required String title,
  required String? content,
}) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Container(
          width: double.infinity, // 좌우 insetPadding 고려
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              if (content != null) ...[
                SizedBox(height: 20),
                Text(
                  content,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ],
              SizedBox(height: 30),
              Row(
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 50,

                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context, false),
                        child: Text(
                          '취소',
                          style: TextStyle(fontSize: 16, color: negativeColor),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context, true),
                        child: Text(
                          '확인',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
