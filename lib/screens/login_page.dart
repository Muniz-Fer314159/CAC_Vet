import 'package:anchieta_flutter_todo/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'cadastro_page.dart';
import '../widgets/input_field.dart';
import '../widgets/paw_logo.dart';
import '../services/auth_service.dart';
import '../constants/app_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _senhaController = TextEditingController();
  final _authService = AuthService();
  bool _carregando = false;

  @override
  void dispose() {
    _loginController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _carregando = true);

    try {
      final result = await _authService.login(
        username: _loginController.text.trim(),
        password: _senhaController.text.trim(),
      );

      final token = result['access_token'] as String? ?? '';

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Login realizado com sucesso!'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: AppShapes.buttonRadius),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage(token: token)),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceAll('Exception: ', '')),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: AppShapes.buttonRadius),
        ),
      );
    } finally {
      if (mounted) setState(() => _carregando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 60),
                const PawLogo(size: 120),
                const SizedBox(height: 32),
                Text(
                  'CAC Vet',
                  style: AppTextStyles.heading1.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Sistema de Gestão Veterinária',
                  style: AppTextStyles.bodySecondary,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                _buildLoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Container(
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
              'Entrar na sua conta',
              style: AppTextStyles.heading2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            InputField(
              controller: _loginController,
              labelText: 'Usuário',
              hintText: 'Digite seu usuário',
              prefixIcon: Icons.person,
              validator: (v) => v == null || v.isEmpty ? 'Digite o usuário' : null,
            ),

            const SizedBox(height: 24),

            InputField(
              controller: _senhaController,
              labelText: 'Senha',
              hintText: 'Digite sua senha',
              prefixIcon: Icons.lock,
              obscure: true,
              validator: (v) =>
                  v == null || v.length < 4 ? 'Senha deve ter pelo menos 4 caracteres' : null,
            ),

            const SizedBox(height: 32),

            SizedBox(
              height: 50,
              child: _carregando
                  ? const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppShapes.buttonRadius,
                        ),
                        elevation: 2,
                      ),
                      child: Text('Entrar', style: AppTextStyles.button),
                    ),
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Não tem conta? ',
                  style: AppTextStyles.bodySecondary,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CadastroPage()),
                    );
                  },
                  child: Text(
                    'Cadastrar-se',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
