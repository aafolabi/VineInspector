import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:VineInspector/globals.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils.dart';

Utils ut = Utils();

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  void initState() {
    super.initState();
  }

  getPermissions() async {
    var btp = await Permission.location.status;
    if (!btp.isGranted) {
      Permission.location.request();
    }
  }

  void _onIntroEnd(context) async {
    await getPermissions();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    first_time = prefs.getBool("first_time") ?? true;
    if (first_time == true) {
      print('The User is a First Timer');
      Navigator.pushReplacementNamed(context, '/signup');
      //Collect user Email here and Save
      // var message = '';
      // try {
      //   CoolAlert.show(
      //     context: context,
      //     type: CoolAlertType.custom,
      //     barrierDismissible: true,
      //     confirmBtnText: 'Save',
      //     widget: TextFormField(
      //       decoration: const InputDecoration(
      //         hintText: 'Enter Email Address',
      //         prefixIcon: Icon(
      //           Icons.email_outlined,
      //         ),
      //       ),
      //       textInputAction: TextInputAction.next,
      //       keyboardType: TextInputType.emailAddress,
      //       onChanged: (value) => message = value,
      //     ),
      //     closeOnConfirmBtnTap: false,
      //     onConfirmBtnTap: () async {
      //       prefs.setBool("first_time", false);
      //       prefs.setString("email", message);
      //       print('I am saved');
      //       print(prefs.toString());
      //       ut.showToast(context, 'Saved user details successfully');
      //       Navigator.of(context).pop();
      //     },
      //   );
      // } catch (e) {
      //   print('Exception showing toast: ' + e.toString());
      // }
    } else {
      print('User is not a FIRST TIMER');
      Navigator.pushReplacementNamed(context, '/dashboard');
    }

    // email = prefs.getString("email") ?? '';
    // Navigator.pushReplacementNamed(context, '/dashboard');
    // Navigator.pushNamed(context, '/dashboard');
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/images/fullscreen.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 450]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      infiniteAutoScroll: true,
      // globalHeader: Align(
      //   alignment: Alignment.topRight,
      //   child: SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.only(top: 16, right: 16),
      //       child: _buildImage('images/logo.png', 100),
      //     ),
      //   ),
      // ),
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color1,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          ),
          child: const Text(
            'Start Analysis',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () => _onIntroEnd(context),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Start and Stay Clean",
          body:
              "Start clean & stay clean to manage grapevine virus diseases\n\nPlant only certified virus-free vines, monitor and manage insect vectors",
          image: _buildFullscreenImage(),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 2,
            imageFlex: 3,
            safeArea: 100,
          ),
        ),
        PageViewModel(
          title: "Got Leaf Roll?",
          body:
              "Leaf rolls are destructive and can impact yield and fruit quality.",
          image: _buildImage('images/slider2.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Got Red Blotch?",
          body:
              "Red blotches are destructive and can impact yield and fruit quality.",
          image: _buildImage('images/slider_3a_leafroll.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Insect Vector",
          body:
              "The three-cornered alfalfa hopper is a vector for grapevine red blotch virus",
          image: _buildImage('images/slider_3b_red_blotch.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Virus-Free Vine",
          body:
              "A virus-free vine is the most important investment that you can make during vineyard establishment",
          image: _buildImage('images/slider_4.jpg'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back, color: color1),
      skip: const Text('Skip',
          style: TextStyle(fontWeight: FontWeight.w600, color: color1)),
      next: const Icon(Icons.arrow_forward, color: color1),
      done: const Text('Done',
          style: TextStyle(fontWeight: FontWeight.w600, color: color1)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: color1,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
