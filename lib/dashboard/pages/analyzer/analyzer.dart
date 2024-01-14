
import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grapevine/dashboard/pages/analyzer/custom_input.dart';
import 'package:grapevine/dashboard/pages/analyzer/custom_btn.dart';
import 'package:grapevine/globals.dart';
import 'package:grapevine/utils.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mailer/smtp_server.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:mailer/mailer.dart';


Utils ut = Utils();

class Analyzer extends StatefulWidget {
  const Analyzer({Key? key}) : super(key: key);

  @override
  _AnalyzerState createState() => _AnalyzerState();
}

class _AnalyzerState extends State<Analyzer> {
  int currentStep = 0;
  final codex = <String, dynamic>{};
  final codex_array = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            app_title,
          ),
          centerTitle: true,
        ),
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Stepper(
              type: StepperType.vertical,
              currentStep: currentStep,
              onStepCancel: () => currentStep == 0
                  ? null
                  : setState(() {
                currentStep -= 1;
              }),
              onStepContinue: () {
                bool isLastStep = (currentStep == getSteps().length - 1);
                if (isLastStep) {
                  //Do something with this information
                } else {
                  setState(() {
                    currentStep += 1;
                  });
                }
              },
              onStepTapped: (step) => setState(() {
                currentStep = step;
              }),
              steps: getSteps(),

            )),
    );
  }

  List<Step> getSteps() {
    return <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text("Step 1"),
        content: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('What Type of Grape?'),
                  const SizedBox(
                    height: 10,
                  ),
                  ToggleSwitch(
                    initialLabelIndex: null,
                    totalSwitches: 2,
                    activeBgColors: [[Colors.green],[Colors.redAccent]],
                    // borderColor: [Colors.redAccent, Colors.white],
                    dividerColor: Colors.white,
                    curve: Curves.bounceInOut,
                    cornerRadius: 20.0,
                    radiusStyle: true,
                    labels: ['WHITE', 'RED',],
                    onToggle: (index) {
                      var value =  index == 0 ? 'white' : 'red';
                      codex.addAll({'qone':value});
                      // analyze();
                      if(index == 0) snapPhoto(context);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Is Harvesting Completed?'),
                  const SizedBox(
                    height: 10,
                  ),
                  ToggleSwitch(
                    initialLabelIndex: null,
                    totalSwitches: 2,
                    dividerColor: Colors.white,
                    curve: Curves.bounceInOut,
                    cornerRadius: 20.0,
                    radiusStyle: true,
                    labels: ['YES','NO'],
                    onToggle: (index) {
                      var value =  index == 0 ? 'yes' : 'no';
                      if(index == 0) snapPhoto(context);
                      codex.addAll({'qtwo':value});
                    },
                  ),
                ],
            ),
          ],
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text("Step 2"),
        content: Column(
          children: [
            Text('Pre Veraison?'),
            const SizedBox(
              height: 10,
            ),
            ToggleSwitch(
              initialLabelIndex: null,
              totalSwitches: 2,
              activeBgColors: [[Colors.green],[Colors.redAccent]],
              // borderColor: [Colors.redAccent, Colors.white],
              dividerColor: Colors.white,
              curve: Curves.bounceInOut,
              cornerRadius: 20.0,
              radiusStyle: true,
              labels: ['YES', 'NO',],
              onToggle: (index) {
                var value =  index == 0 ? 'yes' : 'no';
                codex.addAll({'qthree':value});
                if(index == 0) snapPhoto(context);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Text('Is this a recent observation?'),
            const SizedBox(
              height: 10,
            ),
            ToggleSwitch(
              initialLabelIndex: null,
              totalSwitches: 2,
              activeBgColors: [[Colors.green],[Colors.redAccent]],
              dividerColor: Colors.white,
              curve: Curves.bounceInOut,
              cornerRadius: 20.0,
              radiusStyle: true,
              labels: ['YES', 'NO',],
              onToggle: (index) {
                var value =  index == 0 ? 'yes' : 'no';
                codex.addAll({'qfour':value});
                if(index == 1) snapPhoto(context);
              },
            ),
          ],
        ),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text("Step 3"),
        content: Column(
          children: [
            Text('Capture Date'),
            const SizedBox(
              height: 10,
            ),
            DateTimePicker(
                initialValue: '',
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                dateLabelText: 'Date',
                onChanged: (val) => codex.addAll({'qfive':val}),
                validator: (val) {
                  print(val);
                  return null;
                },
                onSaved: (val) => codex.addAll({'qfive':val}),
            ),
            const SizedBox(
              height: 10,
            ),
            Text('When last were you on the field before this observation?'),
            DateTimePicker(
                  initialValue: '',
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  dateLabelText: 'Date',
                  onChanged: (val) => codex.addAll({'qsix':val}),
                  validator: (val) {
                    print(val);
                    return null;
                  },
                  onSaved: (val) {
                    codex.addAll({'qsix':val});
                    //Calculate D1-D2 here

                  }
            ),
            const SizedBox(
              height: 10,
            ),
            Text('Level of Incidence'),
            const SizedBox(
              height: 10,
            ),
            ToggleSwitch(
              initialLabelIndex: null,
              totalSwitches: 2,
              activeBgColors: [[Colors.green],[Colors.redAccent]],
              dividerColor: Colors.white,
              curve: Curves.bounceInOut,
              cornerRadius: 20.0,
              radiusStyle: true,
              labels: ['RANDOM PATCHES', 'UNIFORM',],
              onToggle: (index) {
                var value =  index == 0 ? 'random' : 'patches';
                codex.addAll({'qseven':value});
              },
            ),
          ],
        ),

      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text("Step 4"),
        content: Column(
          children: [
            CustomBtn(
              title: const Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
              callback: () {},
            )
          ],
        ),

      ),
    ];
  }

  void analyze(){
    int result = ut.analyzer(codex);
    if(result == 3){
      snapPhoto(context);
      // Navigator.pushReplacementNamed(context, '/snapmail');
    }
  }

  File? imageSelected;

  void snapPhoto(BuildContext context) async{
    await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 40,
        preferredCameraDevice: CameraDevice.rear).then((value) async {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: value!.path,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Edit Photo',
              toolbarColor: Colors.black,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(title: 'Edit Photo'),
          WebUiSettings(context: context),
        ],
      );

      if (croppedFile != null){
        imageSelected = File(croppedFile.path);
        sendEmail();
      }
      setState((){});
    });

  }

  sendEmail()  {
    const sender = "csamsonok@gmail.com";
    // final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    final smtpServer = SmtpServer('sandbox.smtp.mailtrap.io', username: "bdf0feede7016c", password: "c6219fe725e806");

    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(sender, 'GrapeVine App')
      ..recipients.add('afolabi.agbona@ag.tamu.edu')
      // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      // ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Grapevine Analysis :: 😀 :: ${DateTime.now()}'
      ..text = 'Hello, here is an image for.\nGrape vine LeafRoll Analysis.'
      // ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";
      ..attachments = [
        FileAttachment(imageSelected!)  //For Adding Attachments
          ..location = Location.inline
          ..cid = '<myimg@3.141>'
     ];

    try {
      final sendReport =  send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }

    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      text: "Unable to Send Image",
    );

    //reload page
    setState(() {
      codex.clear();
    });
  }
}