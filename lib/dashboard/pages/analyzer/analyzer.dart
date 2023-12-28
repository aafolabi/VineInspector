import 'package:flutter/material.dart';
import 'package:grapevine/dashboard/pages/analyzer/custom_input.dart';
import 'package:grapevine/dashboard/pages/analyzer/custom_btn.dart';


class Analyzer extends StatefulWidget {
  const Analyzer({Key? key}) : super(key: key);

  @override
  _AnalyzerState createState() => _AnalyzerState();
}

class _AnalyzerState extends State<Analyzer> {
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Stepper Widget ",
          ),
          centerTitle: true,
        ),
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Stepper(
              type: StepperType.horizontal,
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
      ),
    );
  }

  List<Step> getSteps() {
    return <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text("Account Info"),
        content: const Column(
          children: [
            CustomInput(
              hint: "First Name",
              inputBorder: OutlineInputBorder(),
            ),
            CustomInput(
              hint: "Last Name",
              inputBorder: OutlineInputBorder(),
            ),
          ],
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text("Address"),
        content: const Column(
          children: [
            CustomInput(
              hint: "City and State",
              inputBorder: OutlineInputBorder(),
            ),
            CustomInput(
              hint: "Postal Code",
              inputBorder: OutlineInputBorder(),
            ),
          ],
        ),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text("Misc"),
        content: const Column(
          children: [
            CustomInput(
              hint: "Bio",
              inputBorder: OutlineInputBorder(),
            ),
          ],
        ),

      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text("Misc"),
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
}