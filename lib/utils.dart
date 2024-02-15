import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'globals.dart';
import 'package:http/http.dart' as http;

class Utils {

  Future<http.Response> apiRequest(
      String endpoint, String method, var _body) async {

    var url = Uri.parse(baseUrl + endpoint);

    // var _headers = {"Authorization": token};
    Map<String, String> _headers = {"Content-type": "application/json"};

    http.Response res;
    try {
      if (method == "GET") {
        res = await http.get(url, headers: _headers);
      } else if(method=="POST"){
        res = await http.post(url, headers: _headers, body: jsonEncode(_body));
      }
      else if(method=="PUT"){
        res = await http.put(url, headers: _headers , body: jsonEncode(_body));
      }
      else{}
    } catch (ex) {
      print("PadrexReq: "+ex.toString());
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
        fontSize: 16.0
    );

  }

  void showLongToast(BuildContext context, var mssg) {
    Fluttertoast.showToast(
        msg: mssg.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: color1,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  analyzer(dynamic codex){
    if(codex['qone'] == 'white'){
      return 3;
    }
    return 0;

  }

}
