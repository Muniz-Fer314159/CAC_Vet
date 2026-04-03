import 'package:anchieta_flutter_todo/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'cadastro_page.dart';
import '../widgets/input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  void _login() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login válido!')),
      );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomePage())
    );

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF003B00),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                _logo(),

                Positioned(
                  top: 150,
                  left: 30,
                  right: 30,
                  child: Form(
                    key: _formKey,
                    child: _card(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logo() {
    return Positioned(
      top: 30,
      child: Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
        ),
        alignment: Alignment.center,
        child: const Text("Logo"),
      ),
    );
  }

  Widget _card() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Login", style: TextStyle(color: Colors.white)),
          const SizedBox(height: 8),

          InputField(
            validator: (v) =>
                v == null || v.isEmpty ? "Digite o login" : null,
          ),

          const SizedBox(height: 16),

          const Text("Senha", style: TextStyle(color: Colors.white)),
          const SizedBox(height: 8),

          InputField(
            obscure: true,
            validator: (v) =>
                v == null || v.length < 4 ? "Senha inválida" : null,
          ),

          const SizedBox(height: 20),

          Center(
            child: ElevatedButton(
              onPressed: _login,
              child: const Text("Entrar"),
            ),
          ),

          const SizedBox(height: 10),

          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CadastroPage(),
                  ),
                );
              },
              child: const Text(
                "Cadastre-se",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}