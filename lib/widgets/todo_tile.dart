import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  final String label;
  const TodoTile({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.check_box_outline_blank, color: Colors.white),
      title: Text(label, style: const TextStyle(color: Colors.orange, fontSize: 18)),
    );
  }
}