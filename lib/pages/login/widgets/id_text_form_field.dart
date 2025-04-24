import 'package:flutter/material.dart';
import 'package:wanna_exercise_app/core/validator_login.dart';

class PhoneTextFormField extends StatelessWidget {
  const PhoneTextFormField({
    super.key,
    required this.phoneController,
    required this.nextFocus,
    required this.validator,
  });

  final TextEditingController phoneController;
  final FocusNode nextFocus;
  final ValidatorLogin validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: phoneController,
      textInputAction: TextInputAction.done,
      validator: validator.validatorId,
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(nextFocus);
      },
      decoration: InputDecoration(hintText: 'ID'),
    );
  }
}
