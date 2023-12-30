import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controllers/controller.dart';
import 'package:weather_app/pages/widgets/change_units.dart';
import 'package:weather_app/pages/widgets/search_location.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  String? _dateTime;

  final GlobalController _controller = Get.put(GlobalController());

  @override
  void initState() {
    super.initState();
    _dateTime = DateFormat('yMMMMd').format(_controller.currentTime.value);
    _controller.cardIndex.value = _controller.currentHourTime;
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () => _controller.switchTheme(),
            tooltip: 'Change Theme',
            icon: Icon(
              Icons.dark_mode_outlined,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 10, top: 20),
          alignment: Alignment.topLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _controller.city.value,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 35,
                    fontWeight: FontWeight.w500),
              ),
              Container(
                child: IconButton(
                  onPressed: () => Get.to(SearchLocation()),
                  icon: Icon(Icons.location_searching_outlined, color: Theme.of(context).colorScheme.tertiary),
                ),
              ),
            ]
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          alignment: Alignment.topLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
               _dateTime!,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              const ChangeUnits()
            ],
          )
        ),
      ],
    );
  }
}
