import 'package:flutter/material.dart';
import '../widgets/input_field.dart';
import '../widgets/main_layout.dart';
import '../database/database_helper.dart';
import '../constants/app_theme.dart';

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
        SnackBar(
          content: const Text('Cadastro realizado com sucesso!'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: AppShapes.buttonRadius),
        ),
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
    return MainLayout(
      title: 'Cadastro de Usuário',
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 32),
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
                        'Criar Nova Conta',
                        style: AppTextStyles.heading2,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      InputField(
                        controller: loginController,
                        labelText: 'Usuário',
                        hintText: 'Digite seu usuário',
                        prefixIcon: Icons.person,
                        validator: (v) => v == null || v.isEmpty
                            ? 'Digite um usuário'
                            : null,
                      ),
                      const SizedBox(height: 24),
                      InputField(
                        controller: senhaController,
                        labelText: 'Senha',
                        hintText: 'Digite sua senha',
                        prefixIcon: Icons.lock,
                        obscure: true,
                        validator: (v) =>
                            v == null || v.length < 4
                                ? 'Senha deve ter pelo menos 4 caracteres'
                                : null,
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _cadastrar,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: AppShapes.buttonRadius,
                            ),
                          ),
                          child: Text(
                            'Cadastrar',
                            style: AppTextStyles.button,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: AppColors.primary,
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: AppShapes.buttonRadius,
                            ),
                          ),
                          child: Text(
                            'Voltar',
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}