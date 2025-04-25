import 'package:flutter/material.dart';

class EventCardWidget extends StatelessWidget {
  final String title;
  final String time;
  const EventCardWidget({super.key,required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text(title, style: TextStyle(fontSize: 16)),
            Text('title', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            // Text(time),
            Text('time'),
          ],
        ),
      ),
    );
  }
}
