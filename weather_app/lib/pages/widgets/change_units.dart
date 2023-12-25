import 'package:flutter/material.dart';

final List<String> items = ['Metric', 'US', 'UK'];

class ChangeUnits extends StatefulWidget {
  const ChangeUnits({super.key});

  @override
  State<ChangeUnits> createState() => ChangeUnitsState();
}

class ChangeUnitsState extends State<ChangeUnits> {
  String _selectedMenu = items[0];


  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder:
          (BuildContext context, MenuController controller, Widget? child) {
        return Row(
          children: [
            Text(
              _selectedMenu,
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
            const SizedBox(width: 8), // Add spacing between icon and text
            IconButton(
              onPressed: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
              icon: Icon(Icons.more_horiz,
                  color: Theme.of(context).colorScheme.secondary),
              tooltip: 'Change Units',
            ),
          ],
        );
      },
      menuChildren: List<MenuItemButton>.generate(
        3,
        (int index) => MenuItemButton(
          onPressed: () =>
              setState(() => _selectedMenu = _selectedMenu[index]),
          child: Container(
            margin: const EdgeInsets.all(8.0), // Add margin here
            child: Text(items[index]),
          ),
        ),
      ),
    );
  }
}
