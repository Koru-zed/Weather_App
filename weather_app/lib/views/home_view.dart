import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;
// import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/presenter/presenter.dart';
import 'package:weather_app/views/daily_view.dart';
import 'package:weather_app/views/header.dart';
import 'package:weather_app/views/current_view.dart';
import 'package:weather_app/views/drawer_view.dart';
import 'package:weather_app/views/search_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalPresenter _presenter = Get.put(GlobalPresenter());

  @override
  void initState() {
    super.initState();
    // if (_presenter.isLoading.isTrue)
  }

  Future<void> onRefresh() {
    if (_presenter.checkRefresh() == false) return Future(() => null);
    return _presenter.fetchData(_presenter.weatherData.value.latitude!.value,
        _presenter.weatherData.value.longitude!.value);
  }

  @override
  Widget build(BuildContext context) {
    _presenter.width.value = MediaQuery.of(context).size.width;
    _presenter.isDark.value =
        Theme.of(context).colorScheme.brightness == Brightness.light
            ? false
            : true;
    return SafeArea(
      child: Scaffold(
        key: _presenter.scaffoldKey.value,
        drawer: const MyDrawer(),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => _presenter.saveWeatherData(),
        //   backgroundColor: Colors.blue.shade300,
        //   child: Icon(
        //     Icons.save,
        //     color: Colors.pink,
        //   ),
        // ),
        // body: Obx(() => Center(
        //     child: Text(
        //         'Connection Status: ${_presenter.isConnect.value}')),
        body: Obx(
          () => _presenter.isLoading.value || _presenter.nowCity.isFalse
              ? checkData()
              : RefreshIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                  onRefresh: () => onRefresh(),
                  child: _buildContent(),
                ),
        ),
      ),
    );
  }

  Widget checkData() {
    Widget widget = const Center(
      child: CircularProgressIndicator(color: Colors.blue),
    );
    if (_presenter.nowCity.isFalse) {
      widget = Center(
        child: Container(
          constraints: const BoxConstraints(maxHeight: 500),
          child: Column(
            children: [
              Image.asset('assets/icons/Ixon.png'),
              Text(
                'Weather',
                style: GoogleFonts.saira(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Theme.of(context).colorScheme.secondary),
              ),
              const SizedBox(
                height: 30,
              ),
              const Expanded(child: SearchLocation()),
            ],
          ),
        ),
      );
    }
    if (_presenter.isLoading.isTrue) {
          developer.log('----------------------');
      if (_presenter.weatherData.value
              .getIndexofDay(_presenter.currentTime.value) ==
          -1 && _presenter.getGeoLocatore()) {
          developer.log('getLocation');
        _presenter.getLocation();
      } else {
        developer.log('getNewLocation');
        _presenter.getNewLocation();
      }
    }

    if (_presenter.isConnect.value == false) {
      widget = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/no-internet1.png',
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: Text(
                  'No Connection..',
                  style: GoogleFonts.saira(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      );
    }

    return widget;
  }

  Widget _buildContent() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 600.0,
          maxHeight: MediaQuery.of(context).size.height - 25,
        ),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            const Header(),
            const CurrentWeather(),
            _presenter.showMore.isFalse
                ? const SizedBox(height: 270, child: DailyWeather())
                : Container(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
  }
}
