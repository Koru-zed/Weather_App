import 'package:flutter/material.dart';
import 'package:weather_app/presenter/presenter.dart';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:weather_app/models/weather_data/day.dart';

class HourlyWeather extends StatefulWidget {
  final String text;
  final double fontSizeText;
  final Day currentDay;
  final double maxOffset;
  final double middleWidth;

  const HourlyWeather({
    Key? key,
    required this.text,
    required this.fontSizeText,
    required this.currentDay,
    required this.maxOffset,
    required this.middleWidth,
  }) : super(key: key);

  @override
  _HourlyWeatherState createState() => _HourlyWeatherState();
}

class _HourlyWeatherState extends State<HourlyWeather> {
  String? timeStamp;
  final ScrollController scrollController = ScrollController();
  final GlobalPresenter _presenter = Get.put(GlobalPresenter());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToElement(_presenter.cardHourIndex.value, 1500);
    });
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = _presenter.myTheme.currentTheme.value == ThemeMode.light
        ? Colors.black
        : Colors.white;

    return Column(
      children: [
        const SizedBox(height: 7),
        Text(
          widget.text,
          style: TextStyle(
            fontSize: widget.fontSizeText,
            fontVariations: const [FontVariation('wght', (700))],
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 110,
          child: ListView.builder(
            controller: scrollController, // Set the controller here
            scrollDirection: Axis.horizontal,
            itemCount: 24,
            itemBuilder: (context, index) {
              index > 12 ? timeStamp = 'AM' : timeStamp = 'PM';
              return Obx(
                () => GestureDetector(
                  onTap: () => _scrollToElement(index, 500),
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
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      gradient: _presenter.currentHourTime == index
                          ? LinearGradient(colors: [
                              Theme.of(context).colorScheme.secondary,
                              Theme.of(context).colorScheme.secondary,
                            ])
                          : _presenter.cardHourIndex.value == index
                              ? LinearGradient(colors: [
                                  Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.5),
                                  Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.5),
                                ])
                              : null,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                            '${index > 9 ? '' : '0'}$index:00 $timeStamp',
                            style: TextStyle(
                                fontSize: 12,
                                fontVariations: const [
                                  FontVariation('wght', (400))
                                ],
                                color: _presenter.currentHourTime == index
                                    ? Theme.of(context).colorScheme.background
                                    : textColor),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Image.asset(
                            'assets/weather/${widget.currentDay.hours![index].icon}.png',
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            '${widget.currentDay.hours![index].temp}°',
                            style: TextStyle(
                                fontVariations: const [
                                  FontVariation('wght', (400))
                                ],
                                color: _presenter.currentHourTime == index
                                    ? Theme.of(context).colorScheme.background
                                    : textColor),
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

  void _scrollToElement(int index, int milliseconds) {
    // Set the card index when tapped
    _presenter.cardHourIndex.value = index;

    // Calculate the offset to center the selected card
    double offset = index * 76.4 - widget.middleWidth + 32;
    offset = offset.clamp(0.0, widget.maxOffset);
    // Scroll to the calculated offset
    scrollController.animateTo(
      offset,
      duration: Duration(milliseconds: milliseconds),
      curve: Curves.easeInOut,
    );
  }
}
