import 'package:flutter/material.dart';

class BuildActivityButton extends StatelessWidget{
  final String label;
  final Color textColor;
  final Color bgColor;
  // final Widget nextPage;

  const BuildActivityButton({
    required this.label,
    required this.textColor,
    required this.bgColor,
    // required this.nextPage,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (_) => nextPage),
        // );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        width: double.infinity,
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
          ),
        ),
      ),
    );
  }
}


