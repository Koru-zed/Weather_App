import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/presenter/presenter.dart';
import 'package:weather_app/views/home/change_unit_view.dart';
import 'dart:ui';

//
class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final GlobalPresenter _presenter = Get.put(GlobalPresenter());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.25),
              ),
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.only(
                  top: 30, left: 18, bottom: 6, right: 18),
              child: InkWell(
                  onTap: () =>
                      _presenter.scaffoldKey.value.currentState?.openDrawer(),
                  child: Image.asset(height: 30, 'assets/icons/menu.png'))),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20,right: 10,),
          alignment: Alignment.topLeft,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Obx(
              () => Flexible(
                child: Text(
                  _presenter.weatherData.value.address!.value,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 40,
                    overflow: TextOverflow.ellipsis,
                    fontVariations: const [FontVariation('wght', (600))],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () =>
                  _presenter.scaffoldKey.value.currentState?.openDrawer(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(height: 20, 'assets/icons/navigation.png'),
              ),
            ),
          ]),
        ),
        Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _presenter.dateTime.value,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 16,
                    fontVariations: const [FontVariation('wght', (600))],
                  ),
                ),
                const ChangeUnits()
              ],
            )),
      ],
    );
  }
}
