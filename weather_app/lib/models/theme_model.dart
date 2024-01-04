import 'package:flutter/material.dart';

class CustomTheme {
  // colors

  // light theme
  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
        brightness: Brightness.light,
        primary: Colors.black,
        secondary: Colors.blue.shade300,
        tertiary: Colors.grey.shade700,
        background: Colors.white),
    useMaterial3: true,
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color.fromARGB(255, 136, 148, 157),
    )
  );

  // dark theme
  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(
        brightness: Brightness.dark,
        primary: Colors.white,
        secondary: Colors.blue.shade300,
        tertiary: Colors.grey.shade400,
        background: const Color.fromARGB(255, 31, 37, 45)),
    useMaterial3: true,
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color.fromARGB(255, 39, 41, 44),
    )
  );
}
