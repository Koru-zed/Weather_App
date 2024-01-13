import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
            Text(
              '°${_presenter.unit[0]}/${_presenter.unit[1]}',
              style: GoogleFonts.saira(
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
            _presenter.weatherData.value.updateUnits(
                _presenter.weatherData.value.units[index], _presenter.unit);
            setState(() => _presenter.unit.value =
                _presenter.weatherData.value.units[index]);
            _presenter.unit.value = _presenter.weatherData.value.units[index];
          },
          child: Container(
            margin: const EdgeInsets.all(4), // Add margin here
            child: Text(
              '°${_presenter.weatherData.value.units[index][0]}/${_presenter.weatherData.value.units[index][1]}',
              style: GoogleFonts.saira(),
            ),
          ),
        ),
      ),
    );
  }
}
