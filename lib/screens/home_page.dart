import 'package:flutter/material.dart';
import '../widgets/main_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Container(
        color: const Color(0xFF0D3B0D), // verde escuro
        child: Column(
          children: [
            _topo(),
            const SizedBox(height: 30),
            Expanded(child: _menuPrincipal()),
          ],
        ),
      ),
    );
  }

  // 🔹 TOPO ESTILIZADO
  Widget _topo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(
        color: Color(0xFF1FAA59), // verde mais claro
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 65,
            height: 65,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            alignment: Alignment.center,
            child: const Text(
              "Logo",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 15),
          const Text(
            "Slogan do Sistema",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _menuPrincipal() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _cardExpansivel(
            titulo: "Clientes",
            icone: Icons.people,
            itens: ["Cadastro de cliente", "Listagem de cliente"],
          ),
          const SizedBox(height: 20),
          _cardExpansivel(
            titulo: "Animais",
            icone: Icons.pets,
            itens: ["Cadastro de animais", "Listagem de animais"],
          ),
        ],
      ),
    );
  }

  Widget _cardExpansivel({
    required String titulo,
    required IconData icone,
    required List<String> itens,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF145214),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ExpansionTile(
        collapsedIconColor: Colors.white,
        iconColor: Colors.white,
        leading: Icon(icone, color: Colors.white),
        title: Text(
          titulo,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: itens.map((item) => _subItem(item)).toList(),
      ),
    );
  }

  // 🔹 SUBITEM
  Widget _subItem(String texto) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(texto),
      ),
    );
  }
}