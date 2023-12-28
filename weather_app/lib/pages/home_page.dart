import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/controller.dart';
import 'package:weather_app/pages/widgets/daily_weather.dart';
import 'package:weather_app/pages/widgets/header.dart';
import 'package:weather_app/pages/widgets/current_weather.dart';
import 'package:weather_app/pages/widgets/hourly_weather.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalController _controller = Get.put(GlobalController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
      child: Obx(
        () => _controller.loading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              )
            : ListView(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () => _controller.switchTheme(),
                        tooltip: 'Change Theme',
                        icon: Icon(
                          Icons.dark_mode_outlined,
                          color: Theme.of(context).colorScheme.secondary,
                        )),
                  ),
                  const Header(),
                  const CurrentWeather(),
                  const DailyWeather()

                  // HourlyWeather(currentDay: _controller.weatherData.current!),
                ],
              ),
      ),
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
