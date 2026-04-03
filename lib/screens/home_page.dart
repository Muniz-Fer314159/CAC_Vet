import 'package:flutter/material.dart';
import '../widgets/main_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Container(
        width: double.infinity,
        color: const Color(0xFF00A000), // verde claro do layout
        child: Column(
          children: [
            const SizedBox(height: 20),

            _topo(),

            const SizedBox(height: 30),

            // MENU PRINCIPAL
            _menuPrincipal(),

            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _topo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
            alignment: Alignment.center,
            child: const Text("Logo"),
          ),

          const SizedBox(width: 20),

          const Text(
            "Slogan",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 MENU PRINCIPAL (Clientes / Animais)
  Widget _menuPrincipal() {
    return Column(
      children: [
        ExpansionTile(
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          leading: const CircleAvatar(
            radius: 8,
            backgroundColor: Colors.grey,
          ),
          title: _botaoPrincipal("Clientes"),
          children: [
            _subItem("Cadastro de cliente"),
            _subItem("Listagem de cliente"),
          ],
        ),

        // ANIMAIS
        ExpansionTile(
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          leading: const CircleAvatar(
            radius: 8,
            backgroundColor: Colors.grey,
          ),
          title: _botaoPrincipal("Animais"),
          children: [
            _subItem("Cadastro de animais"),
            _subItem("Listagem de animais"),
          ],
        ),
      ],
    );
  }

  Widget _botaoPrincipal(String texto) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        texto,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _subItem(String texto) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(texto),
      ),
    );
  }
}