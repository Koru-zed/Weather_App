import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/presenter/presenter.dart';
import 'package:weather_app/views/change_unit_view.dart';
import 'package:google_fonts/google_fonts.dart';

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
          child: InkWell(
            onTap: () =>
                _presenter.scaffoldKey.value.currentState?.openDrawer(),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.25),
                ),
                padding: const EdgeInsets.all(2),
                margin: const EdgeInsets.only(top: 15, left: 18, bottom: 10),
                child: Image.asset(height: 30, 'assets/icons/menu.png')),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 20,
            right: 10,
          ),
          alignment: Alignment.topLeft,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Obx(() => Text(
                _presenter.city.value,
                style: GoogleFonts.saira(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 35,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: InkWell(
                onTap: () =>
                    _presenter.scaffoldKey.value.currentState?.openDrawer(),
                child: Image.asset(height: 20, 'assets/icons/navigation.png'),
              ),
            ),
          ]),
        ),
        Container(
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _presenter.dateTime.value,
                  style: GoogleFonts.saira(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                const ChangeUnits()
              ],
            )),
      ],
    );
  }
}
