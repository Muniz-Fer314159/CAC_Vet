import 'package:flutter/material.dart';

import '../constants/app_theme.dart';
import '../database/database_helper.dart';
import '../models/cliente.dart';
import '../widgets/input_field.dart';
import '../widgets/main_layout.dart';
import 'listagem_cli_page.dart';

class CadastroClientePage extends StatefulWidget {
  final Cliente? cliente;
  final bool redirecionarParaListagemAoSalvar;

  const CadastroClientePage({
    super.key,
    this.cliente,
    this.redirecionarParaListagemAoSalvar = true,
  });

  @override
  State<CadastroClientePage> createState() => _CadastroClientePageState();
}

class _CadastroClientePageState extends State<CadastroClientePage> {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final telefoneController = TextEditingController();
  final emailController = TextEditingController();
  final enderecoController = TextEditingController();
  final cpfController = TextEditingController();

  bool get _emEdicao => widget.cliente != null;

  @override
  void initState() {
    super.initState();

    final cliente = widget.cliente;
    if (cliente == null) return;

    nomeController.text = cliente.nome;
    telefoneController.text = cliente.telefone;
    emailController.text = cliente.email;
    enderecoController.text = cliente.endereco;
    cpfController.text = cliente.cpf;
  }

  Future<void> salvarCliente() async {
    if (!_formKey.currentState!.validate()) return;

    final cliente = Cliente(
      id: widget.cliente?.id,
      nome: nomeController.text.trim(),
      telefone: telefoneController.text.trim(),
      email: emailController.text.trim(),
      endereco: enderecoController.text.trim(),
      cpf: cpfController.text.trim(),
    );

    if (_emEdicao) {
      await DatabaseHelper.instance.atualizarCliente(cliente.toMap());
    } else {
      final dados = cliente.toMap()..remove('id');
      await DatabaseHelper.instance.inserirCliente(dados);
    }

    if (!mounted) return;

    final mensagem = _emEdicao
        ? 'Cliente atualizado com sucesso!'
        : 'Cliente cadastrado com sucesso!';

    if (widget.redirecionarParaListagemAoSalvar) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ListagemClientePage(mensagemSucesso: mensagem),
        ),
      );
      return;
    }

    Navigator.pop(context, mensagem);
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
    final tituloPagina = _emEdicao ? 'Editar Cliente' : 'Cadastro de Cliente';
    final tituloFormulario = _emEdicao ? 'Editar Cliente' : 'Novo Cliente';
    final textoBotao = _emEdicao ? 'Salvar Alteracoes' : 'Cadastrar Cliente';

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
                        labelText: 'Nome',
                        hintText: 'Digite o nome completo',
                        prefixIcon: Icons.person,
                        validator: (v) =>
                            v == null || v.trim().isEmpty ? 'Nome e obrigatorio' : null,
                      ),
                      const SizedBox(height: 20),
                      InputField(
                        controller: telefoneController,
                        labelText: 'Telefone',
                        hintText: '(11) 99999-9999',
                        prefixIcon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Telefone e obrigatorio'
                            : null,
                      ),
                      const SizedBox(height: 20),
                      InputField(
                        controller: emailController,
                        labelText: 'Email',
                        hintText: 'email@exemplo.com',
                        prefixIcon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) =>
                            v == null || v.trim().isEmpty ? 'Email e obrigatorio' : null,
                      ),
                      const SizedBox(height: 20),
                      InputField(
                        controller: enderecoController,
                        labelText: 'Endereco',
                        hintText: 'Rua, numero e complemento',
                        prefixIcon: Icons.location_on,
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Endereco e obrigatorio'
                            : null,
                      ),
                      const SizedBox(height: 20),
                      InputField(
                        controller: cpfController,
                        labelText: 'CPF',
                        hintText: '000.000.000-00',
                        prefixIcon: Icons.badge,
                        keyboardType: TextInputType.number,
                        validator: (v) =>
                            v == null || v.trim().isEmpty ? 'CPF e obrigatorio' : null,
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: salvarCliente,
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
