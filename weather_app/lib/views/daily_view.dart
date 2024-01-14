import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/presenter/presenter.dart';
import 'package:weather_app/models/weather_data/day.dart';

class DailyWeather extends StatefulWidget {
  const DailyWeather({Key? key}) : super(key: key);

  @override
  _DailyWeatherState createState() => _DailyWeatherState();
}

class _DailyWeatherState extends State<DailyWeather> {
  ScrollController scrollController = ScrollController();
  final GlobalPresenter _presenter = Get.put(GlobalPresenter());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Set the initial scroll position to center the selected card
    // int initialIndex = _presenter.cardDayIndex.value;
    // print('initialIndex : $initialIndex');
    double initialOffset = _presenter.cardDayIndex.value * 46.5 - 103;
    initialOffset = initialOffset.clamp(0.0, 270);

    // Scroll to the initial offset
    scrollController = ScrollController(initialScrollOffset: initialOffset);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            'Next Days',
            style: GoogleFonts.saira(fontWeight: FontWeight.w500, fontSize: 20),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color:
                      Theme.of(context).colorScheme.tertiary.withOpacity(0.15),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: ListView.builder(
                controller: scrollController, // Set the controller here
                scrollDirection: Axis.vertical,
                itemCount: 8,
                itemBuilder: (context, index) {
                  Day day = _presenter.weatherData.value.days![index];
                  return GestureDetector(

                    child: Column(children: [
                      InkWell(
                        onTap: () =>
                            Get.toNamed("/detail_day", arguments: index),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: _presenter.currentTime.value.day ==
                                    DateTime.parse(day.datetime!.value).day
                                ? Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.2)
                                : null,
                          ),
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                '${day.nameday}',
                                style: GoogleFonts.saira(
                                    fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6),
                                child: Image.asset(
                                  'assets/weather/${day.icon}.png',
                                ),
                              ),
                              Obx(
                                () => Text(
                                  '${(day.tempmax!.value.toInt())}° / ${day.tempmin!.value.toInt()}°',
                                  style: GoogleFonts.saira(
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
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
                    ]),
                  );
                }),
              ),
            ),
          ),
        // ),
      ],
    );
  }
}
