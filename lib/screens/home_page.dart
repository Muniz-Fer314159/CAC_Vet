import 'package:flutter/material.dart';
import 'listagem_cli_page.dart';
import 'listagem_ani_page.dart';
import 'cadastro_ani_page.dart';
import 'cadastro_cli_page.dart';
import '../widgets/main_layout.dart';
import '../widgets/paw_logo.dart';
import '../constants/app_theme.dart';

class HomePage extends StatelessWidget {
final String token;
const HomePage({super.key, this.token = ''});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      token: token,
      child: Container(
        color: AppColors.background,
        child: Column(
          children: [
            _buildHeader(),
            _buildMenuPrincipal(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [AppShapes.cardShadow],
      ),
      child: Row(
        children: [
          const PawLogo(size: 80),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "CAC Vet",
                  style: AppTextStyles.heading1.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Sistema de Gestão Veterinária",
                  style: AppTextStyles.body.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuPrincipal(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Menu Principal',
              style: AppTextStyles.heading2,
            ),
            const SizedBox(height: 24),
            _buildMenuCard(
              context: context,
              titulo: "Clientes",
              icone: Icons.people,
              cor: AppColors.primary,
              itens: ["Cadastro de cliente", "Listagem de cliente"],
            ),
            const SizedBox(height: 20),
            _buildMenuCard(
              context: context,
              titulo: "Animais",
              icone: Icons.pets,
              cor: AppColors.accent,
              itens: ["Cadastro de animais", "Listagem de animais"],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard({
    required BuildContext context,
    required String titulo,
    required IconData icone,
    required Color cor,
    required List<String> itens,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppShapes.cardRadius,
        boxShadow: [AppShapes.cardShadow],
        border: Border.all(
          color: cor.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: ExpansionTile(
        collapsedIconColor: cor,
        iconColor: cor,
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cor.withValues(alpha: 0.1),
            borderRadius: AppShapes.buttonRadius,
          ),
          child: Icon(icone, color: cor),
        ),
        title: Text(
          titulo,
          style: AppTextStyles.heading3,
        ),
        children: itens.map((item) => _buildMenuItem(context, item, cor)).toList(),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String texto, Color cor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: GestureDetector(
        onTap: () => _navigateToPage(context, texto),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: cor.withValues(alpha: 0.05),
            borderRadius: AppShapes.buttonRadius,
            border: Border.all(
              color: cor.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                _getItemIcon(texto),
                size: 20,
                color: cor,
              ),
              const SizedBox(width: 12),
              Text(
                texto,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getItemIcon(String texto) {
    if (texto.contains('Cadastro')) return Icons.add;
    if (texto.contains('Listagem')) return Icons.list;
    return Icons.arrow_forward;
  }

  void _navigateToPage(BuildContext context, String texto) {
    Widget? page;

    switch (texto) {
      case "Cadastro de cliente":
        page = const CadastroClientePage();
        break;
      case "Cadastro de animais":
        page = const CadastroAnimalPage();
        break;
      case "Listagem de cliente":
        page = const ListagemClientePage();
        break;
      case "Listagem de animais":
        page = const ListagemAnimalPage();
        break;
    }

    if (page != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => page!),
      );
    }
  }
}
