import 'package:flutter/material.dart';

import 'globals.dart';

class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color1,
      title: Text(
        app_title,
      ),
      centerTitle: true,
    );
  }
}
