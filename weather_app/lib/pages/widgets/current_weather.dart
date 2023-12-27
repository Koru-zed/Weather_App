import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_data/current_day.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/controller.dart';
import 'package:weather_app/pages/widgets/hourly_weather.dart';

class CurrentWeather extends StatefulWidget {
  final CurrentDay currentDay;

  const CurrentWeather({Key? key, required this.currentDay}) : super(key: key);

  @override
  _CurrentWeatherState createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  final GlobalController _controller = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [currentData(), moreDetails(), HourlyWeather(currentDay: _controller.weatherData.days![2])],
    );
  }

  Widget currentData() {
    final double margin_hoz = MediaQuery.of(context).size.width * 0.05;

    return Container(
        margin: EdgeInsets.only(
            left: margin_hoz, right: margin_hoz, top: 5, bottom: 5),
        child: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  padding: const EdgeInsets.all(3),
                  child: Image.asset(
                    'assets/weather/${widget.currentDay.icon}.png',
                  ),
                ),
                Container(
                  height: 50,
                  width: 1.5,
                  color: Theme.of(context).colorScheme.secondary,
                  // decoration: BoxDecoration(borderRadius: BorderRadius.circular(1)),
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: '${_controller.temp}',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 60,
                          fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: '°',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 60),
                    ),
                    TextSpan(
                      text: '${widget.currentDay.conditions}',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 13.5),
                    )
                  ]),
                ),
              ],
            )));
  }

  Widget moreDetails() {
    final items = <String>['cloudcover', 'windspeed', 'humidity'];
    final double margin_hoz = MediaQuery.of(context).size.width * 0.07;

    String getDetail(String name) {
      switch (name) {
        case 'cloudcover':
          return '${_controller.cloudcover}%';
        case 'humidity':
          return '${_controller.humidity}%';
        case 'windspeed':
          return '${_controller.windspeed}${_controller.units[1]}/h';
        // Add more cases for other properties
        default:
          throw Exception('Property $name not found');
      }
    }

    return Container(
        margin: EdgeInsets.only(
            left: margin_hoz, right: margin_hoz, top: 5, bottom: 2),
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3, (index) {
              return Column(
                children: [
                  Tooltip(
                    message: items[index],
                    child: Container(
                      height: 55,
                      width: 55,
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .tertiary
                              .withOpacity(0.25),
                          borderRadius: BorderRadius.circular(
                            20,
                          )),
                      child: Image.asset(
                        'assets/icons/${items[index]}.png',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(getDetail(items[index]),
                      style: const TextStyle(fontSize: 13))
                ],
              );
            }),
          ),
        ));
  }
}
