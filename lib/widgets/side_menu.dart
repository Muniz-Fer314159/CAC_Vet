import 'package:anchieta_flutter_todo/screens/login_page.dart';
import 'package:flutter/material.dart';

class MenuLateral extends StatelessWidget {
  const MenuLateral({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF0D3B0D),
        child: Column(
          children: [
            _header(),

            _item(context, Icons.home, "Home", () {}),

            _expansivel(
              context,
              "Clientes",
              Icons.people,
              [
                "Cadastro de cliente",
                "Listagem de cliente",
              ],
            ),

            _expansivel(
              context,
              "Animais",
              Icons.pets,
              [
                "Cadastro de animais",
                "Listagem de animais",
              ],
            ),

            const Spacer(),

            _item(context, Icons.logout, "Logout", () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) =>const LoginPage()),
                (route) => false,
                );
            }),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF1FAA59),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            alignment: Alignment.center,
            child: const Text("Logo"),
          ),
          const SizedBox(width: 12),
          const Text(
            "Sistema",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }

  Widget _item(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      onTap: () {
        Navigator.pop(context); // fecha o drawer
        Future.microtask(onTap); // evita bug de navegação
      },
    );
  }

  Widget _expansivel(
    BuildContext context,
    String titulo,
    IconData icon,
    List<String> itens,
  ) {
    return ExpansionTile(
      collapsedIconColor: Colors.white,
      iconColor: Colors.white,
      leading: Icon(icon, color: Colors.white),
      title: Text(
        titulo,
        style: const TextStyle(color: Colors.white),
      ),
      children: itens.map((texto) {
        return ListTile(
          title: Text(
            texto,
            style: const TextStyle(color: Colors.white70),
          ),
          onTap: () {
            Navigator.pop(context);

            // depois liga navegação
          },
        );
      }).toList(),
    );
  }
}