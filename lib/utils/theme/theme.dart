import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = _buildTheme(Brightness.light);
  static final ThemeData darkTheme = _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: brightness,
    );
    final border = OutlineInputBorder(
      borderSide: BorderSide(color: colorScheme.outline),
    );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        prefixIconColor: colorScheme.onSurfaceVariant,
        border: border,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: border.copyWith(
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: border.copyWith(
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          minimumSize: const Size.fromHeight(48),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: colorScheme.primary),
      ),
    );
  }
}
