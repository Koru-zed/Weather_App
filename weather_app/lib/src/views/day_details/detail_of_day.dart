import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:weather_app/src/presenter/presenter.dart';
import 'package:weather_app/src/views/widgets/hourly_view.dart';
import 'package:weather_app/src/views/widgets/more_detail.dart';

class DetailOfDay extends StatefulWidget {
  const DetailOfDay({Key? key}) : super(key: key);

  @override
  _DetailOfDayState createState() => _DetailOfDayState();
}

class _DetailOfDayState extends State<DetailOfDay> {
  final GlobalPresenter _presenter = Get.put(GlobalPresenter());

  @override
  Widget build(BuildContext context) {
    final int index = Get.arguments;
    double width = _presenter.width.value > 600 ? 600 : _presenter.width.value;
    double maxOffset = 24 * (64 + 12) - width;
    double middelWidth = width / 2;

    return Scaffold(
        body: Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.25),
            ),
            margin:
                const EdgeInsets.only(top: 30, left: 18, bottom: 12, right: 18),
            padding: const EdgeInsets.all(4),
            child: InkWell(
                onTap: () {
                  _presenter.showMore.value = false;
                  Get.back();
                },
                child: Image.asset(height: 30, 'assets/icons/back-arrow.png')),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(30),
                topRight: Radius.circular(30)),
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.06),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color:
                        Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                  ),
                  child: Column(children: [
                    Container(
                        padding: const EdgeInsets.only(bottom: 12, top: 6),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 2,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background))),
                        child: Image.asset(
                            'assets/weather/${_presenter.weatherData.value.days![index].icon}.png')),
                    Container(
                      height: 40,
                      margin: const EdgeInsets.only(top: 6, bottom: 6),
                      child: Text(
                        '${(_presenter.weatherData.value.days![index].tempmax!.value)}° / ${_presenter.weatherData.value.days![index].tempmin!.value}°',
                        style: const TextStyle(
                          fontSize: 25,
                          fontVariations: [FontVariation('wght', (600))],
                        ),
                      ),
                    )
                  ]),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${_presenter.weatherData.value.days![index].nameday}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 20.5,
                          fontVariations: const [FontVariation('wght', (600))],
                        ),
                      ),
                      Text(
                        '${_presenter.weatherData.value.days![index].datetime}',
                        style: const TextStyle(
                          fontSize: 13.5,
                          fontVariations: [FontVariation('wght', (600))],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Text(
                          _presenter.weatherData.value.days![index].icon!.value
                              .replaceAll('-', ' '),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: 16,
                            fontVariations: const [
                              FontVariation('wght', (500))
                            ],
                          ),
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ),
        HourlyWeather(
            text: 'Hours',
            fontSizeText: 20,
            currentDay: _presenter.weatherData.value.days![index],
            maxOffset: maxOffset,
            middleWidth: middelWidth),
        const SizedBox(
          height: 20,
        ),
        MoreDetail(
          indexDay: index,
          showMore: true,
        )
      ],
    ));
  }
}
