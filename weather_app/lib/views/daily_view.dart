import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/controller.dart';
import 'package:weather_app/models/weather_data/day.dart';

class DailyWeather extends StatefulWidget {
  const DailyWeather({Key? key}) : super(key: key);

  @override
  _DailyWeatherState createState() => _DailyWeatherState();
}

class _DailyWeatherState extends State<DailyWeather> {
  final GlobalController _controller = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    return  Column(children: [
        Container(
            margin: const EdgeInsets.only(top: 10),
            child: const Text(
              'Next Days',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            )),
        Container(
          margin: const EdgeInsets.fromLTRB(30, 20, 30, 60),
          padding: const EdgeInsets.only(top: 4, bottom: 4),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.tertiary.withOpacity(0.25),
              ),
            ],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Obx(
            () => Column(
              children: List.generate(8, (index) {
                Day day = _controller.weatherData.value.days![index];
                return Column(children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: _controller.currentTime.value.day ==
                                DateTime.parse(day.datetime!.value).day
                            ? Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.2)
                            : null),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '${day.nameday}',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6),
                          child: Image.asset(
                            'assets/weather/${day.icon}.png',
                          ),
                        ),
                        Text(
                          '${(day.tempmax!.value.toInt())}° / ${day.tempmin!.value.toInt()}°',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  if (index < 7)
                    Container(
                      height: 1,
                      margin: const EdgeInsets.only(
                          top: 6, left: 20, right: 20, bottom: 6),
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.7),
                    )
                ]);
              }),
            ),
          ),
        ),
      ],
    );
  }
}
