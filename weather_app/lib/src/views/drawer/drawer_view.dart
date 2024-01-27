import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/src/presenter/presenter.dart';
import 'package:weather_app/src/views/widgets/search_view.dart';
import 'dart:ui';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final GlobalPresenter _presenter = Get.put(GlobalPresenter());

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
        width: _presenter.width.value / 1.6,
        child: Obx(
          () => Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 60),
                child: Column(children: [
                  Image.asset('assets/icons/Ixon.png'),
                  Text(
                    'Weather',
                    style: TextStyle(
                        fontVariations: const [FontVariation('wght', (600))],
                        fontSize: 25,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ]),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            width: 1,
                            color: Theme.of(context).colorScheme.secondary))),
                padding: const EdgeInsets.only(
                    top: 20, left: 15, bottom: 15, right: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Dark Mode',
                        style: TextStyle(
                          fontVariations: [FontVariation('wght', (700))],
                        ),
                      ),
                      Transform.scale(
                        scale: 0.6,
                        child: Switch(
                            value: _presenter.isDark.value,
                            hoverColor: Theme.of(context).colorScheme.secondary,
                            onChanged: (value) {
                              _presenter.switchTheme();
                              _presenter.isDark.value = value;
                            }),
                      ),
                    ]),
              ),
              const Expanded(child: SearchLocation()),
            ],
          ),
        ));
  }
}
