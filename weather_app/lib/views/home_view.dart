import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/controller.dart';
import 'package:weather_app/models/fake_data.dart';
import 'package:weather_app/models/weather_data/weather_data.dart';
import 'package:weather_app/pages/widgets/daily_weather.dart';
import 'package:weather_app/pages/widgets/get_data.dart';
import 'package:weather_app/pages/widgets/header.dart';
import 'package:weather_app/pages/widgets/current_weather.dart';
import 'package:weather_app/views/drawer_view.dart';

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
    _controller.weatherData.value = WeatherData.fromJson(fake_data);
    _controller.isLoading.value = false;
    _controller.city.value = 'London';
    // if (_controller.isLoading.isTrue) _controller.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    _controller.width.value = MediaQuery.of(context).size.width;
    _controller.isDark.value =
        Theme.of(context).colorScheme.brightness == Brightness.light
            ? false
            : true;

    return SafeArea(
      child: Scaffold(
        drawer: const MyDrawer(),
        body: Obx(
          () => _controller.isLoading.value
              ? const GetData()
              : RefreshIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                  onRefresh: () => _controller.fetchData(
                      _controller.weatherData.value.latitude!.value,
                      _controller.weatherData.value.longitude!.value),
                  child: _buildContent(),
                ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 600.0,
        ),
        child: ListView(
          children: const [
            Header(),
            CurrentWeather(),
            DailyWeather(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}


