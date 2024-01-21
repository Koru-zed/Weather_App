import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/models/weather_data/day.dart';
import 'package:get/get.dart';
import 'package:weather_app/presenter/presenter.dart';
import 'package:weather_app/views/hourly_view.dart';
import 'package:weather_app/views/more_detail.dart';

class CurrentWeather extends StatefulWidget {
  const CurrentWeather({Key? key}) : super(key: key);

  @override
  _CurrentWeatherState createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  final GlobalPresenter _presenter = Get.put(GlobalPresenter());

  @override
  Widget build(BuildContext context) {
    final Day currentDay = _presenter.weatherData.value.days![2];
    final double width = MediaQuery.of(context).size.width > 600
        ? 600
        : MediaQuery.of(context).size.width;
    final double maxOffset = 24 * (64 + 12) - width;
    final double middelWidth = width / 2;

    return Column(
      children: [
        currentData(currentDay),
        const MoreDetail(indexDay: 2, showMore: false),
        HourlyWeather(
          text: 'Today',
          fontSizeText: 20,
          currentDay: currentDay,
          maxOffset: maxOffset,
          middleWidth: middelWidth)
      ],
    );
  }

  Widget currentData(Day currentDay) {
    return Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [
                SizedBox(
                  height: 80,
                  width: 80,
                  // color: Colors.pink,
                  // padding: const EdgeInsets.all(3),
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
            ));
  }

}
