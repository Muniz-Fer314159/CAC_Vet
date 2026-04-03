import 'package:flutter/material.dart';

class MenuLateral extends StatelessWidget {
  const MenuLateral({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF003B00),
        child: Column(
          children: [
            const SizedBox(height: 40),

            // LOGO
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

            // HOME
            _botaoPrincipal(context, "Home", () {}),

            // CLIENTES (expansível)
            ExpansionTile(
              iconColor: Colors.white,
              collapsedIconColor: Colors.white,
              title: _tituloPrincipal("Clientes"),
              children: [
                _subItem(context, "Cadastro de cliente", () {}),
                _subItem(context, "Listagem de cliente", () {}),
              ],
            ),

            
            ExpansionTile(
              iconColor: Colors.white,
              collapsedIconColor: Colors.white,
              title: _tituloPrincipal("Animais"),
              children: [
                _subItem(context, "Cadastro de animais", () {}),
                _subItem(context, "Listagem de animais", () {}),
              ],
            ),

            const Spacer(),

            // LOGOUT
            _botaoPrincipal(context, "Logout", () {}),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _botaoPrincipal(
    BuildContext context,
    String title,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            onTap();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[300],
          ),
          child: Text(title, style: const TextStyle(color: Colors.black)),
        ),
      ),
    );
  }

  Widget _tituloPrincipal(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _subItem(
    BuildContext context,
    String title,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            onTap();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[400],
          ),
          child: Text(title, style: const TextStyle(color: Colors.black)),
        ),
      ),
    );
  }
}