import 'package:flutter/material.dart';

import '../enums/enums.dart';

class AppColors {

  const AppColors._();

  static const Color darkBackground = Color(0xFF0A0D14);

  static const Color darkSurfaceLifted = Color(0xFF0F1520);

  static const Color darkForeground = Color(0xFFF4F6FB);

  static const Color darkMutedForeground = Color(0xFF8A94A8);

  static const Color darkPrimary = Color(0xFFC8F34E);

  static const Color darkPrimaryForeground = Color(0xFF0A0D14);

  static const Color darkSecondary = Color(0xFF141A26);

  static const Color darkSecondaryForeground = Color(0xFFD9E0EC);

  static const Color darkCard = Color(0xFF141922);

  static const Color darkMuted = Color(0xFF1B2230);

  static const Color darkDestructive = Color(0xFFFF5C5C);
  static const Color darkDestructiveForeground = Color(0xFF0A0D14);

  static const Color darkBorder = Color(0xFF232B3A);

  static const Color darkRing = Color(0xFFC8F34E);

  static const Color darkInputBackground = Color(0xFF121824);

  static const Color darkIncome = Color(0xFF38D876);

  static const Color darkExpense = Color(0xFFFF6B6B);

  static const Color lightBackground = Color(0xFFF4F6FA);
  static const Color lightForeground = Color(0xFF11151D);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightCardForeground = Color(0xFF212A3B);
  static const Color lightPrimary = Color(0xFF3C7A00);
  static const Color lightPrimaryForeground = Color(0xFFFFFFFF);
  static const Color lightSecondary = Color(0xFFE9EDF5);
  static const Color lightSecondaryForeground = Color(0xFF171D2B);
  static const Color lightMuted = Color(0xFFE9EDF5);
  static const Color lightMutedForeground = Color(0xFF6A7488);
  static const Color lightDestructive = Color(0xFFE5533D);
  static const Color lightDestructiveForeground = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0x140A0D14);
  static const Color lightInputBackground = Color(0xFFFFFFFF);
  static const Color lightRing = Color(0xFF3C7A00);

  static const Color brandLime = Color(0xFFC8F34E);

  static const Color brandMint = Color(0xFF3EE6B6);

  static const Color accentViolet = Color(0xFF8B7CFF);

  static const Color accentCyan = Color(0xFF5CC9FF);

  static const Color incomeGreen = Color(0xFF2FDC7F);

  static const Color expenseRed = Color(0xFFFF6B6B);

  static const Color primaryGreen = Color(0xFF2FDC7F);

  static const Color ecoGradientStart = Color(0xFF2FA147);
  static const Color ecoGradientEnd = Color(0xFF6EE064);
  static const Color ecoGradientStartDark = Color(0xFF1E5B33);
  static const Color ecoGradientEndDark = Color(0xFF3CC47E);

  static const Color heroGradientStart = Color(0xFFB4EE4A);
  static const Color heroGradientEnd = Color(0xFF32D9A8);

  static const Color glowLime = Color(0xFF6DCB3B);
  static const Color glowViolet = Color(0xFF6A57E0);
  static const Color glowCyan = Color(0xFF2A9FD8);

  static const Color chart1 = Color(0xFFC8F34E);
  static const Color chart2 = Color(0xFF5CC9FF);
  static const Color chart3 = Color(0xFFFFB230);
  static const Color chart4 = Color(0xFF8B7CFF);
  static const Color chart5 = Color(0xFFFF6B9C);

  static const Color lightSidebar = Color(0xFFFAFAFA);
  static const Color lightSidebarForeground = Color(0xFF242424);
  static const Color lightSidebarPrimary = Color(0xFF0A0D14);
  static const Color lightSidebarPrimaryForeground = Color(0xFFF4F6FB);
  static const Color darkSidebar = Color(0xFF0F1520);
  static const Color darkSidebarForeground = Color(0xFFF4F6FB);
  static const Color darkSidebarPrimary = Color(0xFFC8F34E);
  static const Color darkSidebarPrimaryForeground = Color(0xFF0A0D14);

  static Color getColorFromTransactionType(ETransactionType type) {
    switch (type) {
      case ETransactionType.income:
        return incomeGreen;
      case ETransactionType.expense:
        return expenseRed;
    }
  }
}