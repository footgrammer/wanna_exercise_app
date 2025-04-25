import 'package:flutter/material.dart';

class OnSubmittedFunc {
  static void moveFocusToNext(BuildContext context, FocusNode nextFocus) {
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
