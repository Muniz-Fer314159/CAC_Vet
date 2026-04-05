import 'package:flutter/material.dart';

class ListagemClientePage extends StatefulWidget {
  const ListagemClientePage({super.key});

  @override
  State<ListagemClientePage> createState() => _ListagemClientePageState();
}

class _ListagemClientePageState extends State<ListagemClientePage> {
  final TextEditingController _buscaController = TextEditingController();

  final List<Map<String, String>> _clientes = [
    {
      'nome': 'João Silva',
      'telefone': '(11) 99999-0001',
      'email': 'joao@email.com',
      'endereco': 'Rua das Flores, 123',
      'cpf': '111.111.111-01',
    },
    {
      'nome': 'Maria Souza',
      'telefone': '(11) 99999-0002',
      'email': 'maria@email.com',
      'endereco': 'Av. Paulista, 456',
      'cpf': '222.222.222-02',
    },
    {
      'nome': 'Carlos Lima',
      'telefone': '(11) 99999-0003',
      'email': 'carlos@email.com',
      'endereco': 'Rua do Pinheiro, 789',
      'cpf': '333.333.333-03',
    },
    {
      'nome': 'Ana Paula',
      'telefone': '(11) 99999-0004',
      'email': 'ana@email.com',
      'endereco': 'Rua das Acácias, 321',
      'cpf': '444.444.444-04',
    },
    {
      'nome': 'Roberto Ferreira',
      'telefone': '(11) 99999-0005',
      'email': 'roberto@email.com',
      'endereco': 'Av. Brasil, 654',
      'cpf': '555.555.555-05',
    },
  ];

  List<Map<String, String>> _clientesFiltrados = [];

  @override
  void initState() {
    super.initState();
    _clientesFiltrados = List.from(_clientes);
  }

  void _filtrar(String texto) {
    setState(() {
      _clientesFiltrados = _clientes
          .where((c) =>
              c['nome']!.toLowerCase().contains(texto.toLowerCase()) ||
              c['cpf']!.contains(texto))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF0D3B0D),
        child: Column(
          children: [
            _topo(context, "Listagem de clientes"),
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
          hintText: 'Buscar por nome ou CPF...',
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
    if (_clientesFiltrados.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum cliente encontrado.',
          style: TextStyle(color: Colors.white70),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      itemCount: _clientesFiltrados.length,
      itemBuilder: (context, index) {
        return _card(_clientesFiltrados[index]);
      },
    );
  }

  Widget _card(Map<String, String> cliente) {
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
              child: Text(
                cliente['nome']![0],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cliente['nome']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _infoLinha(Icons.phone, cliente['telefone']!),
                  _infoLinha(Icons.email, cliente['email']!),
                  _infoLinha(Icons.location_on, cliente['endereco']!),
                  _infoLinha(Icons.badge, cliente['cpf']!),
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
