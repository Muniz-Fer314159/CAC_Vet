import 'package:flutter/material.dart';

import '../constants/app_theme.dart';
import '../database/database_helper.dart';
import '../models/cliente.dart';
import '../widgets/main_layout.dart';
import 'cadastro_cli_page.dart';

class ListagemClientePage extends StatefulWidget {
  final String? mensagemSucesso;

  const ListagemClientePage({super.key, this.mensagemSucesso});

  @override
  State<ListagemClientePage> createState() => _ListagemClientePageState();
}

class _ListagemClientePageState extends State<ListagemClientePage> {
  final TextEditingController _buscaController = TextEditingController();

  List<Cliente> _clientes = [];
  List<Cliente> _clientesFiltrados = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarClientes();

    if (widget.mensagemSucesso != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _mostrarSnack(widget.mensagemSucesso!);
      });
    }
  }

  Future<void> _carregarClientes() async {
    final registros = await DatabaseHelper.instance.obterClientes();
    final clientes = registros.map(Cliente.fromMap).toList();

    if (!mounted) return;

    setState(() {
      _clientes = clientes;
      _aplicarFiltro(_buscaController.text);
      _carregando = false;
    });
  }

  void _aplicarFiltro(String texto) {
    final termo = texto.trim().toLowerCase();

    _clientesFiltrados = _clientes.where((cliente) {
      if (termo.isEmpty) return true;

      return cliente.nome.toLowerCase().contains(termo) ||
          cliente.cpf.toLowerCase().contains(termo);
    }).toList();
  }

  void _filtrar(String texto) {
    setState(() {
      _aplicarFiltro(texto);
    });
  }

  Future<void> _abrirCadastro({Cliente? cliente}) async {
    final mensagem = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => CadastroClientePage(
          cliente: cliente,
          redirecionarParaListagemAoSalvar: false,
        ),
      ),
    );

    if (mensagem == null) return;

    await _carregarClientes();
    if (!mounted) return;
    _mostrarSnack(mensagem);
  }

  Future<void> _excluirCliente(Cliente cliente) async {
    final confirmou = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Excluir cliente'),
            content: Text('Deseja excluir ${cliente.nome}?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  'Excluir',
                  style: TextStyle(color: AppColors.error),
                ),
              ),
            ],
          ),
        ) ??
        false;

    if (!confirmou || cliente.id == null) return;

    await DatabaseHelper.instance.deletarCliente(cliente.id!);
    await _carregarClientes();

    if (!mounted) return;
    _mostrarSnack('Cliente excluido com sucesso!');
  }

  void _mostrarSnack(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: AppShapes.buttonRadius),
      ),
    );
  }

  @override
  void dispose() {
    _buscaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Clientes',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                TextField(
                  controller: _buscaController,
                  onChanged: _filtrar,
                  decoration: InputDecoration(
                    hintText: 'Buscar por nome ou CPF...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: AppColors.surface,
                    border: OutlineInputBorder(
                      borderRadius: AppShapes.inputRadius,
                      borderSide: BorderSide(
                        color: AppColors.primary.withValues(alpha: 0.3),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: AppShapes.inputRadius,
                      borderSide: BorderSide(
                        color: AppColors.primary.withValues(alpha: 0.3),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: AppShapes.inputRadius,
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    onPressed: () => _abrirCadastro(),
                    icon: const Icon(Icons.add),
                    label: const Text('Novo cliente'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _carregando
                ? const Center(child: CircularProgressIndicator())
                : _clientesFiltrados.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.people_outline,
                              size: 64,
                              color: AppColors.primary.withValues(alpha: 0.3),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Nenhum cliente encontrado',
                              style: AppTextStyles.body.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        itemCount: _clientesFiltrados.length,
                        itemBuilder: (context, index) {
                          final cliente = _clientesFiltrados[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: AppShapes.cardRadius,
                                boxShadow: [AppShapes.cardShadow],
                                border: Border.all(
                                  color: AppColors.primary.withValues(alpha: 0.1),
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: AppColors.primary.withValues(
                                              alpha: 0.1,
                                            ),
                                            borderRadius: AppShapes.buttonRadius,
                                          ),
                                          child: const Icon(
                                            Icons.person,
                                            color: AppColors.primary,
                                            size: 24,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                cliente.nome,
                                                style: AppTextStyles.heading3,
                                              ),
                                              Text(
                                                cliente.cpf,
                                                style: AppTextStyles.caption,
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          tooltip: 'Editar',
                                          onPressed: () =>
                                              _abrirCadastro(cliente: cliente),
                                          icon: const Icon(Icons.edit_outlined),
                                        ),
                                        IconButton(
                                          tooltip: 'Excluir',
                                          onPressed: () =>
                                              _excluirCliente(cliente),
                                          icon: const Icon(
                                            Icons.delete_outline,
                                            color: AppColors.error,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    _buildInfoRow(
                                      Icons.phone,
                                      'Telefone',
                                      cliente.telefone,
                                    ),
                                    const SizedBox(height: 8),
                                    _buildInfoRow(
                                      Icons.email,
                                      'Email',
                                      cliente.email,
                                    ),
                                    const SizedBox(height: 8),
                                    _buildInfoRow(
                                      Icons.location_on,
                                      'Endereco',
                                      cliente.endereco,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.caption,
              ),
              Text(
                value.isEmpty ? '-' : value,
                style: AppTextStyles.body,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
