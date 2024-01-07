import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:grapevine/globals.dart';

// List<CameraDescription>? cameras;


class SnapMail extends StatefulWidget {
  // const SnapMail({Key? key, required this.title}) : super(key: key);
  const SnapMail({Key? key}) : super(key: key);
  // final String title;


  @override
  _SnapMailState createState() => _SnapMailState();
}

class _SnapMailState extends State<SnapMail> {
  CameraController? controller;
  String imagePath = "";

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras![1], ResolutionPreset.max);

    controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller!.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                width: 200,
                height: 200,
                child: AspectRatio(
                  aspectRatio: controller!.value.aspectRatio,
                  child: CameraPreview(controller!),
                ),
              ),
              TextButton(
                  onPressed: () async {
                    try {
                      final image = await controller!.takePicture();
                      setState(() {
                        imagePath = image.path;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text("Take Photo")),
              if (imagePath != "")
                Container(
                    width: 300,
                    height: 300,
                    child: Image.file(
                      File(imagePath),
                    ))
            ],
          ),
        ),
      ),
    );
  }
}