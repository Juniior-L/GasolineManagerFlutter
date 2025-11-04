import 'package:flutter/material.dart';

ThemeData customTheme = ThemeData(
  useMaterial3: true,

  // 🎨 Esquema de cores principal
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),

  // 🧭 AppBar
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.teal,
    foregroundColor: Colors.white,
    elevation: 4,
    centerTitle: true,
  ),

  // 🔘 Botão elevado (ex: Entrar)
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.teal,
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 50),
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
  ),

  // ⭕ Botão contornado (ex: Cadastrar)
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.teal.shade700,
      side: BorderSide(color: Colors.teal.shade400, width: 1.5),
      minimumSize: const Size(double.infinity, 50),
      textStyle: const TextStyle(fontSize: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
  ),

  // 🔤 Botão de texto (ex: Sair)
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.redAccent,
      textStyle: const TextStyle(fontSize: 16),
    ),
  ),

  // 📝 Campos de texto
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade400),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.teal, width: 2),
    ),
    labelStyle: const TextStyle(color: Colors.black54),
    prefixIconColor: Colors.teal,
  ),

  // 🖋️ Estilo de texto global
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    bodyMedium: TextStyle(fontSize: 16, color: Colors.black54),
  ),
);