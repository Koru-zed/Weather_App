import 'package:flutter/material.dart';

class CustomTheme {
  // colors

  // light theme
  static final lightTheme = ThemeData(
      colorScheme: ColorScheme.light(
          brightness: Brightness.light,
          primary: Colors.black,
          secondary: Colors.blue.shade700,
          tertiary: const Color.fromARGB(255, 0, 0, 0),
          background:const Color.fromARGB(255, 234, 234, 234)),
      useMaterial3: true,
      drawerTheme: DrawerThemeData(
        backgroundColor: const Color.fromARGB(255, 234, 234, 234).withOpacity(0.95),
      ));

  // dark theme
  static final darkTheme = ThemeData(
      colorScheme: ColorScheme.dark(
          brightness: Brightness.dark,
          primary: Colors.white,
          secondary: Colors.blue.shade300,
          tertiary: Colors.grey.shade400,
          background: const Color.fromARGB(255, 31, 37, 45)),
      useMaterial3: true,
      drawerTheme: DrawerThemeData(
        backgroundColor:const Color.fromARGB(255, 31, 37, 45).withOpacity(0.95),
      ));
}
