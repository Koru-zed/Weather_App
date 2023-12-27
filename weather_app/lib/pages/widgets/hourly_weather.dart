import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/models/weather_data/day.dart';
import 'package:weather_app/controllers/controller.dart';

class HourlyWeather extends StatefulWidget {
  final Day currentDay;

  const HourlyWeather({Key? key, required this.currentDay}) : super(key: key);

  @override
  _HourlyWeatherState createState() => _HourlyWeatherState();
}

class _HourlyWeatherState extends State<HourlyWeather> {
  RxInt cardIndex = GlobalController().cardIndex;

  @override
  Widget build(BuildContext context) {
    String timeStamp;

    return Column(
      children: [
        SizedBox(height: 7),
        Text(
          'Today',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 5),
        Container(
            height: 110,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 24,
                itemBuilder: (context, index) {
                  index > 12 ? timeStamp = 'AM' : timeStamp = 'PM';
                  print(timeStamp);
                  return Obx(
                    () => GestureDetector(
                        onTap: () => cardIndex.value = index,
                        child: Container(
                          // height: 100,
                          width: 64,
                          padding: const EdgeInsets.only(top: 6, bottom: 4),
                          margin: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            boxShadow: [BoxShadow(
                              color:  Theme.of(context)
                                .colorScheme
                                .tertiary
                                .withOpacity(0.15),
                            )],
                            borderRadius: BorderRadius.circular(10),
                            gradient: cardIndex.value == index
                                ? LinearGradient(colors: [
                                    Theme.of(context).colorScheme.secondary,
                                    Theme.of(context).colorScheme.secondary,
                                    // Colors.blue
                                  ])
                                : null,
                          ),
                          child: Column(
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: index > 9
                                      ? Text(
                                          '$index:00 $timeStamp',
                                          style: TextStyle(fontSize: 12),
                                        )
                                      : Text(
                                          '0$index:00 $timeStamp',
                                          style: TextStyle(fontSize: 12),
                                        )),
                              Expanded(
                                flex: 7,
                                child: Image.asset(
                                    'assets/weather/${widget.currentDay.hours![index].icon}.png'),
                              ),
                              Expanded(
                                  flex: 4,
                                  child: Text(
                                      '${widget.currentDay.hours![index].temp}°'))
                            ],
                          ),
                        )),
                  );
                }))
      ],
    );
  }
}
