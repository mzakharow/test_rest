import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.black12),
  scaffoldBackgroundColor: Colors.black12,
  primarySwatch: Colors.yellow,
  dividerColor: Colors.white24,
  listTileTheme: ListTileThemeData(iconColor: Colors.white),
  useMaterial3: true,
  appBarTheme: AppBarTheme(backgroundColor: Colors.black12),
  textTheme: TextTheme(
    bodyMedium: const TextStyle(
      color: Colors.green,
      fontWeight: FontWeight.w700,
      fontSize: 14,
    ),
    labelSmall: TextStyle(
      color: Colors.white.withOpacity(0.6),
      fontWeight: FontWeight.w700,
      fontSize: 10,
    ),
  ),
);