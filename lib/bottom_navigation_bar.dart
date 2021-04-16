import 'package:flutter/material.dart';
import 'package:app_demo_weva/screens/templates_screen.dart';
import 'package:app_demo_weva/screens/settings_screen.dart';

class Nav extends StatefulWidget {
  static String routeName = "/nav_bar";
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 1;
  List<Widget> _widgetOptions = <Widget>[
    Text('Videos Screen'),
    TemplatesScreen(),
    SettingsScreen(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.lightBlueAccent,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.video_settings,
            ),
            label: 'Videos',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_to_photos_outlined,
            ),
            label: 'Templates',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings_input_composite_outlined,
            ),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedFontSize: 13.0,
        unselectedFontSize: 13.0,
      ),
    );
  }
}