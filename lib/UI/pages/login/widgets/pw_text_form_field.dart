import 'package:flutter/material.dart';
import 'package:wanna_exercise_app/core/validator_login.dart';

class PwTextFormField extends StatelessWidget {
  const PwTextFormField({
    super.key,
    required this.pwController,
    required this.focus,
    required this.validator,
  });

  final TextEditingController pwController;
  final FocusNode focus;
  final ValidatorLogin validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: pwController,
      focusNode: focus,
      textInputAction: TextInputAction.done,
      validator: validator.validatorPw,
      onFieldSubmitted: (value) {
        // TODO: login 연결
        print('로그인 시도');
      },
      decoration: InputDecoration(hintText: 'Password'),
    );
  }
}
