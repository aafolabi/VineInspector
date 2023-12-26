import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grapevine/dashboard/dashboard.dart';
import 'package:grapevine/onboarding/onboarding.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: 'GrapeVine',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
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