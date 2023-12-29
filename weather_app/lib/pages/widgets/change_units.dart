import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:weather_app/controllers/controller.dart';
import 'package:weather_app/models/weather_data/day.dart';
import 'package:weather_app/models/weather_data/hour.dart';

final List<String> items = ['°C/km', '°F/miles', '°C/miles'];

class ChangeUnits extends StatefulWidget {
  const ChangeUnits({super.key});

  @override
  State<ChangeUnits> createState() => ChangeUnitsState();
}

class ChangeUnitsState extends State<ChangeUnits> {
  String _selectedMenu = items[0];

  final GlobalController _controller = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    List<Day> days = _controller.weatherData.days!;

    return MenuAnchor(
      builder:
          (BuildContext context, MenuController controller, Widget? child) {
        return Row(
          children: [
            Text(
              _selectedMenu,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
              icon: Icon(Icons.more_horiz,
                  color: Theme.of(context).colorScheme.secondary),
              tooltip: 'Change Units',
            ),
          ],
        );
      },
      menuChildren: List<MenuItemButton>.generate(
        3,
        (int index) => MenuItemButton(
          onPressed: () {
            if (index == 0 && _selectedMenu != items[0]) {
              _controller.units.value = ['C', 'km'];
              if (_selectedMenu == items[1]) {
                days.forEach((Day day) {
                  day.tempmax!.value = _controller.weatherData
                      .fahrenheitToCelsius(day.tempmax!.value);
                  day.tempmin!.value = _controller.weatherData
                      .fahrenheitToCelsius(day.tempmin!.value);
                  day.hours!.forEach((Hour hour) {
                    hour.temp!.value = _controller.weatherData
                        .fahrenheitToCelsius(hour.temp!.value);
                    hour.windspeed!.value = _controller.weatherData
                        .milesToKilometers(hour.windspeed!.value);
                  });
                });
              } else if (_selectedMenu == items[2]) {
                days.forEach((Day day) {
                  day.hours!.forEach((Hour hour) {
                    hour.windspeed!.value = _controller.weatherData
                        .milesToKilometers(hour.windspeed!.value);
                  });
                });
              }
            } else if (index == 1 && _selectedMenu != items[1]) {
              _controller.units.value = ['F', 'miles'];
                days.forEach((Day day) {
                  day.tempmax!.value = _controller.weatherData
                      .celsiusToFahrenheit(day.tempmax!.value);
                  day.tempmin!.value = _controller.weatherData
                      .celsiusToFahrenheit(day.tempmin!.value);
                  day.hours!.forEach((Hour hour) {
                    hour.temp!.value = _controller.weatherData
                        .celsiusToFahrenheit(hour.temp!.value);
                    if (_selectedMenu == items[2]) {
                      hour.windspeed!.value = _controller.weatherData
                          .kilometersToMiles(hour.windspeed!.value);
                    }
                  });
                });
            } else if (index == 2 && _selectedMenu != items[2]) {
              _controller.units.value = ['C', 'miles'];
              if (_selectedMenu == items[0]) {
                days.forEach((Day day) {
                  day.hours!.forEach((Hour hour) {
                    hour.windspeed!.value = _controller.weatherData
                        .kilometersToMiles(hour.windspeed!.value);
                  });
                });
              } else if (_selectedMenu == items[1]) {
                days.forEach((Day day) {
                  day.tempmax!.value = _controller.weatherData
                      .fahrenheitToCelsius(day.tempmax!.value);
                  day.tempmin!.value = _controller.weatherData
                      .fahrenheitToCelsius(day.tempmin!.value);
                  day.hours!.forEach((Hour hour) {
                    hour.temp!.value = _controller.weatherData
                        .fahrenheitToCelsius(hour.temp!.value);
                  });
                });
              }
            }
            setState(() => _selectedMenu = items[index]);
          },
          child: Container(
            margin: const EdgeInsets.all(4), // Add margin here
            child: Text(
              items[index],
            ),
          ),
        ),
      ),
    );
  }
}
