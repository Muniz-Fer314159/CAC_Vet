import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class CadastroClientePage extends StatefulWidget {
  const CadastroClientePage({super.key});

  @override
  State<CadastroClientePage> createState() => _CadastroClientePageState();
}

class _CadastroClientePageState extends State<CadastroClientePage> {
  final nomeController = TextEditingController();
  final telefoneController = TextEditingController();
  final emailController = TextEditingController();
  final enderecoController = TextEditingController();
  final cpfController = TextEditingController();

  Future<void> salvarCliente() async {
    await DatabaseHelper.instance.inserirCliente({
      'nome': nomeController.text,
      'telefone': telefoneController.text,
      'email': emailController.text,
      'endereco': enderecoController.text,
      'cpf': cpfController.text,
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Cliente salvo com sucesso!")),
    );

    limparCampos();
  }

  void limparCampos() {
    nomeController.clear();
    telefoneController.clear();
    emailController.clear();
    enderecoController.clear();
    cpfController.clear();
  }

  @override
  void dispose() {
    nomeController.dispose();
    telefoneController.dispose();
    emailController.dispose();
    enderecoController.dispose();
    cpfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF0D3B0D),
        child: Column(
          children: [
            _topo("Cadastro de cliente"),
            const SizedBox(height: 30),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    _input("Nome", nomeController),
                    _input("Telefone", telefoneController),
                    _input("Email", emailController),
                    _input("Endereço", enderecoController),
                    _input("CPF", cpfController),
                    const Spacer(),
                    _botoes(context),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topo(String titulo) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: const BoxDecoration(
        color: Color(0xFF1FAA59),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 15),
          Text(
            titulo,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _input(String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[300],
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _botoes(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: salvarCliente,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[300],
          ),
          child: const Text(
            "Gravar",
            style: TextStyle(color: Colors.black),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[300],
          ),
          child: const Text(
            "Cancelar",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}