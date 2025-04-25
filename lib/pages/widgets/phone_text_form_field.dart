import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wanna_exercise_app/core/validator_login.dart';

class PhoneTextFormField extends StatelessWidget {
  const PhoneTextFormField({
    super.key,
    required this.phoneController,
    required this.nextFocus,
    required this.validator,
    required this.onSubmittedFunction,
  });

  final TextEditingController phoneController;
  final FocusNode nextFocus;
  final ValidatorLogin validator;
  final FutureOr<void> Function()
  onSubmittedFunction; // Future<void>, void 함수 사용 가능

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: phoneController,
      textInputAction: TextInputAction.done,
      validator: validator.validatorId,
      onFieldSubmitted: (value) {
        onSubmittedFunction();
      },
      decoration: InputDecoration(hintText: 'ID'),
    );
  }
}
