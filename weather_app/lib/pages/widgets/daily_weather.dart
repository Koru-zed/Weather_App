import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controllers/controller.dart';
import 'package:weather_app/models/weather_data/day.dart';

class DailyWeather extends StatefulWidget {
  const DailyWeather({Key? key}) : super(key: key);

  @override
  _DailyWeatherState createState() => _DailyWeatherState();
}

class _DailyWeatherState extends State<DailyWeather> {
  GlobalController _controller = Get.put(GlobalController());
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text('Next Days', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),)),
        Container(
          margin: const EdgeInsets.fromLTRB(30, 20, 30, 30),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context)
                    .colorScheme
                    .tertiary
                    .withOpacity(0.15),
              ),
            ],
            borderRadius: BorderRadius.circular(15),
            // color: Theme.of(context).colorScheme.tertiary.withOpacity(0.25),
          ),
          child: Column(
            children: List.generate(7, (index) {
              Day day = _controller.weatherData.days![index + 1];
              return Column(
                children: [
                  Container(
                    height: 50,
                    // margin: const EdgeInsets.only(left:20, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: _controller.currentTime.value.day == DateTime.parse(day.datetime!.value).day ? Theme.of(context).colorScheme.secondary.withOpacity(0.2) : null
                    ),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('${day.nameday}'),
                        Padding(
                          padding: const EdgeInsets.all(6),
                          child: Image.asset(
                                'assets/weather/${day.icon}.png',),
                        ),
                        Text('${(day.tempmax!.value.toInt())}° / ${day.tempmin!.value.toInt()}°'),
                      ],
                    ),
                  ),
                  if (index < 6) Container(
                    height: 1,
                    margin: const EdgeInsets.only(top: 6, left: 20, right: 20, bottom: 6),
                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
                  )
                ]
              );
            }),
          ),
        ),
      ]
    );
  }
}
