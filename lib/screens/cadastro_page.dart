import 'package:flutter/material.dart';
import '../widgets/input_field.dart';
import '../database/database_helper.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();

  final loginController = TextEditingController();
  final senhaController = TextEditingController();

  Future<void> _cadastrar() async {
    if (_formKey.currentState!.validate()) {
      await DatabaseHelper.instance.inserirUsuario({
        'login': loginController.text,
        'senha': senhaController.text,
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastro realizado!')),
      );

      loginController.clear();
      senhaController.clear();

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    loginController.dispose();
    senhaController.dispose();
    super.dispose();
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
            controller: loginController,
            validator: (v) =>
                v == null || v.isEmpty ? "Digite o login" : null,
          ),

          const SizedBox(height: 16),

          const Text("Senha", style: TextStyle(color: Colors.white)),
          const SizedBox(height: 8),

          InputField(
            controller: senhaController,
            obscure: true,
            validator: (v) =>
                v == null || v.length < 4 ? "Senha inválida" : null,
          ),

          const SizedBox(height: 20),

          Center(
            child: ElevatedButton(
              onPressed: _cadastrar,
              child: const Text("Cadastrar"),
            ),
          ),

          const SizedBox(height: 10),

          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}