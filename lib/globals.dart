library grapevine_globals;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


bool first_time = true;
String baseUrl = 'https://padme-nwd6a.ondigitalocean.app/v1';

const color1 = Color(0xFF358856);
String app_title = "Grapevine";

String fontFamily1 = "circular-std";

double size1 = 18.0;

final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
String email = "";
String first_name = "";
String last_name = "";
String phone_number = "";

dynamic noChild;
dynamic myContacts=[noChild];
dynamic myRequests=[noChild];
dynamic myPeers=[noChild];

dynamic allRequests;
var peers;
String unique_id="";



double deviceWidth = 0;
double deviceHeight = 0;






