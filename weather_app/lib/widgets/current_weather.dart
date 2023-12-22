part of './widgets_library.dart';

class CurrentWeather extends StatefulWidget {
  const CurrentWeather({Key? key}) : super(key: key);

  @override
  _CurrentWeatherState createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(),
            Container(),
            Container(),
          ],
        ),
        Row(
          children: List.generate(3, (index) {
            return Container();
          }),
        )
      ],
    );
  }
}
