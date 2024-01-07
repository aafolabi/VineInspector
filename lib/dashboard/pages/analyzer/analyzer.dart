import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grapevine/dashboard/pages/analyzer/custom_input.dart';
import 'package:grapevine/dashboard/pages/analyzer/custom_btn.dart';
import 'package:grapevine/globals.dart';
import 'package:grapevine/utils.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:date_time_picker/date_time_picker.dart';

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
                    initialLabelIndex: 0,
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
                      analyze();
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
                    initialLabelIndex: 0,
                    totalSwitches: 2,
                    labels: ['YES','NO'],
                    onToggle: (index) {
                      var value =  index == 0 ? 'yes' : 'no';
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
              initialLabelIndex: 0,
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
              initialLabelIndex: 0,
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
                  onSaved: (val) => codex.addAll({'qsix':val}),
            ),
            const SizedBox(
              height: 10,
            ),
            Text('Level of Incidence'),
            const SizedBox(
              height: 10,
            ),
            ToggleSwitch(
              initialLabelIndex: 0,
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

    }
  }
}