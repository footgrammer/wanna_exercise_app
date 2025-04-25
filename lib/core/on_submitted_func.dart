import 'package:flutter/material.dart';

class onSubmittedFunc {
  static void moveFocusToNext(BuildContext context, FocusNode nextFocus) {
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
