import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/controller.dart';
import 'package:weather_app/pages/widgets/daily_weather.dart';
import 'package:weather_app/pages/widgets/header.dart';
import 'package:weather_app/pages/widgets/current_weather.dart';
import 'package:weather_app/pages/widgets/hourly_weather.dart';
import 'package:weather_app/pages/widgets/search_location.dart';

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

    ever<bool>(_controller.changeCity, (changeCity) {
      print('to change ----');
      if (changeCity) {
        _controller.getNewLocation();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
      child: Obx(
        () => _controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              )
            : RefreshIndicator(
                color: Theme.of(context).colorScheme.secondary,
                onRefresh: () => _controller.fetchData(
                    _controller.weatherData.value.latitude!.value,
                    _controller.weatherData.value.longitude!.value),
                child: _buildContent(),
              ),
      ),
    ));
  }

  Widget _buildContent() {
    return ListView(
      children: const [
        Header(),
        CurrentWeather(),
        DailyWeather(),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
