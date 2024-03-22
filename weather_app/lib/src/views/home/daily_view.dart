import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/src/presenter/presenter.dart';
import 'package:weather_app/src/models/weather_data/day.dart';

class DailyWeather extends StatefulWidget {
  final double containerHeight;
  const DailyWeather({required this.containerHeight, Key? key})
      : super(key: key);

  @override
  _DailyWeatherState createState() => _DailyWeatherState();
}

class _DailyWeatherState extends State<DailyWeather> {
  final ScrollController _scrollController = ScrollController();
  final GlobalPresenter _presenter = Get.put(GlobalPresenter());

  void _scrollToCenteredElement(int index) {
    const double itemHeight = 80; // Set the height of each list item
    final double maxScrollExtent = (8 * itemHeight) - widget.containerHeight;

    // Calculate the target offset to center the element, but ensure that the last
    // element is fully visible at the bottom
    double targetOffset =
        (index * itemHeight) - widget.containerHeight / 2 - 20;
    targetOffset = targetOffset.clamp(0, maxScrollExtent);

    // Scroll to make the element visible and centered
    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCenteredElement(_presenter.weatherData.value
          .getIndexofDay(_presenter.currentTime.value));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: const Text(
            'Next Days',
            style: TextStyle(
                fontVariations: [FontVariation('wght', (600))], fontSize: 20),
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
                  controller: _scrollController, // Set the controller here
                  scrollDirection: Axis.vertical,
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    Day day = _presenter.weatherData.value.days![index];

                    return GestureDetector(
                      child: Column(children: [
                        InkWell(
                          onTap: () {
                            if (_presenter.currentTime.value.day !=
                                DateTime.parse(day.datetime!.value).day) {
                              _presenter.showMore.value = true;
                              Get.toNamed("/detail_day", arguments: index);
                            }
                          },
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
                                  style: const TextStyle(
                                    fontVariations: [
                                      FontVariation('wght', (600))
                                    ],
                                  ),
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
                                    style: const TextStyle(
                                      fontVariations: [
                                        FontVariation('wght', (600))
                                      ],
                                    ),
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
