import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/presenter/presenter.dart';
// import 'package:weather_app/views/current_view.dart';
import 'package:weather_app/views/hourly_view.dart';
import 'package:weather_app/views/more_detail.dart';

class DetailOfDay extends StatefulWidget {
  const DetailOfDay({Key? key}) : super(key: key);

  @override
  _DetailOfDayState createState() => _DetailOfDayState();
}

class _DetailOfDayState extends State<DetailOfDay> {
  GlobalPresenter _presenter = Get.put(GlobalPresenter());

  @override
  Widget build(BuildContext context) {
    final int index = Get.arguments;
    double width = MediaQuery.of(context).size.width > 600
        ? 600
        : MediaQuery.of(context).size.width;
    double maxOffset = 24 * (64 + 12) - width;
    double middelWidth = width / 2;

    print('index : $index');

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: InkWell(
            onTap: () {
              _presenter.showMore.value = false;
              Get.back();
            },
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.25),
                ),
                margin: const EdgeInsets.only(top: 10, left: 18, bottom: 10),
                padding: const EdgeInsets.all(4),
                child: Image.asset('assets/icons/back-arrow.png')),
          ),
        ),
        body: Column(
          children: [
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
                  Container(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.4),
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
                          style: GoogleFonts.saira(
                              fontSize: 25, fontWeight: FontWeight.w600),
                        ),
                      )
                    ]),
                  ),
                  SizedBox(
                    width: 154,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${_presenter.weatherData.value.days![index].nameday}',
                            style: GoogleFonts.saira(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 20.5,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '${_presenter.weatherData.value.days![index].datetime}',
                            style: GoogleFonts.saira(
                                fontSize: 13.5, fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Text(
                              _presenter
                                  .weatherData.value.days![index].icon!.value
                                  .replaceAll('-', ' '),
                              style: GoogleFonts.saira(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
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
