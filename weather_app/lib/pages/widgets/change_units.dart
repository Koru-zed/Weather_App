import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:weather_app/controllers/controller.dart';

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
    return MenuAnchor(
      builder:
          (BuildContext context, MenuController controller, Widget? child) {
        return Row(
          children: [
            Text(
              _selectedMenu,
              style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.bold),
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
              _controller.units = ['C', 'km'].obs; 
              if (_selectedMenu == items[1]) {
                _controller.temp.value = _controller.weatherData
                    .fahrenheitToCelsius(_controller.temp.value);
                _controller.windspeed.value =
                    _controller.weatherData.milesToKilometers(_controller.windspeed.value);
              } else if (_selectedMenu == items[2]) {
                _controller.windspeed.value =
                    _controller.weatherData.milesToKilometers(_controller.windspeed.value);
              }
            } else if (index == 1 && _selectedMenu != items[1]) {
              _controller.units = ['F', 'miles'].obs; 
              if (_selectedMenu == items[0]) {
                _controller.temp.value = _controller.weatherData
                    .celsiusToFahrenheit(_controller.temp.value);
                _controller.windspeed.value =
                    _controller.weatherData.kilometersToMiles(_controller.windspeed.value);
              } else if (_selectedMenu == items[2]) {
                _controller.temp.value = _controller.weatherData
                    .celsiusToFahrenheit(_controller.temp.value);
              }
            } else if (index == 2 && _selectedMenu != items[2]) {
              _controller.units = ['C', 'miles'].obs; 
              if (_selectedMenu == items[0]) {
                _controller.windspeed.value =
                    _controller.weatherData.kilometersToMiles(
                        _controller.windspeed.value);
              } else if (_selectedMenu == items[1]) {
                _controller.temp.value = _controller.weatherData
                    .fahrenheitToCelsius(_controller.temp.value);
              }
            }
            setState(() => _selectedMenu = items[index]);
          },
          child: Container(
            margin: const EdgeInsets.all(4), // Add margin here
            child: Text(items[index],),
          ),
        ),
      ),
    );
  }
}
