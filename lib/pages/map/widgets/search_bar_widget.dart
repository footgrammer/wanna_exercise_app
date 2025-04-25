import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final Function(String) onSearch;

  const SearchBarWidget({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Row(
        children: [
          const Icon(Icons.arrow_back),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: onSearch,
              decoration: const InputDecoration(
                hintText: '어떤 장소를 찾으세요?',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              onSearch(controller.text);
            },
            icon: const Icon(Icons.my_location),
          ),
        ],
      ),
    );
  }
}