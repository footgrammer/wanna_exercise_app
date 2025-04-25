import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wanna_exercise_app/core/validator_login.dart';

class NicknameTextFormField extends StatelessWidget {
  const NicknameTextFormField({
    super.key,
    required this.nicknameController,
    required this.focus,
    required this.validator,
    required this.onSubmittedFunction,
  });

  final TextEditingController nicknameController;
  final FocusNode focus;
  final ValidatorLogin validator;
  final FutureOr<void> Function()
  onSubmittedFunction; // Future<void>, void 함수 사용 가능

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nicknameController,
      focusNode: focus,
      textInputAction: TextInputAction.done,
      validator: validator.validatorPw,
      onFieldSubmitted: (value) {
        onSubmittedFunction();
      },
      decoration: InputDecoration(hintText: '닉네임'),
    );
  }
}
