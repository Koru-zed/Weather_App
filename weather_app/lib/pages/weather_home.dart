part of './pages_library.dart';


class WeatherHome extends StatefulWidget {
  const WeatherHome({ Key? key }) : super(key: key);

  @override
  _WetherHomeState createState() => _WetherHomeState();
}

class _WetherHomeState extends State<WeatherHome> {
  
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration:  BoxDecoration(
            color: Color.fromARGB(255, 31, 37, 45),
          ),
            // height: MediaQuery.of(contexte),
          child: Obx(() => globalController.loading ? 
            Center(child: CircularProgressIndicator(color: Colors.blue),) : 
            Container(child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                const Header(),
                
              ],
            ))
          ),
              
        ),
      )        
    );
  }
}