import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_app/views/detail_of_day.dart';
import 'package:weather_app/views/home_view.dart';
import 'models/theme_model.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Weather',
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const Home(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const Home()),
        GetPage(
          name: '/detail_day',
          page: () => const DetailOfDay(),
          transition: Transition.cupertino
        ),
      ],
    );
  }
}

// import 'dart:ui';

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Variable Font Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         fontFamily: 'Saira',
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Variable Font Example'),
//       ),
//       body: const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Regular Width',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.normal,
//               ),
//             ),
//             Text(
//               'Wide Width',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontVariations: [ FontVariation('wght', (300))], // Adjust fontWeight for width
//               ),
//             ),
//             Text(
//               'Italic Style',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontStyle: FontStyle.italic,
//               ),
//             ),
//             Text(
//               'Wide and Italic',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.w700,
//                 fontStyle: FontStyle.italic,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
