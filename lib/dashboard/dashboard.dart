import 'package:VineInspector/dashboard/pages/about/about.dart';
import 'package:VineInspector/dashboard/pages/analyzer/analyzer.dart';
import 'package:VineInspector/dashboard/pages/gallery/gallery.dart';
import 'package:VineInspector/dashboard/pages/guide/guide.dart';
import 'package:flutter/material.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';

import '../globals.dart';

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

  static const pages = [Analyzer(), Guide(), Gallery(), About()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: pages[_selectedIndex],
      // body: Text('My name is Samson'),
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
            text: 'Analyser',
            icon: Icons.account_tree_rounded,
            backgroundColor: color1,
          ),
          NavigationBarButton(
            text: 'Tips',
            icon: Icons.book,
            backgroundColor: color1,
          ),
          NavigationBarButton(
            text: 'Gallery',
            icon: Icons.photo_album,
            backgroundColor: color1,
          ),
          NavigationBarButton(
            text: 'About',
            icon: Icons.info,
            backgroundColor: color1,
          ),
        ],
      ),
    );
  }
}
