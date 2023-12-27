import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controllers/controller.dart';
import 'package:weather_app/pages/widgets/change_units.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  String _city = "";
  String dateTime = DateFormat('yMMMMd').format(DateTime.now());

  final GlobalController globalController = Get.put(GlobalController());

  @override
  void initState() {
    super.initState();
    // Delay the execution of getLocation by 0 milliseconds (immediately)
    // Future.delayed(Duration(milliseconds: 0), () {
    //   getLocation(globalController.getLatitude, globalController.getLongitude);
    // });
    _city = "London";
  }

  getLocation(latitude, longitude) async {
    try {
      List<Placemark> location =
          await placemarkFromCoordinates(latitude, longitude);
      setState(() {
        _city = location[0].locality!;
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 10, top: 5),
          alignment: Alignment.topLeft,
          child: Text(
            _city,
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 35,
                fontWeight: FontWeight.w500),
          ),
        ),
        Container(
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dateTime,
                  style: TextStyle(
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
