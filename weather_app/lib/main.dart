import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/views/detail_of_day.dart';
import 'package:weather_app/views/home_view.dart';
import 'models/theme_model.dart';

void main() {
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

