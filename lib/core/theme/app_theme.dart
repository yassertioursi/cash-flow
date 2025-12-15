import 'package:cashflow/features/settings/domain/enums/font_size_preference.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../features/settings/domain/enums/color_blind_mode.dart';
import 'app_colors.dart';
import 'extra_colors.dart';

class AppTheme {

  const AppTheme._();

  static String get fontFamily => GoogleFonts.plusJakartaSans().fontFamily!;
  static String get fontFamilyDisplay => GoogleFonts.spaceGrotesk().fontFamily!;

  static const double _radiusButton = 16.0;
  static const double _radiusInput = 14.0;
  static const double _radiusCard = 20.0;
  static const double _radiusDialog = 24.0;

  static const FontWeight _fontNormal = FontWeight.w400;
  static const FontWeight _fontMedium = FontWeight.w500;
  static const FontWeight _fontSemiBold = FontWeight.w600;
  static const FontWeight _fontBold = FontWeight.w700;

  static double getTextScaleFactor(FontSizePreference fontSize) {
    switch (fontSize) {
      case FontSizePreference.small:
        return 0.85;
      case FontSizePreference.medium:
        return 1.0;
      case FontSizePreference.large:
        return 1.15;
    }
  }

  static ThemeData _base(Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: fontFamily,
      visualDensity: VisualDensity.standard,
      splashFactory: InkSparkle.splashFactory,
    );
  }

  static ThemeData get lightTheme => _buildLight();

  static ThemeData get darkTheme => _buildDark();

  static ThemeData _buildDark() {
    final scheme = const ColorScheme.dark(
      primary: AppColors.darkPrimary,
      onPrimary: AppColors.darkPrimaryForeground,
      primaryContainer: Color(0xFF2A3908),
      onPrimaryContainer: Color(0xFFE5F5BE),
      secondary: AppColors.darkSecondary,
      onSecondary: AppColors.darkSecondaryForeground,
      secondaryContainer: Color(0xFF1B2230),
      onSecondaryContainer: AppColors.darkSecondaryForeground,
      tertiary: AppColors.accentCyan,
      onTertiary: Color(0xFF0A0D14),
      surface: AppColors.darkCard,
      onSurface: AppColors.darkForeground,
      onSurfaceVariant: AppColors.darkMutedForeground,
      surfaceContainerHighest: AppColors.darkMuted,
      error: AppColors.darkDestructive,
      onError: Color(0xFF0A0D14),
      outline: AppColors.darkBorder,
      outlineVariant: AppColors.darkBorder,
      scrim: Color(0x99000000),
    );

    final base = _base(Brightness.dark).copyWith(
      colorScheme: scheme,
      scaffoldBackgroundColor: Colors.transparent,
    );

    return base.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.darkForeground),
        titleTextStyle: const TextStyle(
          fontSize: 19,
          fontWeight: _fontSemiBold,
          color: AppColors.darkForeground,
        ),
      ),
      textTheme: _textTheme(Brightness.dark),
      inputDecorationTheme: _inputDecoration(Brightness.dark),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkPrimary,
          foregroundColor: AppColors.darkPrimaryForeground,
          minimumSize: const Size(0, 52),
          elevation: 0,
          shadowColor: AppColors.darkPrimary.withValues(alpha: 0.35),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: _fontBold,
            letterSpacing: 0.2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radiusButton),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.darkPrimary,
          foregroundColor: AppColors.darkPrimaryForeground,
          minimumSize: const Size(0, 52),
          elevation: 0,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: _fontBold,
            letterSpacing: 0.2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radiusButton),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.darkPrimary,
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: _fontSemiBold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radiusButton),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.darkForeground,
          minimumSize: const Size(0, 52),
          side: const BorderSide(color: AppColors.darkBorder),
          textStyle: const TextStyle(fontSize: 15, fontWeight: _fontSemiBold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radiusButton),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.darkPrimary,
        foregroundColor: AppColors.darkPrimaryForeground,
        elevation: 6,
        focusElevation: 8,
        hoverElevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        sizeConstraints: const BoxConstraints.tightFor(width: 60, height: 60),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkCard,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radiusCard),
          side: const BorderSide(color: AppColors.darkBorder),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFF141924),
        indicatorColor: AppColors.darkPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        height: 72,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return TextStyle(
            fontSize: 12,
            fontWeight: _fontSemiBold,
            letterSpacing: 0.1,
            color: selected ? AppColors.darkForeground : AppColors.darkMutedForeground,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? AppColors.darkPrimaryForeground : AppColors.darkMutedForeground,
          );
        }),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.darkSecondary,
        selectedColor: AppColors.darkPrimary.withValues(alpha: 0.18),
        labelStyle: const TextStyle(
          color: AppColors.darkForeground,
          fontWeight: _fontMedium,
        ),
        secondaryLabelStyle: const TextStyle(
          color: AppColors.darkPrimary,
          fontWeight: _fontSemiBold,
        ),
        side: const BorderSide(color: AppColors.darkBorder),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.darkBorder,
        thickness: 1,
        space: 1,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: const Color(0xFF141A26),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radiusDialog),
          side: const BorderSide(color: AppColors.darkBorder),
        ),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: _fontSemiBold,
          color: AppColors.darkForeground,
        ),
        contentTextStyle: const TextStyle(
          fontSize: 15,
          height: 1.5,
          color: AppColors.darkMutedForeground,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: const Color(0xFF141A26),
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(_radiusDialog)),
        ),
        showDragHandle: false,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: const Color(0xFF1B2230),
        contentTextStyle: const TextStyle(
          fontSize: 15,
          fontWeight: _fontSemiBold,
          color: AppColors.darkForeground,
        ),
        actionTextColor: AppColors.darkPrimary,
        behavior: SnackBarBehavior.floating,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: AppColors.darkBorder),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.darkPrimary;
          }
          return AppColors.darkMutedForeground;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.darkPrimary.withValues(alpha: 0.28);
          }
          return AppColors.darkBorder;
        }),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.darkPrimary,
        linearTrackColor: AppColors.darkBorder,
        circularTrackColor: AppColors.darkBorder,
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.darkPrimary
              : AppColors.darkMutedForeground,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.darkPrimary
              : Colors.transparent,
        ),
        checkColor: WidgetStateProperty.all(AppColors.darkPrimaryForeground),
        side: const BorderSide(color: AppColors.darkMutedForeground, width: 1.6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      extensions: [
        const ExtraColors(
          sidebar: AppColors.darkSidebar,
          sidebarForeground: AppColors.darkSidebarForeground,
          sidebarPrimary: AppColors.darkSidebarPrimary,
          sidebarPrimaryForeground: AppColors.darkSidebarPrimaryForeground,
          sidebarBorder: AppColors.darkBorder,
          ring: AppColors.darkRing,
          chart1: AppColors.chart1,
          chart2: AppColors.chart2,
          chart3: AppColors.chart3,
          chart4: AppColors.chart4,
          chart5: AppColors.chart5,
        ),
      ],
    );
  }

  static ThemeData _buildLight() {
    final scheme = const ColorScheme.light(
      primary: AppColors.lightPrimary,
      onPrimary: AppColors.lightPrimaryForeground,
      primaryContainer: Color(0xFFE4F5CB),
      onPrimaryContainer: Color(0xFF15240A),
      secondary: AppColors.lightSecondary,
      onSecondary: AppColors.lightSecondaryForeground,
      surface: AppColors.lightCard,
      onSurface: AppColors.lightForeground,
      onSurfaceVariant: AppColors.lightMutedForeground,
      error: AppColors.lightDestructive,
      onError: Colors.white,
      outline: AppColors.lightBorder,
      outlineVariant: AppColors.lightBorder,
      scrim: Color(0x66000000),
    );

    final base = _base(Brightness.light).copyWith(
      colorScheme: scheme,
      scaffoldBackgroundColor: Colors.transparent,
    );

    return base.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.lightForeground),
        titleTextStyle: const TextStyle(
          fontSize: 19,
          fontWeight: _fontSemiBold,
          color: AppColors.lightForeground,
        ),
      ),
      textTheme: _textTheme(Brightness.light),
      inputDecorationTheme: _inputDecoration(Brightness.light),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightPrimary,
          foregroundColor: Colors.white,
          minimumSize: const Size(0, 52),
          elevation: 0,
          textStyle: const TextStyle(fontSize: 16, fontWeight: _fontBold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radiusButton),
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.lightPrimary,
          foregroundColor: Colors.white,
          minimumSize: const Size(0, 52),
          elevation: 0,
          textStyle: const TextStyle(fontSize: 16, fontWeight: _fontBold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radiusButton),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.lightPrimary,
          textStyle: const TextStyle(fontSize: 15, fontWeight: _fontSemiBold),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.lightForeground,
          minimumSize: const Size(0, 52),
          side: const BorderSide(color: AppColors.lightBorder),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_radiusButton),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.lightPrimary,
        foregroundColor: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        sizeConstraints: const BoxConstraints.tightFor(width: 60, height: 60),
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightCard,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radiusCard),
          side: const BorderSide(color: AppColors.lightBorder),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: AppColors.lightPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        height: 72,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return TextStyle(
            fontSize: 12,
            fontWeight: _fontSemiBold,
            color: selected ? AppColors.lightForeground : AppColors.lightMutedForeground,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? Colors.white : AppColors.lightMutedForeground,
          );
        }),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: const Color(0xFF1B2230),
        contentTextStyle: const TextStyle(
          fontSize: 15,
          fontWeight: _fontSemiBold,
          color: Colors.white,
        ),
        actionTextColor: AppColors.brandLime,
        behavior: SnackBarBehavior.floating,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_radiusDialog),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(_radiusDialog)),
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.lightPrimary,
      ),
      extensions: [
        const ExtraColors(
          sidebar: AppColors.lightSidebar,
          sidebarForeground: AppColors.lightSidebarForeground,
          sidebarPrimary: AppColors.lightSidebarPrimary,
          sidebarPrimaryForeground: AppColors.lightSidebarPrimaryForeground,
          sidebarBorder: AppColors.lightBorder,
          ring: AppColors.lightRing,
          chart1: AppColors.chart1,
          chart2: AppColors.chart2,
          chart3: AppColors.chart3,
          chart4: AppColors.chart4,
          chart5: AppColors.chart5,
        ),
      ],
    );
  }

  static TextTheme _textTheme(Brightness brightness) {
    final dark = brightness == Brightness.dark;
    final fg = dark ? AppColors.darkForeground : AppColors.lightForeground;
    final muted = dark ? AppColors.darkMutedForeground : AppColors.lightMutedForeground;

    const tabular = FontFeature.tabularFigures();

    return TextTheme(
      displayLarge: GoogleFonts.spaceGrotesk(
        fontSize: 36,
        fontWeight: _fontBold,
        height: 1.15,
        letterSpacing: -0.5,
        color: fg,
        fontFeatures: [tabular],
      ),
      displayMedium: GoogleFonts.spaceGrotesk(
        fontSize: 28,
        fontWeight: _fontBold,
        height: 1.2,
        letterSpacing: -0.3,
        color: fg,
        fontFeatures: [tabular],
      ),
      displaySmall: GoogleFonts.spaceGrotesk(
        fontSize: 24,
        fontWeight: _fontSemiBold,
        height: 1.25,
        letterSpacing: -0.2,
        color: fg,
        fontFeatures: [tabular],
      ),
      headlineMedium: GoogleFonts.plusJakartaSans(
        fontSize: 22,
        fontWeight: _fontSemiBold,
        height: 1.3,
        color: fg,
        fontFeatures: [tabular],
      ),
      titleLarge: GoogleFonts.plusJakartaSans(
        fontSize: 20,
        fontWeight: _fontSemiBold,
        height: 1.35,
        color: fg,
        fontFeatures: [tabular],
      ),
      titleMedium: GoogleFonts.plusJakartaSans(
        fontSize: 17,
        fontWeight: _fontSemiBold,
        height: 1.4,
        color: fg,
        fontFeatures: [tabular],
      ),
      titleSmall: GoogleFonts.plusJakartaSans(
        fontSize: 15,
        fontWeight: _fontMedium,
        height: 1.4,
        color: fg,
        fontFeatures: [tabular],
      ),
      bodyLarge: GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: _fontNormal,
        height: 1.5,
        color: fg,
        fontFeatures: [tabular],
      ),
      bodyMedium: GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: _fontNormal,
        height: 1.5,
        color: fg,
        fontFeatures: [tabular],
      ),
      bodySmall: GoogleFonts.plusJakartaSans(
        fontSize: 13,
        fontWeight: _fontNormal,
        height: 1.45,
        color: muted,
        fontFeatures: [tabular],
      ),
      labelLarge: GoogleFonts.plusJakartaSans(
        fontSize: 15,
        fontWeight: _fontBold,
        letterSpacing: 0.2,
        color: fg,
        fontFeatures: [tabular],
      ),
      labelMedium: GoogleFonts.plusJakartaSans(
        fontSize: 13,
        fontWeight: _fontMedium,
        letterSpacing: 0.1,
        color: muted,
        fontFeatures: [tabular],
      ),
      labelSmall: GoogleFonts.plusJakartaSans(
        fontSize: 11,
        fontWeight: _fontSemiBold,
        letterSpacing: 0.3,
        color: muted,
        fontFeatures: [tabular],
      ),
    );
  }

  static InputDecorationTheme _inputDecoration(Brightness brightness) {
    final dark = brightness == Brightness.dark;
    const radius = _radiusInput;

    final fill = dark ? AppColors.darkInputBackground : AppColors.lightInputBackground;
    final border = dark ? AppColors.darkBorder : AppColors.lightBorder;
    final ring = dark ? AppColors.darkRing : AppColors.lightRing;
    final hint = (dark ? AppColors.darkMutedForeground : AppColors.lightMutedForeground);

    final defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: border, width: 1),
    );

    return InputDecorationTheme(
      filled: true,
      fillColor: fill,
      hintStyle: TextStyle(
        fontSize: 14,
        fontWeight: _fontMedium,
        color: hint.withValues(alpha: 0.9),
      ),
      labelStyle: TextStyle(fontSize: 14, fontWeight: _fontMedium, color: hint),
      prefixIconColor: hint,
      suffixIconColor: hint,
      floatingLabelStyle: TextStyle(
        fontSize: 13,
        fontWeight: _fontSemiBold,
        color: dark ? AppColors.darkPrimary : AppColors.lightPrimary,
      ),
      border: defaultBorder,
      enabledBorder: defaultBorder,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: ring, width: 1.6),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: AppColors.darkDestructive, width: 1.2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: AppColors.darkDestructive, width: 1.6),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
    );
  }

  static ColorFilter getColorFilter(ColorBlindMode mode) {
    switch (mode) {
      case ColorBlindMode.none:
        return const ColorFilter.matrix(<double>[1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0]);
      case ColorBlindMode.protanopia:
        return const ColorFilter.matrix(
            <double>[0.567, 0.433, 0, 0, 0, 0.558, 0.442, 0, 0, 0, 0, 0.242, 0.758, 0, 0, 0, 0, 0, 1, 0]);
      case ColorBlindMode.deuteranopia:
        return const ColorFilter.matrix(
            <double>[0.625, 0.375, 0, 0, 0, 0.7, 0.3, 0, 0, 0, 0, 0.3, 0.7, 0, 0, 0, 0, 0, 1, 0]);
      case ColorBlindMode.tritanopia:
        return const ColorFilter.matrix(
            <double>[0.95, 0.05, 0, 0, 0, 0, 0.433, 0.567, 0, 0, 0, 0.475, 0.525, 0, 0, 0, 0, 0, 1, 0]);
    }
  }
}