import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/controller.dart';

class GetData extends StatefulWidget {
  const GetData({Key? key}) : super(key: key);

  @override
  _GetDataState createState() => _GetDataState();
}

class _GetDataState extends State<GetData> {
  final GlobalController _controller = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    if (_controller.isLoading.isTrue) _controller.getNewLocation();

    return const Center(
      child: CircularProgressIndicator(color: Colors.blue),
    );
  }
}
