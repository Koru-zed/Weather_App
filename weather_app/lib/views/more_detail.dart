import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_data/day.dart';
import 'package:get/get.dart';
import 'dart:ui';
import 'package:weather_app/presenter/presenter.dart';
// import 'package:weather_app/views/hourly_view.dart';

class MoreDetail extends StatefulWidget {
  final int indexDay;
  final bool showMore;
  const MoreDetail({required this.indexDay, required this.showMore, Key? key})
      : super(key: key);

  @override
  _MoreDetailState createState() => _MoreDetailState();
}

class _MoreDetailState extends State<MoreDetail> {
  final GlobalPresenter _presenter = Get.put(GlobalPresenter());
  final items = <String>[
    'cloudcover',
    'precipprob',
    'humidity',
    'sunrise',
    'sunset',
    'moonphase',
    'visibility',
    'windspeed',
    'winddir',
    'snow',
    'solarradiation',
    'solarenergy',
  ];
  // bool showMore = _presenter

  @override
  Widget build(BuildContext context) {
    return Obx(() => widget.showMore ? dailyDetail() : homeDetail());
  }

  Widget dailyDetail() {
    return Expanded(child: detail());
  }

  Widget homeDetail() {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            height: _presenter.showMore.isTrue
                ? _presenter.height.value < 700
                    ? (_presenter.height.value * .29)
                    : (_presenter.height.value * .42)
                : 80,
            child: detail()),
        widget.showMore == false
            ? Container(
                height: 30,
                padding: const EdgeInsets.only(right: 8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      _presenter.showMore.value = !_presenter.showMore.value;
                    },
                    child: Text(
                      _presenter.showMore.isTrue ? 'Show less' : 'Show more',
                      style: TextStyle(
                        fontSize: 12,
                        fontVariations: const [FontVariation('wght', (700))],
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  Widget detail() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: _presenter.showMore.isTrue ? 100 : 80,
      ),
      itemCount: widget.showMore || _presenter.showMore.isTrue ? 12 : 3,
      physics: _presenter.showMore.isTrue
          ? const BouncingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Obx(
          () => Column(
            children: [
              Tooltip(
                textStyle: const TextStyle(fontVariations: [FontVariation('wght', (400))],),
                message: items[index],
                child: Container(
                  height: 50,
                  width: 50,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .tertiary
                        .withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    'assets/icons/${items[index]}.${items[index] == 'moonphase' ? 'gif' : 'png'}',
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              getDetail(items[index],
                  _presenter.weatherData.value.days![widget.indexDay]),
            ],
          ),
        );
      },
    );
  }

  Widget getDetail(String name, Day currentDay) {
    final String text;
    switch (name) {
      case 'cloudcover':
        text = '${currentDay.hours![_presenter.currentHourTime].cloudcover}%';
        break;
      case 'precipprob':
        text = '${currentDay.hours![_presenter.currentHourTime].precipprob}%';
        break;
      case 'humidity':
        text = '${currentDay.hours![_presenter.currentHourTime].humidity}%';
        break;
      case 'sunrise':
        text = '${currentDay.sunrise} AM';
        break;
      case 'sunset':
        text = '${currentDay.sunset} PM';
        break;
      case 'moonphase':
        text = '${(currentDay.moonphase! * 100).toStringAsFixed(2)}%';
        break;
      case 'visibility':
        text =
            '${currentDay.hours![_presenter.currentHourTime].visibility}${_presenter.weatherData.value.units[_presenter.unit.value][1]}';
        break;
      case 'windspeed':
        text =
            '${currentDay.hours![_presenter.currentHourTime].windspeed}${_presenter.weatherData.value.units[_presenter.unit.value][1]}/h';
        break;
      case 'winddir':
        text = '${currentDay.hours![_presenter.currentHourTime].winddir}°';
        break;
      case 'snow':
        text =
            '${currentDay.hours![_presenter.currentHourTime].snow}${_presenter.weatherData.value.units[_presenter.unit.value][1] == 'km' ? 'cm' : 'inch'}';
        break;
      case 'solarradiation':
        text =
            '${currentDay.hours![_presenter.currentHourTime].solarradiation}W/m2';
        break;
      case 'solarenergy':
        text =
            '${currentDay.hours![_presenter.currentHourTime].solarenergy}MJ/m2';
        break;

      default:
        throw Exception('Property $name not found');
    }
    return Text(text,
        style: const TextStyle(
          fontSize: 13,
          fontVariations: [FontVariation('wght', (400))],
        ));
  }
}
