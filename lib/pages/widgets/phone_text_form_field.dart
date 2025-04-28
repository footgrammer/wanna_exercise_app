import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneTextFormField extends StatelessWidget {
  const PhoneTextFormField({
    super.key,
    required this.phoneController,
    required this.nextFocus,
    required this.validator,
    required this.validateMode,
    required this.onSubmittedFunction,
  });

  final TextEditingController phoneController;
  final FocusNode nextFocus;
  final FormFieldValidator<String> validator;
  final AutovalidateMode validateMode;
  final FutureOr<void> Function()
  onSubmittedFunction; // Future<void>, void 함수 사용 가능

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: phoneController,
      textInputAction: TextInputAction.done,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: validator,
      autovalidateMode: validateMode,
      onFieldSubmitted: (value) {
        onSubmittedFunction();
      },
      decoration: InputDecoration(hintText: '휴대폰 번호'),
    );
  }
}
