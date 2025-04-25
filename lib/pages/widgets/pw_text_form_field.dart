import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wanna_exercise_app/core/validator_login.dart';

class PwTextFormField extends StatelessWidget {
  const PwTextFormField({
    super.key,
    required this.pwController,
    required this.focus,
    required this.nextFocus,
    required this.validator,
    required this.onSubmittedFunction,
  });

  final TextEditingController pwController;
  final FocusNode focus;
  final FocusNode? nextFocus;
  final ValidatorLogin validator;
  final FutureOr<void> Function()
  onSubmittedFunction; // Future<void>, void 함수 사용 가능

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: pwController,
      focusNode: focus,
      textInputAction: TextInputAction.done,
      validator: validator.validatorPw,
      onFieldSubmitted: (value) {
        onSubmittedFunction();
      },
      decoration: InputDecoration(hintText: 'Password'),
    );
  }
}
