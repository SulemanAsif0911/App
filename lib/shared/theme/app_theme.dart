
import 'package:flutter/material.dart';

class AppColors {
  static const bg = Color(0xFF05080D);
  static const surface = Color(0xFF0D1520);
  static const card = Color(0xFF121C28);
  static const border = Color(0x3322D3EE);
  static const accent = Color(0xFF22D3EE);
  static const accentDim = Color(0xFF0E7490);
  static const text = Color(0xFFE8F1F8);
  static const muted = Color(0xFF93A4B5);
  static const danger = Color(0xFFF87171);
  static const ok = Color(0xFF34D399);
}

class AppTheme {
  static ThemeData get dark {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.bg,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accent,
        surface: AppColors.surface,
        error: AppColors.danger,
      ),
    );
    return base.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 1.2, color: AppColors.text),
      ),
    );
  }
}
