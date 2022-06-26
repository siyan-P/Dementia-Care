import 'package:flutter/material.dart';
import 'package:flutter_application_4/pages/screen_guidlines.dart';
import 'package:flutter_application_4/pages/screen_sympMain.dart';

class screen_symptoms extends StatefulWidget {
  const screen_symptoms({Key? key}) : super(key: key);

  @override
  State<screen_symptoms> createState() => _screen_symptomsState();
}

int _currentSelectedIndex = 0;
final _pages = [
  screen_sympMain(),
  screen_guidlines(),
];

class _screen_symptomsState extends State<screen_symptoms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(fontStyle: FontStyle.italic),
          currentIndex: _currentSelectedIndex,
          onTap: (newIndex) {
            setState(() {
              _currentSelectedIndex = newIndex;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.schema_rounded), label: "Symptoms"),
            BottomNavigationBarItem(
                icon: Icon(Icons.not_listed_location_outlined),
                label: "Guidlines"),
          ]),
      appBar: AppBar(),
      
    );
  }
}
