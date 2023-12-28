import 'package:flutter/material.dart';
import 'package:weather_app/controllers/controller.dart';
import 'package:get/get.dart';
import 'package:weather_app/models/weather_data/day.dart';

class HourlyWeather extends StatefulWidget {
  final Day currentDay;
  final double maxOffset;
  final double middleWidth;

  const HourlyWeather({
    Key? key,
    required this.currentDay,
    required this.maxOffset,
    required this.middleWidth,
  }) : super(key: key);

  @override
  _HourlyWeatherState createState() => _HourlyWeatherState();
}

class _HourlyWeatherState extends State<HourlyWeather> {
  String? timeStamp;
  ScrollController scrollController = ScrollController();
  GlobalController _controller = Get.put(GlobalController());

  @override
  void initState() {
    super.initState();

    // Set the initial scroll position to center the selected card
    int initialIndex = _controller.cardIndex.value;
    double initialOffset = initialIndex * 76.5 - widget.middleWidth + 32;
    initialOffset = initialOffset.clamp(0.0, widget.maxOffset);

    // Scroll to the initial offset
    scrollController = ScrollController(initialScrollOffset: initialOffset);
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = _controller.myTheme.currentTheme.value == ThemeMode.light
        ? Colors.black
        : Colors.white;

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
            controller: scrollController, // Set the controller here
            scrollDirection: Axis.horizontal,
            itemCount: 24,
            itemBuilder: (context, index) {
              index > 12 ? timeStamp = 'AM' : timeStamp = 'PM';
              return Obx(
                () => GestureDetector(
                  onTap: () {
                    // Set the card index when tapped
                    _controller.cardIndex.value = index;

                    // Calculate the offset to center the selected card
                    double offset = index * 76.4 - widget.middleWidth + 32;
                    offset = offset.clamp(0.0, widget.maxOffset);

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
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      gradient: _controller.currentHourTime == index ? LinearGradient(colors: [
                              Theme.of(context).colorScheme.secondary,
                              Theme.of(context).colorScheme.secondary,
                            ]) : _controller.cardIndex.value == index
                          ? LinearGradient(colors: [
                              Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                              Theme.of(context).colorScheme.secondary.withOpacity(0.5),
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
                            'assets/weather/${widget.currentDay.hours![index].icon}.png',
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            '${widget.currentDay.hours![index].temp}°',
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
