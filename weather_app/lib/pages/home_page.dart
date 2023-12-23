import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/controller.dart';
import 'widgets/header.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalController _controller = Get.put(GlobalController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Obx(
        () => _controller.loading
            ? Center(
                child: CircularProgressIndicator(color: Colors.blue),
              )
            : Column(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () => _controller.switchTheme(),
                        icon: Icon(
                          Icons.dark_mode_outlined,
                          color: Theme.of(context).colorScheme.secondary,
                        )),
                  ),
                  const Header(),
                ],
              ),
      ),
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
