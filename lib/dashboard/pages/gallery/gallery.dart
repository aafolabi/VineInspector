import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import '../../../globals.dart';


class Gallery extends StatelessWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color1,
        title: Text(
          app_title,
        ),
        centerTitle: true,
      ),
        body: ImageSlideshow(
          indicatorColor: Colors.blue,
          onPageChanged: (value) {
            debugPrint('Page changed: $value');
          },
          autoPlayInterval: 3000,
          isLoop: true,
          children: [
            Image.asset(
              'images/slider1.jpg',
              fit: BoxFit.cover,
            ),
            Image.asset(
              'images/slider2.jpg',
              fit: BoxFit.cover,
            ),
            Image.asset(
              'images/slider_4.jpg',
              fit: BoxFit.cover,
            ),
          ],
        ),
    );
  }
}