import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_data/day.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/controller.dart';
import 'package:weather_app/models/weather_data/hour.dart';
import 'package:weather_app/pages/widgets/hourly_weather.dart';

class CurrentWeather extends StatefulWidget {
  const CurrentWeather({Key? key}) : super(key: key);

  @override
  _CurrentWeatherState createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  final GlobalController _controller = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    // print('length : ${_controller.weatherData.value.days!.length}');
    Day currentDay = _controller.weatherData.value.days![2];
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
                    'assets/weather/${currentDay.hours![_controller.currentHourTime].icon}.png',
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
                          '${currentDay.hours![_controller.currentHourTime].temp}',
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
                      text:
                          '${currentDay.hours![_controller.currentHourTime].icon!.value.replaceAll('-', ' ')}',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 13.5),
                    )
                  ]),
                ),
              ],
            )));
  }

  Widget moreDetails(Day currentDay) {
    final items = <String>[
      'cloudcover',
      'windspeed',
      'humidity',
      'sunrise',
      'sunset'
    ];
    final double margin_hoz = MediaQuery.of(context).size.width * 0.07;
    String getDetail(String name) {
      switch (name) {
        case 'cloudcover':
          return '${currentDay.hours![_controller.currentHourTime].cloudcover}%';
        case 'humidity':
          return '${currentDay.hours![_controller.currentHourTime].humidity}%';
        case 'windspeed':
          return '${currentDay.hours![_controller.currentHourTime].windspeed}${_controller.units[1]}/h';
        case 'sunrise':
          return '${currentDay.sunrise} PM';
        case 'sunset':
          return '${currentDay.sunset} AM';
        default:
          throw Exception('Property $name not found');
      }
    }

    return Container(
      margin: EdgeInsets.only(
          left: margin_hoz, right: margin_hoz, top: 5, bottom: 2),
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
                            .withOpacity(0.25),
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
                    style: const TextStyle(fontSize: 13))
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget HourlyDetail(Day currentDay) {
    String timeStamp;
    Color textColor = _controller.myTheme.currentTheme.value == ThemeMode.light
        ? Colors.black
        : Colors.white;

    // Create a ScrollController
    ScrollController scrollController = ScrollController();
    double maxOffset = 24 * (64 + 12) - MediaQuery.of(context).size.width;
    double middelWidth = MediaQuery.of(context).size.width / 2;
    List<Hour> hours = _controller.weatherData.value.days![2].hours!;

    return Column(
      children: [
        const SizedBox(height: 7),
        const Text(
          'Today',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 110,
          child: ListView.builder(
            controller: scrollController, // Set the controller
            scrollDirection: Axis.horizontal,
            itemCount: 24,
            itemBuilder: (context, index) {
              index > 12 ? timeStamp = 'AM' : timeStamp = 'PM';
              return Obx(
                () => GestureDetector(
                  onTap: () {
                    _controller.cardIndex.value = index;
                    // Calculate the offset to center the selected card
                    double offset = index * 76 - middelWidth + 32;
                    offset = offset.clamp(0.0, maxOffset);
                    // Scroll to the calculated offset
                    scrollController.animateTo(
                      offset,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    width: 64,
                    padding: const EdgeInsets.only(top: 6, bottom: 4),
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context)
                              .colorScheme
                              .tertiary
                              .withOpacity(0.15),
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                      gradient: _controller.cardIndex.value == index
                          ? LinearGradient(colors: [
                              Theme.of(context).colorScheme.secondary,
                              Theme.of(context).colorScheme.secondary,
                            ])
                          : null,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                            '${index > 9 ? '' : '0'}$index:00 $timeStamp',
                            style: TextStyle(fontSize: 12, color: textColor),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Image.asset(
                            'assets/weather/${hours[index].icon}.png',
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            '${hours[index].temp}°',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
