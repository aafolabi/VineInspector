import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'globals.dart';

class Utils {
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

  }

}
