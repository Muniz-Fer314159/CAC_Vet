import 'package:flutter/material.dart';

class AppColors {
  // Cores principais - paleta profissional e minimalista
  static const Color primary = Color(0xFF2E7D32);      // Verde escuro profissional
  static const Color primaryLight = Color(0xFF4CAF50);  // Verde médio
  static const Color primaryDark = Color(0xFF1B5E20);   // Verde muito escuro
  static const Color accent = Color(0xFFFFC107);        // Amarelo dourado para destaques
  static const Color background = Color(0xFFF5F5F5);    // Cinza muito claro
  static const Color surface = Colors.white;            // Branco para superfícies
  static const Color textPrimary = Color(0xFF212121);   // Preto para texto principal
  static const Color textSecondary = Color(0xFF757575); // Cinza para texto secundário
  static const Color error = Color(0xFFD32F2F);         // Vermelho para erros
  static const Color success = Color(0xFF388E3C);       // Verde para sucesso

  // Gradientes para elementos visuais
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, Color(0xFFFFD54F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodySecondary = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );
}

class AppShapes {
  static const BorderRadius cardRadius = BorderRadius.all(Radius.circular(16));
  static const BorderRadius buttonRadius = BorderRadius.all(Radius.circular(12));
  static const BorderRadius inputRadius = BorderRadius.all(Radius.circular(8));

  static BoxShadow cardShadow = BoxShadow(
    color: Colors.black.withValues(alpha: 0.1),
    blurRadius: 8,
    offset: const Offset(0, 2),
  );

  static BoxShadow elevatedShadow = BoxShadow(
    color: Colors.black.withValues(alpha: 0.15),
    blurRadius: 12,
    offset: const Offset(0, 4),
  );
}