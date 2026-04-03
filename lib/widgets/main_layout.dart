import 'package:flutter/material.dart';
import 'side_menu.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sistema"),
      ),
      drawer: const MenuLateral(), // 👈 aqui está o hamburguer
      body: Container(
        color: Colors.grey[300],
        child: SafeArea(
          child: child,
        ),
      ),
    );
  }
}