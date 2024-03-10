library grapevine_globals;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription>? cameras;
bool first_time = true;
String baseUrl = 'http://vineinspector.engyn.ng';

const color1 = Color(0xFF358856);
String app_title = "VineInspector";

String fontFamily1 = "circular-std";

double size1 = 18.0;

String email = "";

final global_codex = <String, dynamic>{};

double deviceWidth = 0;
double deviceHeight = 0;
