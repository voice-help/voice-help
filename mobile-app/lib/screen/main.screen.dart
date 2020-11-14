import 'package:flutter/material.dart';
import 'package:voicehelp/view/destination_view.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: IndexedStack(
          index: _currentIndex,
          children: destinations.map<Widget>((Destination destination) {
            return DestinationView(destination: destination);
          }).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.lightBlueAccent[100],
        fixedColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: destinations.map((Destination destination) {
          return BottomNavigationBarItem(
            icon: Icon(
              destination.icon,
              color: Colors.black,
            ),
            label: destination.label,
          );
        }).toList(),
      ),
    );
  }
}
