import 'package:flutter/material.dart';

class BuildActivityButton extends StatelessWidget {
  final String label;
  final Color textColor;
  final Color bgColor;
  final IconData icon;
  final VoidCallback? onTap;

  const BuildActivityButton({
    Key? key,
    required this.label,
    required this.textColor,
    required this.bgColor,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



