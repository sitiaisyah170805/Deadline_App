import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/analytics_screen.dart';
import 'screens/settings_screen.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() =>
      _NavigationMenuState();
}

class _NavigationMenuState
    extends State<NavigationMenu> {

  int selectedIndex = 0;

  final List<Widget> screens = const [

    HomeScreen(),
    CalendarScreen(),
    AnalyticsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: screens[selectedIndex],

      bottomNavigationBar: NavigationBar(

        selectedIndex: selectedIndex,

        onDestinationSelected: (index) {

          setState(() {
            selectedIndex = index;
          });
        },

        destinations: const [

          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          NavigationDestination(
            icon: Icon(Icons.calendar_month),
            label: "Calendar",
          ),

          NavigationDestination(
            icon: Icon(Icons.bar_chart),
            label: "Analytics",
          ),

          NavigationDestination(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}