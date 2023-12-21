part of './pages_library.dart';


class WeatherHome extends StatefulWidget {
  const WeatherHome({ Key? key }) : super(key: key);

  @override
  _WetherHomeState createState() => _WetherHomeState();
}

class _WetherHomeState extends State<WeatherHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 31, 37, 45),
        body: Container(

          // height: MediaQuery.of(contexte),
          child: Center(
            child: Text('WeatherHome', style: TextStyle(color: Colors.white),),
            
          )
        ),
      )
    );
  }
}