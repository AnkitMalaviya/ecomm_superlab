import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;
  final onChanged;

  const SearchBarWidget({
    Key? key,
    required this.controller,
    required this.onSearch,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
              ),
              onChanged: onChanged,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: onSearch,
          ),
        ],
      ),
    );
  }
}
