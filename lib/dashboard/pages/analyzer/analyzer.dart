import 'dart:convert';
import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:VineInspector/globals.dart';
import 'package:VineInspector/loading.dart';
import 'package:VineInspector/utils.dart';
import 'package:geocode/geocode.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:geolocator/geolocator.dart';

Utils ut = Utils();

class Analyzer extends StatefulWidget {
  const Analyzer({Key? key}) : super(key: key);

  @override
  _AnalyzerState createState() => _AnalyzerState();
}

class _AnalyzerState extends State<Analyzer> {
  int currentStep = 0;
  final codex = <String, dynamic>{};
  final codindex = <String, dynamic?>{};
  final codex_array = [null, null, null, null, null, null, null, null];
  String capture_date = '';
  String last_visit_date = '';
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Loading(
        inAsyncCall: loading,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: color1,
            title: Text(
              app_title,
              style: const TextStyle(color: Colors.white),
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
                // onStepTapped: (step) => setState(() {
                //   currentStep = step;
                // }),
                onStepTapped: (int index) {
                  if (currentStep != index) {
                    currentStep = currentStep;
                  }
                },
                controlsBuilder: (context, _) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // TextButton(
                      //   onPressed: (){},
                      //   child: const Text('NEXT'),
                      // ),
                      IconButton(
                        iconSize: 50,
                        icon: const Icon(
                          Icons.arrow_back,
                        ),
                        color: color1,
                        // the method which is called
                        // when button is pressed
                        onPressed: () => currentStep == 0
                            ? null
                            : setState(() {
                                currentStep -= 1;
                              }),
                      ),
                      // SizedBox used as the separator
                      const SizedBox(
                        width: 80,
                      ),
                      IconButton(
                        iconSize: 50,
                        icon: const Icon(
                          Icons.arrow_forward,
                        ),
                        color: color1,
                        onPressed: () {
                          bool valid = validateInput(currentStep);
                          if (valid) {
                            bool isLastStep =
                                (currentStep == getSteps().length - 1);
                            if (isLastStep) {
                              //Do something with this information
                            } else {
                              setState(() {
                                currentStep += 1;
                              });
                            }
                          } else {
                            ut.showLongToast(context, "Please Select a Value");
                          }
                        },
                      ),
                    ],
                  );
                },

                steps: getSteps(),
              )),
        ));
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
                Text('What type of grape?'),
                const SizedBox(
                  height: 10,
                ),
                ToggleSwitch(
                  initialLabelIndex: codindex['qone'],
                  totalSwitches: 2,
                  activeBgColors: [
                    [Colors.green],
                    [Colors.redAccent]
                  ],
                  // borderColor: [Colors.redAccent, Colors.white],
                  dividerColor: Colors.white,
                  curve: Curves.bounceInOut,
                  cornerRadius: 20.0,
                  radiusStyle: true,
                  labels: [
                    'WHITE',
                    'RED',
                  ],
                  onToggle: (index) {
                    var value = index == 0 ? 'white' : 'red';
                    codex.addAll({'qone': value});
                    codindex.addAll({'qone': index});
                    if (index == 0) processWhiteGrape(context);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('Is harvesting completed?'),
                const SizedBox(
                  height: 10,
                ),
                ToggleSwitch(
                  initialLabelIndex: codindex['qtwo'],
                  totalSwitches: 2,
                  dividerColor: Colors.white,
                  curve: Curves.bounceInOut,
                  cornerRadius: 20.0,
                  radiusStyle: true,
                  labels: ['YES', 'NO'],
                  onToggle: (index) {
                    var value = index == 0 ? 'yes' : 'no';
                    if (index == 0) snapPhotoConfirm(context);
                    codex.addAll({'qtwo': value});
                    codindex.addAll({'qtwo': index});
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
              initialLabelIndex: codindex['qthree'],
              totalSwitches: 2,
              activeBgColors: const [
                [Colors.green],
                [Colors.redAccent]
              ],
              // borderColor: [Colors.redAccent, Colors.white],
              dividerColor: Colors.white,
              curve: Curves.bounceInOut,
              cornerRadius: 20.0,
              radiusStyle: true,
              labels: const [
                'YES',
                'NO',
              ],
              onToggle: (index) {
                var value = index == 0 ? 'yes' : 'no';
                codex.addAll({'qthree': value});
                codindex.addAll({'qthree': index});
                if (index == 0) snapPhotoConfirm(context);
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
              initialLabelIndex: codindex['qfour'],
              totalSwitches: 2,
              activeBgColors: [
                [Colors.green],
                [Colors.redAccent]
              ],
              dividerColor: Colors.white,
              curve: Curves.bounceInOut,
              cornerRadius: 20.0,
              radiusStyle: true,
              labels: [
                'YES',
                'NO',
              ],
              onToggle: (index) {
                var value = index == 0 ? 'yes' : 'no';
                codex.addAll({'qfour': value});
                codindex.addAll({'qfour': index});
                if (index == 1) snapPhotoConfirm(context);
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
            Text('Observation Date'),
            const SizedBox(
              height: 10,
            ),
            DateTimePicker(
              initialValue: codindex['qfive'],
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              dateLabelText: 'Date',
              onChanged: (val) {
                codex.addAll({'qfive': val});
                codindex.addAll({'qfive': val});
                capture_date = val;
              },
              // onChanged: (val) => codex.addAll({'qfive':val}),
              validator: (val) {
                print(val);
                return null;
              },
              onSaved: (val) => codex.addAll({'qfive': val}),
            ),
            const SizedBox(
              height: 10,
            ),
            Text('When last were you on the field before this observation?'),
            DateTimePicker(
                initialValue: codindex['qsix'],
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                dateLabelText: 'Date',
                onChanged: (val) {
                  codex.addAll({'qsix': val});
                  codindex.addAll({'qsix': val});
                  DateTime last_visit_date_x = DateTime.parse(val);
                  DateTime capture_date_x = DateTime.parse(capture_date);
                  if (capture_date_x != null && last_visit_date_x != null) {
                    int diff =
                        capture_date_x.difference(last_visit_date_x).inDays;
                    if (diff <= 2) {
                      showLowLikely();
                    }
                  }
                },
                // onChanged: (val) => codex.addAll({'qsix':val}),
                validator: (val) {
                  print(val);
                  return null;
                },
                onSaved: (val) {
                  codex.addAll({'qsix': val});
                  //Calculate D1-D2 here
                }),
          ],
        ),
      ),
      Step(
        state: currentStep > 3 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 3,
        title: const Text("Step 4"),
        content: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text('Disease pattern in the vineyard'),
            const SizedBox(
              height: 10,
            ),
            ToggleSwitch(
              initialLabelIndex: codindex['qseven'],
              totalSwitches: 2,
              minWidth: 120.0,
              activeBgColors: [
                [Colors.green],
                [Colors.redAccent]
              ],
              dividerColor: Colors.white,
              curve: Curves.bounceInOut,
              cornerRadius: 20.0,
              radiusStyle: true,
              labels: [
                'RANDOM PATCHES',
                'UNIFORM',
              ],
              onToggle: (index) {
                var value = index == 0 ? 'random' : 'patches';
                codex.addAll({'qseven': value});
                codindex.addAll({'qseven': index});
                if (index == 0) {
                  showDisease();
                }
              },
            ),
          ],
        ),
      ),
      Step(
        state: currentStep > 4 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 4,
        title: const Text("Step 5"),
        content: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text('Source of Planting Materials'),
            const SizedBox(
              height: 10,
            ),
            ToggleSwitch(
              initialLabelIndex: codindex['qeight'],
              totalSwitches: 2,
              minWidth: 90.0,
              activeBgColors: [
                [Colors.green],
                [Colors.redAccent]
              ],
              dividerColor: Colors.white,
              curve: Curves.bounceInOut,
              cornerRadius: 20.0,
              radiusStyle: true,
              labels: [
                'CLEAN',
                'OTHERS',
              ],
              onToggle: (index) {
                var value = index == 0 ? 'clean' : 'others';
                codex.addAll({'qeight': value});
                codindex.addAll({'qeight': index});
                if (index == 0) {
                  showLowLikely();
                } else {
                  showDisease();
                }
              },
            ),
          ],
        ),
      ),
    ];
  }

  void processWhiteGrape(BuildContext context) {
    // sendEmail();
    CoolAlert.show(
        context: context,
        type: CoolAlertType.confirm,
        text:
            'I\'m currently not trained on white grape diagnosis, click on OK to send a picture to an expert',
        confirmBtnText: 'OK',
        cancelBtnText: 'CANCEL',
        confirmBtnColor: Colors.green,
        closeOnConfirmBtnTap: true,
        onConfirmBtnTap: () async {
          snapPhoto(context);
        },
        onCancelBtnTap: () async {
          setState(() {});
        });
  }

  void analyze() {
    int result = ut.analyzer(codex);
    if (result == 3) {
      snapPhotoConfirm(context);
    }
  }

  late File imageSelected;

  void snapPhotoConfirm(BuildContext context) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.confirm,
        text: 'Take a picture of the vine.\n\nPress OK to Proceed',
        confirmBtnText: 'OK',
        cancelBtnText: 'CANCEL',
        confirmBtnColor: Colors.green,
        closeOnConfirmBtnTap: true,
        onConfirmBtnTap: () async {
          snapPhoto(context);
        },
        onCancelBtnTap: () async {
          setState(() {});
        });
  }

  void snapPhoto(BuildContext context) async {
    await ImagePicker()
        .pickImage(
            source: ImageSource.camera,
            imageQuality: 40,
            preferredCameraDevice: CameraDevice.rear)
        .then((value) async {
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

      if (croppedFile != null) {
        imageSelected = File(croppedFile.path);
        sendEmail();
      }
      setState(() {
        codindex.clear();
      });
    });
  }

  Position? _currentPosition;

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future sendEmail() async {
    setState(() {
      loading = true;
    });

    try {
      await _getCurrentPosition();
      List<int> fileInByte = imageSelected.readAsBytesSync();
      String fileInBase64 = base64Encode(fileInByte);
      double latitude = 0;
      double longitude = 0;
      String address = '';
      final currentPosition = _currentPosition;
      if (currentPosition != null) {
        latitude = currentPosition.latitude;
        longitude = currentPosition.longitude;
        final currentAddress = await GeoCode().reverseGeocoding(
            latitude: currentPosition.latitude,
            longitude: currentPosition.longitude);
        address =
            "${currentAddress.streetNumber}, ${currentAddress.streetAddress}, ${currentAddress.city}, ${currentAddress.region}, ${currentAddress.countryCode}, ${currentAddress.postal}";
      } else {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text:
              "Unable to fetch location data\n\nPlease enable location on your device\nand try again",
        );
        setState(() {
          loading = false;
          codex.clear();
        });
        return;
      }

      var body = {
        "email": email,
        "latitude": latitude,
        "longitude": longitude,
        "file": fileInBase64,
        "address": address,
      };

      http.Response response = await ut.apiRequest("/mail.php", "POST", body);

      Map resp = json.decode(response.body.toString());
      if (resp['code'] == 200) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: "Sample Submitted Successfully",
        );
      } else {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "Sample could not be Submitted, Please try again",
        );
      }
    } catch (e, stacktrace) {
      ut.showToast(context, "Error Sending Mail, Please try again");
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: e.toString() + stacktrace.toString());
      print("PadrEx " + e.toString());
    }

    //reload page
    setState(() {
      loading = false;
      codex.clear();
    });
  }

  showLowLikely() {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.info,
        text: ' Disease Unlikely, check for Nutrient Deficiency');
    setState(() {
      codex.clear();
    });
  }

  showDisease() {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.info,
        title: 'Oops',
        text: 'Possible case of disease, vine testing recommended');
    setState(() {
      codex.clear();
    });

    //There should be a mail sent to the expert with this message after OK button is filled
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));

      await Geolocator.openAppSettings();
      await Geolocator.openLocationSettings();
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  validateInput(currentStep) {
    if (currentStep == 0) {
      if (codex["qone"] == null || codex["qtwo"] == null) {
        return false;
      }
    } else if (currentStep == 1) {
      if (codex["qthree"] == null || codex["qfour"] == null) {
        return false;
      }
    } else if (currentStep == 2) {
      if (codex["qfive"] == null || codex["qsix"] == null) {
        return false;
      }
    } else if (currentStep == 3) {
      if (codex["qseven"] == null) {
        return false;
      }
    } else if (currentStep == 4) {
      if (codex["qeight"] == null) {
        return false;
      }
    } else {}

    return true;
  }
}
