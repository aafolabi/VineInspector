import 'dart:async';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Loading extends StatefulWidget {
  final bool inAsyncCall;
  final Widget child;

  const Loading({super.key, required this.child, required this.inAsyncCall});

  @override
  LoadingState createState() => LoadingState();
}

class LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  bool visible = true;
  late Timer timer;

  @override
  initState() {
    super.initState();

    timer = Timer.periodic(new Duration(milliseconds: 600), (timer) {
      setState(() {
        visible = !visible;
      });
    });
  }

  @override
  dispose() {
    timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: widget.inAsyncCall,
        color: Colors.white.withOpacity(0.8),
        opacity: 1,
        progressIndicator: Container(
          width: MediaQuery.of(context).size.width * .35,
          child: Center(
              child: AnimatedOpacity(
            // child: Image(image: AssetImage('assets/images/logo.png')),
            duration: const Duration(milliseconds: 500),
            opacity: visible ? 1.0 : 0.3,
            child: const Image(image: AssetImage('assets/images/logo.png')),
            // child: const Icon(CupertinoIcons.waveform_path_badge_plus,size: 55.0,color:color1,),
          )),
        ),
        child: widget.child);
  }
}
