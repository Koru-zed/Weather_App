import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_data/current_day.dart';

class CurrentWeather extends StatefulWidget {
  final CurrentDay currentDay;

  const CurrentWeather({Key? key, required this.currentDay}) : super(key: key);

  @override
  _CurrentWeatherState createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 10),
      child: Row( 
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
              'assets/weather/${widget.currentDay.icon}.png',
            height: 80,
            width:  80 ,
          ),
          Container(
            height: 55,
            width: 1.5,
            color: Theme.of(context).colorScheme.secondary,
          ),
          RichText(
            text: TextSpan( children: [
              TextSpan(
                text: '${widget.currentDay.temp}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 60, fontWeight: FontWeight.w600),
              ),
              TextSpan(
                text: '°',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary, fontSize: 60),
              ),
              TextSpan(
                text: '   ${widget.currentDay.conditions}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary, fontSize: 13),
              )
            ]
          ),),
        ],
    ));
  }
}
