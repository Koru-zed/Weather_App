import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_data/current_day.dart';

class HourlyWeather extends StatefulWidget {
  final CurrentDay currentDay;

  const HourlyWeather({Key? key, required this.currentDay}) : super(key: key);

  @override
  _HourlyWeatherState createState() => _HourlyWeatherState();
}

class _HourlyWeatherState extends State<HourlyWeather> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [ Container(
            height: 100,
            width: 60,
            color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
            // child: ,
          )
        ]),
      
    );
  }

  
}
