import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            _controller.weatherData.value.updateUnits(items[index], _selectedMenu);
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