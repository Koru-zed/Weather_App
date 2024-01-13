import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/models/weather_data/day.dart';
import 'package:get/get.dart';
import 'package:weather_app/presenter/presenter.dart';
import 'package:weather_app/views/hourly_view.dart';

class CurrentWeather extends StatefulWidget {
  const CurrentWeather({Key? key}) : super(key: key);

  @override
  _CurrentWeatherState createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  final GlobalPresenter _presenter = Get.put(GlobalPresenter());

  @override
  Widget build(BuildContext context) {
    Day currentDay = _presenter.weatherData.value.days![2];
    double width = MediaQuery.of(context).size.width > 600
        ? 600
        : MediaQuery.of(context).size.width;
    double maxOffset = 24 * (64 + 12) - width;
    double middelWidth = width / 2;

    return Column(
      children: [
        currentData(currentDay),
        moreDetails(currentDay),
        HourlyWeather(
            currentDay: currentDay,
            maxOffset: maxOffset,
            middleWidth: middelWidth)
      ],
    );
  }

  Widget currentData(Day currentDay) {
    return Container(
        margin: const EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 10),
        child: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  padding: const EdgeInsets.all(3),
                  child: Image.asset(
                    'assets/weather/${currentDay.hours![_presenter.currentHourTime].icon}.png',
                  ),
                ),
                Container(
                  height: 50,
                  width: 1.5,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text:
                          '${currentDay.hours![_presenter.currentHourTime].temp}',
                      style: GoogleFonts.saira(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 60,
                          fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: '°',
                      style: GoogleFonts.saira(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 60),
                    ),
                    TextSpan(
                      text: currentDay
                          .hours![_presenter.currentHourTime].icon!.value
                          .replaceAll('-', ' '),
                      style: GoogleFonts.saira(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 13.5),
                    )
                  ]),
                ),
              ],
            )));
  }

  Widget moreDetails(Day currentDay) {
    final double marginHoz = MediaQuery.of(context).size.width * 0.07;
    final items = <String>[
      'cloudcover',
      'windspeed',
      'humidity',
      'sunrise',
      'sunset'
    ];

    String getDetail(String name) {
      switch (name) {
        case 'cloudcover':
          return '${currentDay.hours![_presenter.currentHourTime].cloudcover}%';
        case 'humidity':
          return '${currentDay.hours![_presenter.currentHourTime].humidity}%';
        case 'windspeed':
          return '${currentDay.hours![_presenter.currentHourTime].windspeed}${_presenter.unit[1]}/h';
        default:
          throw Exception('Property $name not found');
      }
    }

    return Container(
      margin:
          EdgeInsets.only(left: marginHoz, right: marginHoz, top: 5, bottom: 2),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(3, (index) {
            return Column(
              children: [
                Tooltip(
                  message: items[index],
                  child: Container(
                    height: 55,
                    width: 55,
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .tertiary
                            .withOpacity(0.15),
                        borderRadius: BorderRadius.circular(
                          20,
                        )),
                    child: Image.asset(
                      'assets/icons/${items[index]}.png',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(getDetail(items[index]),
                    style: GoogleFonts.saira(fontSize: 13))
              ],
            );
          }),
        ),
      ),
    );
  }
}
