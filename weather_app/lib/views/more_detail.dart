import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/models/weather_data/day.dart';
import 'package:get/get.dart';
import 'package:weather_app/presenter/presenter.dart';
import 'package:weather_app/views/hourly_view.dart';

class MoreDetail extends StatefulWidget {
  final Day currentDay;
  final bool showMore;
  const MoreDetail({required this.currentDay, required this.showMore, Key? key})
      : super(key: key);

  @override
  _MoreDetailState createState() => _MoreDetailState();
}

class _MoreDetailState extends State<MoreDetail> {
  GlobalPresenter _presenter = Get.put(GlobalPresenter());

  @override
  Widget build(BuildContext context) {
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


    String getDetail(String name) {
      switch (name) {
        case 'cloudcover':
          return '${widget.currentDay.hours![_presenter.currentHourTime].cloudcover}%';
        case 'precipprob':
          return '${widget.currentDay.hours![_presenter.currentHourTime].precipprob}%';
        case 'humidity':
          return '${widget.currentDay.hours![_presenter.currentHourTime].humidity}%';
        case 'sunrise':
          return '${widget.currentDay.sunrise} AM';
        case 'sunset':
          return '${widget.currentDay.sunset} AM';
        case 'moonphase':
          return '${(widget.currentDay.moonphase! * 100).toStringAsFixed(2)}%';
        case 'visibility':
          return '${widget.currentDay.hours![_presenter.currentHourTime].visibility}${_presenter.unit[1]}';
        case 'windspeed':
          return '${widget.currentDay.hours![_presenter.currentHourTime].windspeed}${_presenter.unit[1]}/h';
        case 'winddir':
          return '${widget.currentDay.hours![_presenter.currentHourTime].winddir}°';
        case 'snow':
          return '${widget.currentDay.hours![_presenter.currentHourTime].snow}${_presenter.unit[1] == 'C' ? 'cm' : 'inch'}';
        case 'solarradiation':
          return '${widget.currentDay.hours![_presenter.currentHourTime].solarradiation}W/m2';
        case 'solarenergy':
          return '${widget.currentDay.hours![_presenter.currentHourTime].solarenergy}MJ/m2';

        default:
          throw Exception('Property $name not found');
      }
    }

    return Obx(() => Column(
        children: [
          Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: widget.showMore ? 400 : _presenter.showMore.isTrue ? 320 : 80,
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, mainAxisExtent: _presenter.showMore.isTrue ? 100 : 80),
                  itemCount: widget.showMore || _presenter.showMore.isTrue ? 12 : 3,
                  physics: _presenter.showMore.isTrue ? const BouncingScrollPhysics(): const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Tooltip(
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
                                borderRadius: BorderRadius.circular(
                                  20,
                                )),
                            child: Image.asset(
                              'assets/icons/${items[index]}.${items[index] == 'moonphase' ? 'gif' : 'png'}',
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
                  }
            ),
          ),
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
                          style: GoogleFonts.saira(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary),
                        )),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
