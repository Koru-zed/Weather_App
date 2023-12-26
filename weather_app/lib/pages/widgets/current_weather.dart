import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_data/current_day.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/controller.dart';

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
      children: [currentData(), moreDetails(), HourlyDetail()],
    );
  }

  Widget currentData() {
    return Container(
        margin: const EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 10),
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
        margin: const EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 2),
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3, (index) {
              return Column(
                children: [
                  Tooltip(
                    message: items[index],
                    child: Container(
                      height: 60,
                      width: 60,
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .tertiary
                              .withOpacity(0.3),
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

  Widget HourlyDetail() {
    return Container(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 12,
            itemBuilder: (context, index) {
              return Obx(() => GestureDetector(
                    child: Container(
                      height: 90,
                      width: 50,
                      color: Theme.of(context).,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('$index:00'),
                          Container(
                            child: Image.asset('assets/icons/.png'),
                          ),
                          Text('10°')
                        ],
                      ),
                  )));
            }));
  }
}
