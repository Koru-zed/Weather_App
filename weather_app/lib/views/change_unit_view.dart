import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/presenter/presenter.dart';

class ChangeUnits extends StatefulWidget {
  const ChangeUnits({super.key});

  @override
  State<ChangeUnits> createState() => ChangeUnitsState();
}

class ChangeUnitsState extends State<ChangeUnits> {
  final GlobalPresenter _presenter = Get.put(GlobalPresenter());

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder:
          (BuildContext context, MenuController controller, Widget? child) {
        return Row(
          children: [
            Obx(() => Text(
                '°${_presenter.weatherData.value.units[_presenter.unit.value][0]}/${_presenter.weatherData.value.units[_presenter.unit.value][1]}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontVariations: const [FontVariation('wght', (700))],
                ),
              ),
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
            _presenter.weatherData.value.updateUnits(
                _presenter.weatherData.value.units[index], _presenter.weatherData.value.units[_presenter.unit.value]);
            _presenter.unit.value = index;
            print('check : ${_presenter.unit.value == 1}');
          },
          child: Container(
            margin: const EdgeInsets.all(4), // Add margin here
            child: Text(
              '°${_presenter.weatherData.value.units[index][0]}/${_presenter.weatherData.value.units[index][1]}',
              style: const TextStyle(
                fontVariations: [FontVariation('wght', (500))],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
