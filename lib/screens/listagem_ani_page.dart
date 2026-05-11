import 'package:flutter/material.dart';

import '../constants/app_theme.dart';
import '../database/database_helper.dart';
import '../models/animal.dart';
import '../widgets/main_layout.dart';
import 'cadastro_ani_page.dart';

class ListagemAnimalPage extends StatefulWidget {
  final String? mensagemSucesso;

  const ListagemAnimalPage({super.key, this.mensagemSucesso});

  @override
  State<ListagemAnimalPage> createState() => _ListagemAnimalPageState();
}

class _ListagemAnimalPageState extends State<ListagemAnimalPage> {
  final TextEditingController _buscaController = TextEditingController();

  List<Animal> _animais = [];
  List<Animal> _animaisFiltrados = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarAnimais();

    if (widget.mensagemSucesso != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _mostrarSnack(widget.mensagemSucesso!);
      });
    }
  }

  Future<void> _carregarAnimais() async {
    final registros = await DatabaseHelper.instance.obterAnimais();
    final animais = registros.map(Animal.fromMap).toList();

    if (!mounted) return;

    setState(() {
      _animais = animais;
      _aplicarFiltro(_buscaController.text);
      _carregando = false;
    });
  }

  void _aplicarFiltro(String texto) {
    final termo = texto.trim().toLowerCase();

    _animaisFiltrados = _animais.where((animal) {
      if (termo.isEmpty) return true;

      return animal.nome.toLowerCase().contains(termo) ||
          animal.especie.toLowerCase().contains(termo) ||
          animal.nomeDono.toLowerCase().contains(termo);
    }).toList();
  }

  void _filtrar(String texto) {
    setState(() {
      _aplicarFiltro(texto);
    });
  }

  Future<void> _abrirCadastro({Animal? animal}) async {
    final mensagem = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => CadastroAnimalPage(
          animal: animal,
          redirecionarParaListagemAoSalvar: false,
        ),
      ),
    );

    if (mensagem == null) return;

    await _carregarAnimais();
    if (!mounted) return;
    _mostrarSnack(mensagem);
  }

  Future<void> _excluirAnimal(Animal animal) async {
    final confirmou = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Excluir animal'),
            content: Text('Deseja excluir ${animal.nome}?'),
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

    if (!confirmou || animal.id == null) return;

    await DatabaseHelper.instance.deletarAnimal(animal.id!);
    await _carregarAnimais();

    if (!mounted) return;
    _mostrarSnack('Animal excluido com sucesso!');
  }

  IconData _getEspecieIcon(String especie) {
    final especieNormalizada = especie.toLowerCase();

    if (especieNormalizada.contains('pass')) {
      return Icons.flutter_dash;
    }

    if (especieNormalizada.contains('coelho')) {
      return Icons.cruelty_free;
    }

    return Icons.pets;
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
      title: 'Animais',
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
                    hintText: 'Buscar por nome, especie ou dono...',
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
                    label: const Text('Novo animal'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _carregando
                ? const Center(child: CircularProgressIndicator())
                : _animaisFiltrados.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.pets_outlined,
                              size: 64,
                              color: AppColors.primary.withValues(alpha: 0.3),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Nenhum animal encontrado',
                              style: AppTextStyles.body.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        itemCount: _animaisFiltrados.length,
                        itemBuilder: (context, index) {
                          final animal = _animaisFiltrados[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: AppShapes.cardRadius,
                                boxShadow: [AppShapes.cardShadow],
                                border: Border.all(
                                  color: AppColors.accent.withValues(alpha: 0.1),
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
                                            color: AppColors.accent.withValues(
                                              alpha: 0.1,
                                            ),
                                            borderRadius: AppShapes.buttonRadius,
                                          ),
                                          child: Icon(
                                            _getEspecieIcon(animal.especie),
                                            color: AppColors.accent,
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
                                                animal.nome,
                                                style: AppTextStyles.heading3,
                                              ),
                                              Text(
                                                animal.raca.isEmpty
                                                    ? animal.especie
                                                    : animal.raca,
                                                style: AppTextStyles.caption,
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          tooltip: 'Editar',
                                          onPressed: () =>
                                              _abrirCadastro(animal: animal),
                                          icon: const Icon(Icons.edit_outlined),
                                        ),
                                        IconButton(
                                          tooltip: 'Excluir',
                                          onPressed: () => _excluirAnimal(animal),
                                          icon: const Icon(
                                            Icons.delete_outline,
                                            color: AppColors.error,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    _buildInfoRow(
                                      Icons.category,
                                      'Especie',
                                      animal.especie,
                                    ),
                                    const SizedBox(height: 8),
                                    _buildInfoRow(
                                      Icons.calendar_today,
                                      'Idade',
                                      '${animal.idade} ano${animal.idade == 1 ? '' : 's'}',
                                    ),
                                    const SizedBox(height: 8),
                                    _buildInfoRow(
                                      Icons.person,
                                      'Dono',
                                      animal.nomeDono,
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
        Icon(icon, size: 16, color: AppColors.accent),
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
