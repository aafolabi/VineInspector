import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../globals.dart';

final List<String> imgList = [
  'assets/images/fullscreen.jpg',
  'assets/images/slider2.jpg',
  'assets/images/slider_3a_leafroll.jpg'
];

class Gallery extends StatelessWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color1,
        title: Text(
          app_title,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return CarouselSlider(
            options: CarouselOptions(
              height: height,
              viewportFraction: 1.0,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 500),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeFactor: 0.3,
              // onPageChanged: callbackFunction,
              scrollDirection: Axis.horizontal,
            ),
            items: imgList
                .map((item) => Container(
                      child: Center(
                          child: Image.asset(
                        item,
                        fit: BoxFit.cover,
                        height: height,
                      )),
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
