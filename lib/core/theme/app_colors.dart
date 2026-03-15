import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Brand ───────────────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryLight = Color(0xFFEBEAFF);
  static const Color primaryDark = Color(0xFF4B44CC);
  static const Color secondary = Color(0xFFFF6584);
  static const Color accent = Color(0xFF43CBFF);

  // ── Semantic ─────────────────────────────────────────────────────────────────
  static const Color success = Color(0xFF27AE60);
  static const Color warning = Color(0xFFF2994A);
  static const Color error = Color(0xFFEB5757);
  static const Color info = Color(0xFF2F80ED);

  // ── Neutrals ─────────────────────────────────────────────────────────────────
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color background = Color(0xFFF7F8FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color inputFill = Color(0xFFF2F3F7);
  static const Color divider = Color(0xFFEEEEEE);
  static const Color border = Color(0xFFE0E0E0);
  static const Color shadow = Color(0x0D000000);

  // ── Text ─────────────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint = Color(0xFFADB5BD);

  // ── Service Domain Colors ────────────────────────────────────────────────────
  static const Color ecommerce = Color(0xFF6C63FF);
  static const Color grocery = Color(0xFF27AE60);
  static const Color pharmacy = Color(0xFF2F80ED);
  static const Color food = Color(0xFFF2994A);
  static const Color ride = Color(0xFF9B59B6);
  static const Color courier = Color(0xFF16213E);
  static const Color onDemand = Color(0xFFEB5757);

  // ── Gradient Presets ─────────────────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF6C63FF), Color(0xFF9B59B6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
