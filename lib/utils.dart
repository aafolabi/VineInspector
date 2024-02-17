import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'globals.dart';
import 'package:http/http.dart' as http;

class Utils {
  Future<http.Response?> apiRequest(
      String endpoint, String method, var body) async {
    var url = Uri.parse(baseUrl + endpoint);
    // var _headers = {"Authorization": token};
    Map<String, String> headers = {
      "Content-type": "application/x-www-form-urlencoded"
    };

    http.Response? res = null;
    try {
      if (method == "GET") {
        res = await http.get(url, headers: headers);
      } else if (method == "POST") {
        res = await http.post(url, headers: headers, body: body);
      } else if (method == "PUT") {
        res = await http.put(url, headers: headers, body: body);
      } else {
        res = await http.get(url, headers: headers);
      }
    } catch (ex) {
      print("PadrexReq: " + ex.toString());
    }
    return res;
  }

  void showToast(BuildContext context, var mssg) {
    Fluttertoast.showToast(
        msg: mssg.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: color1,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void showLongToast(BuildContext context, var mssg) {
    Fluttertoast.showToast(
        msg: mssg.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: color1,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  analyzer(dynamic codex) {
    if (codex['qone'] == 'white') {
      return 3;
    }
    return 0;
  }
}
