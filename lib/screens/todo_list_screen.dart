import 'package:flutter/material.dart';
import 'chat_screen.dart';
import '../widgets/todo_tile.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("TODOS", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu),
            onSelected: (val) => val == 'chat' ? Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen())) : null,
            itemBuilder: (ctx) => [
              const PopupMenuItem(value: 'sync', child: Text("Forçar Sincronismo")),
              const PopupMenuItem(value: 'chat', child: Text("Suporte (Chat)")),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          TodoTile(label: "Tarefa 1"),
          TodoTile(label: "Tarefa 2"),
          TodoTile(label: "Tarefa 3"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF1A4D6B),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}