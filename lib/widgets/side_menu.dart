import 'package:flutter/material.dart';

// IMPORTANTE:
// depois você vai importar suas páginas aqui
// import '../pages/home_page.dart';

class MenuLateral extends StatelessWidget {
  const MenuLateral({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: const Color(0xFF003B00),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),

          Center(
            child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
              alignment: Alignment.center,
              child: const Text("Logo"),
            ),
          ),

          const SizedBox(height: 30),

          // ITENS DO MENU
          _menuItem(
            context,
            "Home",
            () {
              // Exemplo de navegação
              // Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
            },
          ),

          const SizedBox(height: 10),

          _sectionTitle("Clientes"),

          _menuItem(
            context,
            "Cadastro de cliente",
            () {},
          ),

          _menuItem(
            context,
            "Listagem de cliente",
            () {},
          ),

          const SizedBox(height: 10),

          _sectionTitle("Animais"),

          _menuItem(
            context,
            "Cadastro de animais",
            () {},
          ),

          _menuItem(
            context,
            "Listagem de animais",
            () {},
          ),

          const Spacer(),

          _menuItem(
            context,
            "Logout",
            () {
              Navigator.pop(context);
            },
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _menuItem(
    BuildContext context,
    String title,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}