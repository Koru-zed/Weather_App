import 'package:flutter/material.dart';

// class CustomTheme {

//   // light theme
//   static final lightTheme = ThemeData(
//     // primaryColor: lightThemeColor,
//     // brightness: Brightness.light,
//     colorScheme: ColorScheme.light(brightness:  Brightness.light, primary: lightThemeColor, secondary: Colors.purple.shade200, background: Colors.white),

//     // scaffoldBackgroundColor: white,
//     useMaterial3: true,
//     switchTheme: SwitchThemeData(
//       thumbColor:
//           MaterialStateProperty.resolveWith<Color>((states) => lightThemeColor),
//     ),
//     // appBarTheme: AppBarTheme(
//     //   centerTitle: true,
//     //   backgroundColor: white,
//     //   scrolledUnderElevation: 0,
//     //   titleTextStyle: TextStyle(
//     //     fontWeight: FontWeight.w500,
//     //     color: black,
//     //     fontSize: 23, //20
//     //   ),
//     //   iconTheme: IconThemeData(color: lightThemeColor),
//     //   elevation: 0,
//     //   actionsIconTheme: IconThemeData(color: lightThemeColor),
//     // ),
//   );

//   // dark theme
//   static final darkTheme = ThemeData(
//     colorScheme: ColorScheme.dark(brightness:  Brightness.dark, primary: darkThemeColor, secondary: Colors.red.shade400, background: Colors.blueGrey.shade900),

//     // primaryColor: darkThemeColor,
//     // brightness: Brightness.dark,
//     // scaffoldBackgroundColor: black,
//     useMaterial3: true,
//     switchTheme: SwitchThemeData(
//       trackColor:
//           MaterialStateProperty.resolveWith<Color>((states) => darkThemeColor),
//     ),
//     // appBarTheme: AppBarTheme(
//     //   centerTitle: true,
//     //   backgroundColor: black,
//     //   scrolledUnderElevation: 0,
//     //   titleTextStyle: TextStyle(
//     //     fontWeight: FontWeight.w500,
//     //     color: white,
//     //     fontSize: 23, //20
//     //   ),
//     //   iconTheme: IconThemeData(color: darkThemeColor),
//     //   elevation: 0,
//     //   actionsIconTheme: IconThemeData(color: darkThemeColor),
//     // ),
//   );

//   // colors
//   static Color lightThemeColor = Colors.red,
//       white = Colors.white,
//       black = Colors.black,
//       darkThemeColor = Colors.yellow;
// }

class CustomTheme {
    // colors

  // light theme
  static final lightTheme = ThemeData(

    colorScheme: ColorScheme.light(
      brightness:  Brightness.light,
      primary: Colors.black, 
      secondary: Colors.blue.shade300, 
      tertiary: Colors.grey.shade700,
      background: Colors.white),
    useMaterial3: true,
  );

  // dark theme
  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(
      brightness:  Brightness.dark, 
      primary: Colors.white, 
      secondary: Colors.blue.shade300, 
      tertiary: Colors.grey.shade400,
      background: const Color.fromARGB(255, 31, 37, 45)),
    useMaterial3: true,
  );


}
