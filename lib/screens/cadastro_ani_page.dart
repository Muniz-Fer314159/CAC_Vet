import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class CadastroAnimalPage extends StatefulWidget {
  const CadastroAnimalPage({super.key});

  @override
  State<CadastroAnimalPage> createState() => _CadastroAnimalPageState();
}

class _CadastroAnimalPageState extends State<CadastroAnimalPage> {
  final nomeController = TextEditingController();
  final especieController = TextEditingController();
  final racaController = TextEditingController();
  final idadeController = TextEditingController();
  final donoController = TextEditingController();

  Future<void> salvarAnimal() async {
    await DatabaseHelper.instance.inserirAnimal({
      'nome': nomeController.text,
      'especie': especieController.text,
      'raca': racaController.text,
      'idade': int.tryParse(idadeController.text) ?? 0,
      'nome_dono': donoController.text,
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Animal salvo com sucesso!")),
    );

    limparCampos();
  }

  void limparCampos() {
    nomeController.clear();
    especieController.clear();
    racaController.clear();
    idadeController.clear();
    donoController.clear();
  }

  @override
  void dispose() {
    nomeController.dispose();
    especieController.dispose();
    racaController.dispose();
    idadeController.dispose();
    donoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF0D3B0D),
        child: Column(
          children: [
            _topo("Cadastro de animal"),
            const SizedBox(height: 30),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    _input("Nome do animal", nomeController),
                    _input("Espécie", especieController),
                    _input("Raça", racaController),
                    _input("Idade", idadeController),
                    _input("Nome do dono", donoController),
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
        keyboardType: hint == "Idade"
            ? TextInputType.number
            : TextInputType.text,
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
          onPressed: salvarAnimal,
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