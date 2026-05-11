import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class PawLogo extends StatelessWidget {
  final double size;
  final Color? color;

  const PawLogo({
    super.key,
    this.size = 80,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
        boxShadow: [AppShapes.cardShadow],
      ),
      child: Icon(
        Icons.pets,
        size: size * 0.5,
        color: color ?? Colors.white,
      ),
    );
  }
}

class PawIcon extends StatelessWidget {
  final double size;
  final Color? color;

  const PawIcon({
    super.key,
    this.size = 24,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.pets,
      size: size,
      color: color ?? AppColors.primary,
    );
  }
}