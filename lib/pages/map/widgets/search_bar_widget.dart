import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final Function(String) onSearch;
  final VoidCallback onCurrentLocationPressed;

  const SearchBarWidget({
    super.key,
    required this.onSearch,
    required this.onCurrentLocationPressed,
  });

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
            onPressed: onCurrentLocationPressed,
            icon: const Icon(Icons.my_location),
          ),
        ],
      ),
    );
  }
}
