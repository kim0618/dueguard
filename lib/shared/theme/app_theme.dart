import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF1A1D26);
  static const Color onPrimary = Colors.white;
  static const Color background = Color(0xFFFAFAFB);
  static const Color surface = Colors.white;
  static const Color onSurface = Color(0xFF171A21);
  static const Color surfaceVariant = Color(0xFFF1F2F5);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9BA8BC);
  static const Color dividerColor = Color(0xFFE8ECF4);
  static const Color dividerLight = Color(0xFFF0F3F9);
  static const Color error = Color(0xFFE5484D);
  static const Color onError = Colors.white;
  static const Color todayAccent = Color(0xFFE5484D);
  static const Color warnAccent = Color(0xFFF59E0B);
  static const Color infoAccent = Color(0xFF4F7DF3);
  static const Color successAccent = Color(0xFF22A06B);

  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: const Color(0xFF0F172A).withValues(alpha: 0.08),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ];

  static List<BoxShadow> get cardShadowSm => [
        BoxShadow(
          color: const Color(0xFF0F172A).withValues(alpha: 0.05),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get buttonShadow => [
        BoxShadow(
          color: const Color(0xFF0F172A).withValues(alpha: 0.20),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ];

  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
      primary: primary,
      onPrimary: onPrimary,
      surface: surface,
      onSurface: onSurface,
      error: error,
      onError: onError,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: onSurface,
          letterSpacing: -0.3,
        ),
        iconTheme: IconThemeData(color: onSurface),
      ),
      cardTheme: CardTheme(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.zero,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: onPrimary,
        elevation: 0,
        shape: StadiumBorder(),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          minimumSize: const Size.fromHeight(52),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: error,
          minimumSize: const Size.fromHeight(48),
          side: BorderSide(color: error.withValues(alpha: 0.25), width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: surfaceVariant,
        selectedColor: primary,
        checkmarkColor: Colors.white,
        labelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: BorderSide.none,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: dividerColor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: dividerColor),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: primary, width: 2),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: error),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: error, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        labelStyle: const TextStyle(
            color: primary, fontSize: 10, fontWeight: FontWeight.w700),
        hintStyle: TextStyle(color: textTertiary),
      ),
      dividerTheme: const DividerThemeData(
        color: dividerLight,
        space: 1,
        thickness: 1,
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: surface,
        hourMinuteColor: WidgetStateColor.resolveWith((states) =>
            states.contains(WidgetState.selected)
                ? primary.withValues(alpha: 0.08)
                : surfaceVariant),
        hourMinuteTextColor: WidgetStateColor.resolveWith((states) =>
            states.contains(WidgetState.selected) ? primary : onSurface),
        dayPeriodColor: WidgetStateColor.resolveWith((states) =>
            states.contains(WidgetState.selected)
                ? primary
                : surfaceVariant),
        dayPeriodTextColor: WidgetStateColor.resolveWith((states) =>
            states.contains(WidgetState.selected)
                ? Colors.white
                : textSecondary),
        dayPeriodBorderSide: BorderSide.none,
        dialBackgroundColor: surfaceVariant,
        dialHandColor: primary,
        dialTextColor: WidgetStateColor.resolveWith((states) =>
            states.contains(WidgetState.selected) ? Colors.white : onSurface),
        entryModeIconColor: textSecondary,
        helpTextStyle: const TextStyle(
            color: textSecondary, fontSize: 13, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: surface,
        headerBackgroundColor: primary,
        headerForegroundColor: Colors.white,
        dayForegroundColor: WidgetStateColor.resolveWith((states) =>
            states.contains(WidgetState.selected)
                ? Colors.white
                : onSurface),
        dayBackgroundColor: WidgetStateColor.resolveWith((states) =>
            states.contains(WidgetState.selected)
                ? primary
                : Colors.transparent),
        todayForegroundColor: WidgetStateColor.resolveWith((states) =>
            states.contains(WidgetState.selected) ? Colors.white : primary),
        todayBackgroundColor: WidgetStateColor.resolveWith((states) =>
            states.contains(WidgetState.selected)
                ? primary
                : Colors.transparent),
        todayBorder: const BorderSide(color: primary, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        titleTextStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: onSurface,
            letterSpacing: -0.2),
        contentTextStyle: const TextStyle(
            fontSize: 14, color: textSecondary, height: 1.5),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          textStyle:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
