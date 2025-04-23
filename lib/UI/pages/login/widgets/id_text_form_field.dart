import 'package:flutter/material.dart';

class IdTextFormField extends StatefulWidget {
  const IdTextFormField({super.key, required this.idController});

  final TextEditingController idController;

  @override
  State<IdTextFormField> createState() => _IdTextFormFieldState();
}

class _IdTextFormFieldState extends State<IdTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.idController,
      textInputAction: TextInputAction.done,
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
