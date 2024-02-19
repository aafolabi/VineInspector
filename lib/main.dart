import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:VineInspector/dashboard/dashboard.dart';
import 'package:VineInspector/dashboard/pages/analyzer/snapmail.dart';
import 'package:VineInspector/onboarding/onboarding.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'globals.dart';
import 'package:camera/camera.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  runApp(const App());
}

// void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: app_title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/onboarding',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/onboarding':
            return PageTransition(
              child: const OnBoardingPage(),
              type: PageTransitionType.rightToLeftWithFade,
            );
            break;

          case '/dashboard':
            return PageTransition(
              child: const Dashboard(),
              type: PageTransitionType.rightToLeftWithFade,
            );
            break;

          case '/snapmail':
            return PageTransition(
              child: const SnapMail(),
              type: PageTransitionType.rightToLeftWithFade,
            );
            break;

          default:
            return null;
        }
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text("This is the screen after Introduction")),
    );
  }
}
