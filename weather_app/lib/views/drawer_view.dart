import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/controller.dart';
import 'package:weather_app/views/search_view.dart';


class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}


class _MyDrawerState extends State<MyDrawer> {
  final GlobalController _controller = Get.put(GlobalController());


  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
        width: _controller.width.value / 1.6,
        child: Obx(
          () => Column(
            children: [
              DrawerHeader(child: Image.asset('assets/icons/weather-icon.png')),
              Container(
                margin: const EdgeInsets.only(
                    top: 40, left: 15, bottom: 15, right: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Dark Mode',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Transform.scale(
                        scale: 0.6,
                        child: Switch(
                            value: _controller.isDark.value,
                            hoverColor: Theme.of(context).colorScheme.secondary,
                            onChanged: (value) {
                              _controller.switchTheme();
                              _controller.isDark.value = value;
                            }),
                      ),
                    ]),
              ),
              const SearchLocation(),
            ],
          ),
        ));
  }
}
