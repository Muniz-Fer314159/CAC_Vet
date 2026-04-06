import 'package:flutter/material.dart';

class ListagemAnimalPage extends StatefulWidget {
  const ListagemAnimalPage({super.key});

  @override
  State<ListagemAnimalPage> createState() => _ListagemAnimalPageState();
}

class _ListagemAnimalPageState extends State<ListagemAnimalPage> {
  final TextEditingController _buscaController = TextEditingController();

  final List<Map<String, String>> _animais = [
    {
      'nome': 'Rex',
      'especie': 'Cachorro',
      'raca': 'Labrador',
      'idade': '3 anos',
      'dono': 'João Silva',
    },
    {
      'nome': 'Mia',
      'especie': 'Gato',
      'raca': 'Persa',
      'idade': '2 anos',
      'dono': 'Maria Souza',
    },
    {
      'nome': 'Bolinha',
      'especie': 'Cachorro',
      'raca': 'Poodle',
      'idade': '5 anos',
      'dono': 'Carlos Lima',
    },
    {
      'nome': 'Nina',
      'especie': 'Gato',
      'raca': 'Siamês',
      'idade': '1 ano',
      'dono': 'Ana Paula',
    },
    {
      'nome': 'Thor',
      'especie': 'Cachorro',
      'raca': 'Pastor Alemão',
      'idade': '4 anos',
      'dono': 'Roberto Ferreira',
    },
  ];

  List<Map<String, String>> _animaisFiltrados = [];

  @override
  void initState() {
    super.initState();
    _animaisFiltrados = List.from(_animais);
  }

  void _filtrar(String texto) {
    setState(() {
      _animaisFiltrados = _animais
          .where((a) =>
              a['nome']!.toLowerCase().contains(texto.toLowerCase()) ||
              a['dono']!.toLowerCase().contains(texto.toLowerCase()) ||
              a['especie']!.toLowerCase().contains(texto.toLowerCase()))
          .toList();
    });
  }

  IconData _iconeEspecie(String especie) {
    switch (especie.toLowerCase()) {
      case 'cachorro':
        return Icons.pets;
      case 'gato':
        return Icons.catching_pokemon;
      default:
        return Icons.cruelty_free;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF0D3B0D),
        child: Column(
          children: [
            _topo(context, "Listagem de animais"),
            const SizedBox(height: 20),
            _campoBusca(),
            const SizedBox(height: 10),
            Expanded(child: _lista()),
          ],
        ),
      ),
    );
  }

  Widget _topo(BuildContext context, String titulo) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: const BoxDecoration(
        color: Color(0xFF1FAA59),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 15),
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

  Widget _campoBusca() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: _buscaController,
        onChanged: _filtrar,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[300],
          hintText: 'Buscar por nome, espécie ou dono...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _lista() {
    if (_animaisFiltrados.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum animal encontrado.',
          style: TextStyle(color: Colors.white70),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      itemCount: _animaisFiltrados.length,
      itemBuilder: (context, index) {
        return _card(_animaisFiltrados[index]);
      },
    );
  }

  Widget _card(Map<String, String> animal) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFF1FAA59),
              radius: 24,
              child: Icon(
                _iconeEspecie(animal['especie']!),
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    animal['nome']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _infoLinha(Icons.category, animal['especie']!),
                  _infoLinha(Icons.style, animal['raca']!),
                  _infoLinha(Icons.cake, animal['idade']!),
                  _infoLinha(Icons.person, animal['dono']!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoLinha(IconData icone, String texto) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Icon(icone, size: 14, color: const Color(0xFF1FAA59)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              texto,
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
