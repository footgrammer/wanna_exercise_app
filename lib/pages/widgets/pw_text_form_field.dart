import 'dart:async';

import 'package:flutter/material.dart';

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
  final FormFieldValidator<String> validator;
  final FutureOr<void> Function()
  onSubmittedFunction; // Future<void>, void 함수 사용 가능

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: pwController,
      focusNode: focus,
      textInputAction: TextInputAction.done,
      validator: validator,
      maxLength: 20,
      obscureText: true,
      onFieldSubmitted: (value) {
        onSubmittedFunction();
      },
      decoration: InputDecoration(hintText: '비밀번호'),
    );
  }
}
