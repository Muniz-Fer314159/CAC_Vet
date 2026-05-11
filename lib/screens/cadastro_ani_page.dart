import 'package:flutter/material.dart';

import '../constants/app_theme.dart';
import '../database/database_helper.dart';
import '../models/animal.dart';
import '../widgets/input_field.dart';
import '../widgets/main_layout.dart';
import 'listagem_ani_page.dart';

class CadastroAnimalPage extends StatefulWidget {
  final Animal? animal;
  final bool redirecionarParaListagemAoSalvar;

  const CadastroAnimalPage({
    super.key,
    this.animal,
    this.redirecionarParaListagemAoSalvar = true,
  });

  @override
  State<CadastroAnimalPage> createState() => _CadastroAnimalPageState();
}

class _CadastroAnimalPageState extends State<CadastroAnimalPage> {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final especieController = TextEditingController();
  final racaController = TextEditingController();
  final idadeController = TextEditingController();
  final nomeDonoController = TextEditingController();

  bool get _emEdicao => widget.animal != null;

  @override
  void initState() {
    super.initState();

    final animal = widget.animal;
    if (animal == null) return;

    nomeController.text = animal.nome;
    especieController.text = animal.especie;
    racaController.text = animal.raca;
    idadeController.text = animal.idade.toString();
    nomeDonoController.text = animal.nomeDono;
  }

  Future<void> salvarAnimal() async {
    if (!_formKey.currentState!.validate()) return;

    final idade = int.tryParse(idadeController.text.trim());
    if (idade == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Informe uma idade valida.'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: AppShapes.buttonRadius),
        ),
      );
      return;
    }

    final animal = Animal(
      id: widget.animal?.id,
      nome: nomeController.text.trim(),
      especie: especieController.text.trim(),
      raca: racaController.text.trim(),
      idade: idade,
      nomeDono: nomeDonoController.text.trim(),
    );

    if (_emEdicao) {
      await DatabaseHelper.instance.atualizarAnimal(animal.toMap());
    } else {
      final dados = animal.toMap()..remove('id');
      await DatabaseHelper.instance.inserirAnimal(dados);
    }

    if (!mounted) return;

    final mensagem = _emEdicao
        ? 'Animal atualizado com sucesso!'
        : 'Animal cadastrado com sucesso!';

    if (widget.redirecionarParaListagemAoSalvar) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ListagemAnimalPage(mensagemSucesso: mensagem),
        ),
      );
      return;
    }

    Navigator.pop(context, mensagem);
  }

  void limparCampos() {
    nomeController.clear();
    especieController.clear();
    racaController.clear();
    idadeController.clear();
    nomeDonoController.clear();
  }

  @override
  void dispose() {
    nomeController.dispose();
    especieController.dispose();
    racaController.dispose();
    idadeController.dispose();
    nomeDonoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tituloPagina = _emEdicao ? 'Editar Animal' : 'Cadastro de Animal';
    final tituloFormulario = _emEdicao ? 'Editar Animal' : 'Novo Animal';
    final textoBotao = _emEdicao ? 'Salvar Alteracoes' : 'Cadastrar Animal';

    return MainLayout(
      title: tituloPagina,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: AppShapes.cardRadius,
                  boxShadow: [AppShapes.cardShadow],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        tituloFormulario,
                        style: AppTextStyles.heading2,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      InputField(
                        controller: nomeController,
                        labelText: 'Nome do Animal',
                        hintText: 'Ex: Rex, Milu',
                        prefixIcon: Icons.pets,
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Nome do animal e obrigatorio'
                            : null,
                      ),
                      const SizedBox(height: 20),
                      InputField(
                        controller: especieController,
                        labelText: 'Especie',
                        hintText: 'Ex: Cachorro, Gato',
                        prefixIcon: Icons.category,
                        validator: (v) =>
                            v == null || v.trim().isEmpty ? 'Especie e obrigatoria' : null,
                      ),
                      const SizedBox(height: 20),
                      InputField(
                        controller: racaController,
                        labelText: 'Raca',
                        hintText: 'Ex: Poodle, Siamese',
                        prefixIcon: Icons.info_outline,
                        validator: (v) =>
                            v == null || v.trim().isEmpty ? 'Raca e obrigatoria' : null,
                      ),
                      const SizedBox(height: 20),
                      InputField(
                        controller: idadeController,
                        labelText: 'Idade',
                        hintText: 'Em anos',
                        prefixIcon: Icons.calendar_today,
                        keyboardType: TextInputType.number,
                        validator: (v) =>
                            v == null || v.trim().isEmpty ? 'Idade e obrigatoria' : null,
                      ),
                      const SizedBox(height: 20),
                      InputField(
                        controller: nomeDonoController,
                        labelText: 'Nome do Dono',
                        hintText: 'Nome completo',
                        prefixIcon: Icons.person,
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Nome do dono e obrigatorio'
                            : null,
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: salvarAnimal,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: AppShapes.buttonRadius,
                            ),
                          ),
                          child: Text(
                            textoBotao,
                            style: AppTextStyles.button,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          onPressed: _emEdicao
                              ? () => Navigator.pop(context)
                              : limparCampos,
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: AppColors.accent,
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: AppShapes.buttonRadius,
                            ),
                          ),
                          child: Text(
                            _emEdicao ? 'Cancelar' : 'Limpar',
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.accent,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
