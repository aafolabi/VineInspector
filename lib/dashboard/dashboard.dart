import 'package:flutter/material.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';

class Dashboard extends StatefulWidget {
  ///
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  void changeTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
      // body: pages[_currentIndex],
        body: Text('My name is Samson'),
        bottomNavigationBar: ResponsiveNavigationBar(
          selectedIndex: _selectedIndex,
          onTabChange: changeTab,
          // showActiveButtonText: false,
          textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          navigationBarButtons: const <NavigationBarButton>[
            NavigationBarButton(
              text: 'Tab 1',
              icon: Icons.people,
              backgroundGradient: LinearGradient(
                colors: [Colors.yellow, Colors.green, Colors.blue],
              ),
            ),
            NavigationBarButton(
              text: 'Tab 2',
              icon: Icons.star,
              backgroundGradient: LinearGradient(
                colors: [Colors.cyan, Colors.teal],
              ),
            ),
            NavigationBarButton(
              text: 'Tab 3',
              icon: Icons.settings,
              backgroundGradient: LinearGradient(
                colors: [Colors.green, Colors.yellow],
              ),
            ),
          ],
        ),
      );
  }
}