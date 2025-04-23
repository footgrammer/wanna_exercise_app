import 'package:flutter/material.dart';
import 'package:wanna_exercise_app/UI/pages/map/widgets/event_card_widget.dart';
import 'package:wanna_exercise_app/UI/pages/map/widgets/search_bar_widget.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Placeholder(), //여기에 api넣을거임
          ),
          Positioned(top: 50, left: 16, right: 16, child: SearchBarWidget()),
          Positioned(bottom: 16, left: 0, right: 0, child: EventCardWidget()),
        ],
      ),
    );
  }
}
