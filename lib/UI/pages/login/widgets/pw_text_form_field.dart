import 'package:flutter/material.dart';

class PwTextFormField extends StatelessWidget {
  const PwTextFormField({super.key, required this.pwController});

  final TextEditingController pwController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: pwController,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintText: 'Password',
        border: WidgetStateInputBorder.resolveWith((states) {
          if (states.contains(WidgetState.focused)) {
            return OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black, width: 1),
            );
          }
          return OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey[500]!, width: 1),
          );
        }),
      ),
    );
  }
}
