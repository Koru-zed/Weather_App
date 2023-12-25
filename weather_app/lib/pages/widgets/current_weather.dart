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
    return Column(
      children: [currentData(), moreDetails()],
    );
  }

  Widget currentData() {
    return Container(
        margin: const EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 70,
              width: 70,
              padding: const EdgeInsets.all(3),
              child: Image.asset(
                'assets/weather/${widget.currentDay.icon}.png',
              ),
            ),
            Container(
              height: 50,
              width: 1.5,
              color: Theme.of(context).colorScheme.secondary,
              // decoration: BoxDecoration(borderRadius: BorderRadius.circular(1)),
            ),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: '${widget.currentDay.temp}',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 60,
                      fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text: '°',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 60),
                ),
                TextSpan(
                  text: '   ${widget.currentDay.conditions}',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 15),
                )
              ]),
            ),
          ],
        ));
  }

  Widget moreDetails() {
    final items = <String>['cloudcover', 'windspeed', 'humidity'];

    String getDetail(String name) {
      switch (name) {
        case 'cloudcover':
          return '${widget.currentDay.cloudcover}';
        case 'humidity':
          return '${widget.currentDay.humidity}';
        case 'windspeed':
          return '${widget.currentDay.windspeed}';
        // Add more cases for other properties
        default:
          throw Exception('Property $name not found');
      }
    }

    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(3, (index) {
          return Column(
            children: [
              Container(
                height: 60,
                width: 60,
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(
                      20,
                    )),
                child: Image.asset(
                  'assets/icons/${items[index]}.png',
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(getDetail(items[index]),
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold))
            ],
          );
        }),
      ),
    );
  }
}
