import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    if (_presenter.isLoading.isTrue) _presenter.getLocation();
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
        body: Obx(
          () => _presenter.isLoading.value || _presenter.nowCity.isFalse
              ? checkData()
              : RefreshIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                  onRefresh: () => onRefresh(),
                  child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: _buildContent()),
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
      _presenter.getNewLocation();
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
        child: Column(
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
