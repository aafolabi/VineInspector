import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../globals.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';


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



  getPermissions()async{
    var btp = await Permission.location.status;
    if (!btp.isGranted) {
      Permission.location.request();
    }

  }

  void _onIntroEnd(context) async {
    await getPermissions();

    final SharedPreferences prefs = await _prefs;
    first_time = prefs.getBool("first_time")!;
    if(first_time == true){
      //Collect user Email here and Save
      showDialog(
          context: context,
          builder: (BuildContext context) {
            var emailController = TextEditingController();
            return AlertDialog(
              scrollable: true,
              title: Text('Hello'),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: 'Enter your Email',
                          hintText: 'Enter your email Address',
                          icon: Icon(Icons.email),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                ElevatedButton(
                    child: Text("Submit"),
                    onPressed: () {
                      prefs.setBool("first_time", false);
                      prefs.setString("email", emailController.text)
                    })
              ],
            );
          });
    }

    email = prefs.getString("email")!;
    Navigator.pushReplacementNamed(context, '/dashboard');
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
              "Start Clean & Stay Clean to manage grapevine virus diseases\n\nPlant only certified virus-free vines, monitor and manage insect vectors",
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
              "A Virus-free vine is the most important investment that you can make during vineyard establishment",
          image: _buildImage('images/slider_4.jpg'),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 2,
            imageFlex: 3,
            safeArea: 100,
          ),
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back, color:color1),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600, color:color1)),
      next: const Icon(Icons.arrow_forward, color:color1),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600, color:color1)),
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