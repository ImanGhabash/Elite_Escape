
import 'package:flutter/material.dart';
class MySearchBar extends StatelessWidget {
  const MySearchBar({
    super.key,
    this.onFilterPressed,
    required this.onSearch,
  });

  final VoidCallback? onFilterPressed;
  final ValueChanged<String> onSearch;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Container(
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              onSearch(controller.text.trim());
            },
            child: const Icon(
              Icons.search,
              color: Colors.grey,
              size: 30,
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            flex: 4,
            child: TextField(
              controller: controller,
              onSubmitted: (value) {
                onSearch(value.trim());
              },
              decoration: const InputDecoration(
                hintText: "Search...",
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            height: 25,
            width: 1.5,
            color: Colors.grey,
          ),
          IconButton(
            onPressed: onFilterPressed,
            icon: const Icon(
              Icons.tune,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}