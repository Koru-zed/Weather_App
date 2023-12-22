part of './widgets_library.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  String _city = "";
  String dateTime = DateFormat('yMMMMd').format(DateTime.now());

  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    super.initState();
    // Delay the execution of getLocation by 0 milliseconds (immediately)
    Future.delayed(Duration(milliseconds: 0), () {
      getLocation(globalController.getLatitude, globalController.getLongitude);
    });
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
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          alignment: Alignment.topLeft,
          child: Text(
            _city,
            style: TextStyle(
                color: globalController.getTextColor(),
                fontSize: 35,
                fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          alignment: Alignment.topLeft,
          child: Text(
            dateTime,
            style: TextStyle(
                color: globalController.getTextColorTwo(),
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
