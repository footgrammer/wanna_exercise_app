import 'package:flutter/material.dart';

class IdTextFormField extends StatelessWidget {
  const IdTextFormField({
    super.key,
    required this.idController,
    required this.nextFocus,
  });

  final TextEditingController idController;
  final FocusNode nextFocus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: idController,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(nextFocus);
      },
      decoration: InputDecoration(
        hintText: 'ID',
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
